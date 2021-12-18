//
//  ParticleEmitterRunMode.swift
//  ParticleEmitter
//
//  Created by Emilio Peláez on 18/12/21.
//

import Foundation

extension ParticleEmitter {
	enum RunMode {
		case infinite
		case once(completion: () -> Void)
		case timed(TimeInterval, completion: () -> Void)
	}
}
