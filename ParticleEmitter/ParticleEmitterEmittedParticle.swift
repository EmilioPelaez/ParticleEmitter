//
//  ParticleEmitterEmittedParticle.swift
//  ParticleEmitter
//
//  Created by Emilio Peláez on 18/12/21.
//

import CoreGraphics
import Foundation

extension ParticleEmitter {
	struct EmittedParticle {
		let emittedAt: Date
		let expiration: Date
		
		var position: CGPoint
		var velocity: CGVector
	}
}
