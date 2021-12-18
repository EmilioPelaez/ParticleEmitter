//
//  ParticleEmitterEmissionRule.swift
//  ParticleEmitter
//
//  Created by Emilio Peláez on 18/12/21.
//

import CoreGraphics
import Foundation

extension ParticleEmitter {
	/// All values should be in the [0,1] range
	enum EmissionSource {
		case canvas
		case point(CGPoint)
		///	offset determines the Y position
		case horizontalLine(offset: CGFloat)
		///	offset determines the X position
		case verticalLine(offset: CGFloat)
		case area(CGRect)
	}
}

extension ParticleEmitter.EmissionSource {
	var emissionArea: CGRect {
		switch self {
		case .canvas: return CGRect(x: 0, y: 0, width: 1, height: 1)
		case let .point(origin): return CGRect(origin: origin, size: .zero)
		case let .horizontalLine(offset): return CGRect(x: 0, y: offset, width: 1, height: 0)
		case let .verticalLine(offset): return CGRect(x: offset, y: 0, width: 0, height: 1)
		case let .area(rect): return rect
		}
	}
}
