//
//  ParticleEmitterRunMode.swift
//  ParticleEmitter
//
//  Created by Emilio Peláez on 18/12/21.
//

import Foundation

extension ParticleEmitter {
	enum RunMode {
		case infinite(starting: Int, rate: Int)
		case once(particles: Int, completion: () -> Void)
		case timed(TimeInterval, starting: Int, rate: Int, completion: () -> Void)
	}
}

extension ParticleEmitter.RunMode {
	var initialParticleAmount: Int {
		switch self {
		case let .infinite(starting, _): return starting
		case let .once(particles, _): return particles
		case let .timed(_, starting, _, _): return starting
		}
	}
	
	var rate: Int? {
		switch self {
		case let .infinite(_, rate): return rate
		case .once: return nil
		case let .timed(_, _, rate, _): return rate
		}
	}
}
