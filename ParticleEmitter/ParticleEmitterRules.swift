//
//  ParticleEmitterEmissionRules.swift
//  ParticleEmitter
//
//  Created by Emilio Peláez on 18/12/21.
//

import CGMath
import CoreGraphics
import Foundation
import SwiftUI

extension ParticleEmitter {
	struct Rules {
		let images: [Image]
		var newImageIndex: Int {
			.random(in: 0 ..< images.count)
		}
		
		let colors: [Color]
		var newColorIndex: Int {
			.random(in: 0 ..< colors.count)
		}

		let matchImagesAndColors: Bool
		
		let lifetime: TimeInterval
		let lifetimeVariation: TimeInterval
		var newLifetime: TimeInterval { randomScalar(base: lifetime, variation: lifetimeVariation) }
		
		let emissionSource: Source
		func newPosition(with size: CGSize) -> CGPoint {
			switch emissionSource {
			case .canvas:
				return CGPoint(x: CGFloat.random(in: 0 ... 1), y: CGFloat.random(in: 0 ... 1))
			case let .point(point): return point
			case let .horizontalLine(offset):
				return CGPoint(x: .random(in: 0 ... 1), y: offset)
			case let .verticalLine(offset):
				return CGPoint(x: offset, y: .random(in: 0 ... 1))
			case let .area(rect):
				return rect.origin + CGPoint(x: .random(in: 0 ... rect.width), y: .random(in: 0 ... rect.height))
			case let .custom(generator):
				return generator(size)
			}
		}
		
		let opacity: ParticleOpacity
		
		let velocity: CGVector
		let velocityVariation: CGVector
		var newVelocity: CGVector {
			let speedX = randomScalar(base: velocity.dx, variation: velocityVariation.dx)
			let speedY = randomScalar(base: velocity.dy, variation: velocityVariation.dy)
			return CGVector(dx: speedX, dy: speedY)
		}
		
		let rotation: Angle
		let rotationVariation: Angle
		var newRotation: Angle {
			Angle(degrees: randomScalar(base: rotation.degrees, variation: rotationVariation.degrees))
		}
		
		let rotationSpeed: Angle
		let rotationSpeedVariation: Angle
		var newRotationSpeed: Angle {
			Angle(degrees: randomScalar(base: rotationSpeed.degrees, variation: rotationSpeedVariation.degrees))
		}
		
		let scale: CGFloat
		let scaleVariation: CGFloat
		var newScale: CGFloat { randomScalar(base: scale, variation: scaleVariation) }
		
		let scaleSpeed: CGFloat
		let scaleSpeedVariation: CGFloat
		var newScaleSpeed: CGFloat { randomScalar(base: scaleSpeed, variation: scaleSpeedVariation) }
		
		private func randomScalar(base: CGFloat, variation: CGFloat) -> CGFloat {
			guard variation > 0 else { return base }
			return base + .random(in: 0 ... variation) * randomSign()
		}
		
		private func randomSign() -> CGFloat {
			Bool.random() ? 1 : -1
		}
		
		init(images: [Image] = [Image(systemName: "star.fill")],
		     colors: [Color] = [.primary],
		     matchImagesAndColors: Bool = false,
		     lifetime: TimeInterval = 1,
		     lifetimeVariation: TimeInterval = 0,
		     emissionSource: Source = .canvas,
		     opacity: ParticleOpacity = .fadeInOut(duration: 0.15),
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
			self.images = images
			self.colors = colors
			
			self.matchImagesAndColors = matchImagesAndColors
			
			self.emissionSource = emissionSource
			
			self.lifetime = lifetime
			self.lifetimeVariation = lifetimeVariation
			
			self.opacity = opacity
			
			self.velocity = speed
			self.velocityVariation = speedVariation
			
			self.rotation = rotation
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
