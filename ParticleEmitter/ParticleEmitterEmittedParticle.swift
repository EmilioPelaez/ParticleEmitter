//
//  ParticleEmitterEmittedParticle.swift
//  ParticleEmitter
//
//  Created by Emilio Peláez on 18/12/21.
//

import CoreGraphics
import Foundation
import SwiftUI

extension ParticleEmitter {
	class EmittedParticle {
		let emittedAt: Date
		let expiration: Date
		
		var position: CGPoint
		var velocity: CGVector
		
		var rotation: Angle
		var rotationSpeed: Angle
		
		var scale: CGFloat
		var scaleSpeed: CGFloat
		
		init(emittedAt: Date, expiration: Date, position: CGPoint, velocity: CGVector, rotation: Angle, rotationSpeed: Angle, scale: CGFloat, scaleSpeed: CGFloat) {
			self.emittedAt = emittedAt
			self.expiration = expiration
			self.position = position
			self.velocity = velocity
			self.rotation = rotation
			self.rotationSpeed = rotationSpeed
			self.scale = scale
			self.scaleSpeed = scaleSpeed
		}
	}
}
