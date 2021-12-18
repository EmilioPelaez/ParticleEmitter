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
		let runMode: RunMode
		
		var initialEmittionDone = false
		let emissionArea: CGRect
		var emissionThreshold: TimeInterval?
		
		var lastUpdate: Date
		var particles: [EmittedParticle] = []
		
		init(runMode: RunMode, emissionSource: EmissionSource) {
			self.runMode = runMode
			
			self.emissionArea = emissionSource.emissionArea
			if let rate = runMode.rate, rate > 0 {
				emissionThreshold = 1 / TimeInterval(rate)
			}
			
			self.lastUpdate = Date()
		}
		
		func tick(date: Date, canvasSize: CGSize) {
			if !initialEmittionDone {
				emitStartingParticles(canvasSize: canvasSize)
				initialEmittionDone = true
			}
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
		
		private func emitStartingParticles(canvasSize: CGSize) {
			(0..<runMode.initialParticleAmount).forEach { _ in
				emitParticle(canvasSize: canvasSize)
			}
		}
		
		private func deleteParticles(on date: Date) {
			particles = particles.filter { $0.expiration < date }
		}
		
		private var aggregationTimer: TimeInterval = 0
		private func emitParticles(_ delta: TimeInterval, canvasSize: CGSize) {
			guard let emissionThreshold = emissionThreshold else { return }
			aggregationTimer += delta
			while aggregationTimer > emissionThreshold {
				emitParticle(canvasSize: canvasSize)
				aggregationTimer -= emissionThreshold
			}
		}
		
		private func emitParticle(canvasSize: CGSize) {
			
		}
		
		private func updateParticle(_ particle: EmittedParticle, delta: TimeInterval, canvasSize: CGSize) {
			
		}
		
	}
}
