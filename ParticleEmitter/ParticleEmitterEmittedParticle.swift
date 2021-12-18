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
	struct EmittedParticle {
		let emittedAt: Date
		let expiration: Date
		
		var position: CGPoint
		var velocity: CGVector = .zero
		
		var rotation: Angle = .zero
		var rotationSpeed: Angle = .zero
		
		var scale: CGFloat = 1
		var scaleSpeed: CGFloat = 0
	}
}
