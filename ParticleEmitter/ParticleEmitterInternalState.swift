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
		enum EmitterMode {
			case disabled
			case threshold(TimeInterval)
			case targetAmount(Int)
		}
		
		let runMode: RunMode
		
		let emissionRules: EmissionRules
		let emitterMode: EmitterMode
		
		var lastUpdate: Date
		var fps: Int = 0
		var particles: [EmittedParticle] = []
		
		init(runMode: RunMode, emissionRules: EmissionRules) {
			self.runMode = runMode
			
			self.emissionRules = emissionRules
			if let rate = runMode.rate, rate > 0 {
				emitterMode = .threshold(1 / TimeInterval(rate))
			} else if let targetAmount = runMode.targetAmount {
				emitterMode = .targetAmount(targetAmount)
			} else {
				emitterMode = .disabled
			}
			
			self.lastUpdate = Date()
			
			emitStartingParticles()
		}
		
		func tick(date: Date, canvasSize: CGSize) {
			let delta = date.timeIntervalSince(lastUpdate)
			guard delta > 0 else { return }
			fps = Int(1 / delta)
			update(date: date, delta: delta, canvasSize: canvasSize)
			lastUpdate = date
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
		}
		
		private var aggregationTimer: TimeInterval = 0
		private func emitParticles(_ delta: TimeInterval, canvasSize: CGSize) {
			switch emitterMode {
			case let .threshold(threshold):
				aggregationTimer += delta
				while aggregationTimer > threshold {
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
