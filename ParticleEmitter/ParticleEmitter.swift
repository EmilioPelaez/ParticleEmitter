//
//  ParticleEmitter.swift
//  ParticleEmitter
//
//  Created by Emilio Peláez on 18/12/21.
//

import SwiftUI

struct ParticleEmitter<Particles: View>: View {
	
	let state: InternalState
	let particles: () -> Particles
	
	init(runMode: RunMode, emissionSource: EmissionSource = .canvas, @ViewBuilder particles: @escaping () -> Particles) {
		self.state = InternalState(runMode: runMode, emissionSource: emissionSource)
		self.particles = particles
	}
	
	var body: some View {
		TimelineView(.animation) { timeline in
			Canvas(opaque: false, rendersAsynchronously: true, renderer: { context, size in
				state.tick(date: timeline.date, canvasSize: size)
			}, symbols: particles)
		}
	}
}

struct ParticleEmitter_Previews: PreviewProvider {
	static var previews: some View {
		ParticleEmitter(runMode: .infinite(starting: 10, rate: 10)) {
			Circle()
				.frame(width: 10, height: 10, alignment: .bottom)
				.tag(0)
		}
	}
}
