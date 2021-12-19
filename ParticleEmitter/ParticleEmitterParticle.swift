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
	class Particle {
		let imageIndex: Int
		let colorIndex: Int
		
		let emittedAt: Date
		let expiration: Date
		
		var opacity: CGFloat
		
		var position: CGPoint
		var velocity: CGVector
		
		var rotation: Angle
		var rotationSpeed: Angle
		
		var scale: CGFloat
		var scaleSpeed: CGFloat
		
		init(imageIndex: Int,
		     colorIndex: Int,
		     emittedAt: Date,
		     expiration: Date,
		     opacity: CGFloat,
		     position: CGPoint,
		     velocity: CGVector,
		     rotation: Angle,
		     rotationSpeed: Angle,
		     scale: CGFloat,
		     scaleSpeed: CGFloat) {
			self.imageIndex = imageIndex
			self.colorIndex = colorIndex
			self.emittedAt = emittedAt
			self.expiration = expiration
			self.opacity = opacity
			self.position = position
			self.velocity = velocity
			self.rotation = rotation
			self.rotationSpeed = rotationSpeed
			self.scale = scale
			self.scaleSpeed = scaleSpeed
		}
	}
}
