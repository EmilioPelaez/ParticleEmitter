//
//  ParticleEmitterEmissionRules.swift
//  ParticleEmitter
//
//  Created by Emilio Peláez on 18/12/21.
//

import CoreGraphics
import Foundation
import SwiftUI

extension ParticleEmitter {
	struct EmissionRules {
		let lifetime: TimeInterval
		let lifetimeVariation: TimeInterval
		
		let emissionArea: CGRect
		
		let speed: CGVector
		let speedVariation: CGVector
		
		let rotation: Angle
		let rotationVariation: Angle
		
		let rotationSpeed: Angle
		let rotationSpeedVariation: Angle
		
		let scale: CGFloat
		let scaleVariation: CGFloat
		
		let scaleSpeed: CGFloat
		let scaleSpeedVariation: CGFloat
		
		init(
			lifetime: TimeInterval,
			lifetimeVariation: TimeInterval = 0,
			source: EmissionSource = .canvas,
			speed: CGVector = .zero,
			speedVariation: CGVector = .zero,
			rotation: Angle = .zero,
			rotationVariation: Angle = .zero,
			rotationSpeed: Angle = .zero,
			rotationSpeedVariation: Angle = .zero,
			scale: CGFloat = 1,
			scaleVariation: CGFloat = 0,
			scaleSpeed: CGFloat = 0,
			scaleSpeedVariation: CGFloat = 0) {
				self.emissionArea = source.emissionArea
				
				self.lifetime = lifetime
				self.lifetimeVariation = lifetimeVariation
				
				self.speed = speed
				self.speedVariation = speedVariation
				
				self.rotation = rotationVariation
				self.rotationVariation = rotationVariation
				
				self.rotationSpeed = rotationSpeed
				self.rotationSpeedVariation = rotationSpeedVariation
				
				self.scale = scale
				self.scaleVariation = scaleVariation
				
				self.scaleSpeed = scaleSpeed
				self.scaleSpeedVariation = scaleSpeedVariation
			}
	}
}
