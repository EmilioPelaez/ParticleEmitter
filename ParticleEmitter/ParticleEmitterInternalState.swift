//
//  ParticleEmitterInternalState.swift
//  ParticleEmitter
//
//  Created by Emilio Peláez on 18/12/21.
//

import CGMath
import CoreGraphics
import Foundation
import SwiftUI

extension ParticleEmitter {
	class InternalState {
		enum EmitterMode: Equatable {
			case disabled
			case threshold(TimeInterval, maximum: Int)
			case targetAmount(Int)
		}
		
		let runMode: RunMode
		let emissionRules: EmissionRules
		let emitterMode: EmitterMode
		
		let deadline: Date
		let completion: (() -> Void)
		
		var lastUpdate: Date
		var fps: Int = 0
		var particles: [EmittedParticle] = []
		var isFinished = false
		
		init(runMode: RunMode, emissionRules: EmissionRules) {
			self.runMode = runMode
			self.emissionRules = emissionRules
			
			switch runMode {
			case let .infinite(.fixed(targetAmount)):
				self.emitterMode = .targetAmount(targetAmount)
				self.deadline = .distantFuture
				self.completion = {}
			case let .infinite(.variable(_, rate, maximum)):
				self.emitterMode = .threshold(1 / TimeInterval(rate), maximum: maximum)
				self.deadline = .distantFuture
				self.completion = {}
			case let .once(_, completion):
				self.emitterMode = .disabled
				self.deadline = .distantFuture
				self.completion = completion
			case let .timed(timeInterval, .fixed(targetAmount), completion):
				self.emitterMode = .targetAmount(targetAmount)
				self.deadline = Date().addingTimeInterval(timeInterval)
				self.completion = completion
			case let .timed(timeInterval, .variable(_, rate, maximum), completion):
				self.emitterMode = .threshold(1 / TimeInterval(rate), maximum: maximum)
				self.deadline = Date().addingTimeInterval(timeInterval)
				self.completion = completion
			}
			
			self.lastUpdate = Date()
			
			emitStartingParticles()
		}
		
		func tick(date: Date, canvasSize: CGSize) {
			guard !isFinished else { return }
			let delta = date.timeIntervalSince(lastUpdate)
			guard delta > 0 else { return }
			fps = Int(1 / delta)
			update(date: date, delta: delta, canvasSize: canvasSize)
			lastUpdate = date
			
			if isFinished {
				DispatchQueue.main.async(execute: completion)
			}
		}
		
		private func update(date: Date, delta: TimeInterval, canvasSize: CGSize) {
			emitParticles(delta, canvasSize: canvasSize)
			for particle in particles {
				updateParticle(particle, delta: delta, canvasSize: canvasSize)
			}
			removeParticles(on: date)
		}
		
		private func emitStartingParticles() {
			(0..<runMode.initialParticleAmount).forEach { _ in
				emitParticle()
			}
		}
		
		private func removeParticles(on date: Date) {
			particles = particles.filter {
				$0.expiration > date && $0.scale > 0
			}
			guard particles.isEmpty else { return }
			if deadline < Date() || emitterMode == .disabled {
				isFinished = true
			}
		}
		
		private var aggregationTimer: TimeInterval = 0
		private func emitParticles(_ delta: TimeInterval, canvasSize: CGSize) {
			guard deadline > Date() else { return }
			switch emitterMode {
			case let .threshold(threshold, maximum):
				aggregationTimer += delta
				while particles.count < maximum && aggregationTimer > threshold {
					emitParticle()
					aggregationTimer -= threshold
				}
			case let .targetAmount(amount):
				while particles.count < amount {
					emitParticle()
				}
			case .disabled: break
			}
		}
		
		private func emitParticle() {
			let particle = EmittedParticle(emittedAt: lastUpdate,
																		 expiration: lastUpdate.addingTimeInterval(emissionRules.newLifetime),
																		 position: emissionRules.newPosition,
																		 velocity: emissionRules.newVelocity,
																		 rotation: emissionRules.newRotation,
																		 rotationSpeed: emissionRules.newRotationSpeed,
																		 scale: emissionRules.newScale,
																		 scaleSpeed: emissionRules.newScaleSpeed)
			particles.append(particle)
		}
		
		private func updateParticle(_ particle: EmittedParticle, delta: TimeInterval, canvasSize: CGSize) {
			let movement = CGPoint(x: particle.velocity.dx / canvasSize.width,
														 y: particle.velocity.dy / canvasSize.height)
			particle.position = particle.position + movement * delta
			particle.rotation += particle.rotationSpeed * delta
			particle.scale += particle.scaleSpeed * delta
		}
		
	}
}
