//
//  ParticleEmitterEmissionRule.swift
//  ParticleEmitter
//
//  Created by Emilio Peláez on 18/12/21.
//

import CoreGraphics
import Foundation

/// All values should be in the [0,1] range
enum EmissionSource {
	case canvas
	case point(CGPoint)
	///	offset determines the Y position
	case horizontalLine(offset: CGFloat)
	///	offset determines the X position
	case verticalLine(offset: CGFloat)
	case area(CGRect)
	///	A closure receiving the current size of the canvas,
	///	which returns a normalized position
	case custom((CGSize) -> CGPoint)
}
