//
//  OpacityRule.swift
//  ParticleEmitter
//
//  Created by Emilio Peláez on 19/12/21.
//

import CGMath
import CoreGraphics

extension ParticleEmitter {
	enum OpacityRule {
		case constant(opacity: CGFloat)
		case fadeIn(duration: CGFloat)
		case fadeOut(duration: CGFloat)
		case fadeInOut(duration: CGFloat)
		
		func opacity(at progress: CGFloat) -> CGFloat {
			switch self {
			case let .constant(opacity):
				return opacity
			case let .fadeIn(duration):
				if progress < duration {
					return progress.remap(from: (0, duration), to: (0, 1))
				} else {
					return 1
				}
			case let .fadeOut(duration):
				if progress > 1 - duration {
					return progress.remap(from: (1 - duration, 1), to: (1, 0))
				} else {
					return 1
				}
			case let .fadeInOut(duration):
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
}
