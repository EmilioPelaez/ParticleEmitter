//
//  ParticleOpacity.swift
//  ParticleEmitter
//
//  Created by Emilio Peláez on 19/12/21.
//

import CGMath
import CoreGraphics

enum ParticleOpacity {
	case constant(opacity: CGFloat)
	case fadeIn(duration: CGFloat)
	case fadeOut(duration: CGFloat)
	case fadeInOut(duration: CGFloat)
	
	func opacity(at progress: CGFloat) -> CGFloat {
		switch self {
		case .constant(let opacity):
			return opacity
		case .fadeIn(let duration):
			if progress < duration {
				return progress.remap(from: (0, duration), to: (0, 1))
			} else {
				return 1
			}
		case .fadeOut(let duration):
			if progress > 1 - duration {
				return progress.remap(from: (1 - duration, 1), to: (1, 0))
			} else {
				return 1
			}
		case .fadeInOut(let duration):
			if progress < duration {
				return progress.remap(from: (0, duration), to: (0, 1))
			} else if progress > 1 - duration {
				return progress.remap(from: (1 - duration, 1), to: (1, 0))
			} else {
				return 1
			}
		}
	}
}
