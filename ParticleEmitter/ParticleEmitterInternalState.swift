//
//  ParticleEmitterInternalState.swift
//  ParticleEmitter
//
//  Created by Emilio Peláez on 18/12/21.
//

import CoreGraphics
import Foundation

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
			update(date: date, delta: delta, canvasSize: canvasSize)
			lastUpdate = date
		}
		
		private func update(date: Date, delta: TimeInterval, canvasSize: CGSize) {
			deleteParticles(on: date)
			emitParticles(delta, canvasSize: canvasSize)
			for particle in particles {
				updateParticle(particle, delta: delta, canvasSize: canvasSize)
			}
		}
		
		private func emitStartingParticles() {
			(0..<runMode.initialParticleAmount).forEach { _ in
				emitParticle()
			}
		}
		
		private func deleteParticles(on date: Date) {
			particles = particles.filter { $0.expiration < date }
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
			let lifetime = emissionRules.lifetime + .random(in: -emissionRules.lifetimeVariation...emissionRules.lifetimeVariation)
//			let particle = EmittedParticle(emittedAt: lastUpdate,
//																		 expiration: <#T##Date#>,
//																		 position: <#T##CGPoint#>,
//																		 velocity: <#T##CGVector#>,
//																		 rotation: <#T##Angle#>,
//																		 rotationSpeed: <#T##Angle#>,
//																		 scale: <#T##CGFloat#>,
//																		 scaleSpeed: <#T##CGFloat#>)
		}
		
		private func updateParticle(_ particle: EmittedParticle, delta: TimeInterval, canvasSize: CGSize) {
			
		}
		
	}
}
