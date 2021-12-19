//
//  ParticleEmitterRunMode.swift
//  ParticleEmitter
//
//  Created by Emilio Peláez on 18/12/21.
//

import Foundation

extension ParticleEmitter {
	enum RunMode {
		enum Amount {
			case fixed(Int)
			case variable(starting: Int, rate: Int, maximum: Int)
		}
		
		case infinite(Amount)
		case once(particles: Int, completion: () -> Void)
		case timed(TimeInterval, Amount, completion: () -> Void)
	}
}

extension ParticleEmitter.RunMode {
	var initialParticleAmount: Int {
		switch self {
		case let .infinite(.fixed(amount)): return amount
		case let .infinite(.variable(starting, _, _)): return starting
		case let .once(particles, _): return particles
		case let .timed(_, .fixed(amount), _): return amount
		case let .timed(_, .variable(starting, _, _), _): return starting
		}
	}
}
