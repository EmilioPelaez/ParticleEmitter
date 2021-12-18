//
//  ParticleEmitter.swift
//  ParticleEmitter
//
//  Created by Emilio Peláez on 18/12/21.
//

import SwiftUI

struct ParticleEmitter<Particles: View>: View {
	
	let runMode: RunMode
	let particles: () -> Particles
	
	init(runMode: RunMode, @ViewBuilder particles: @escaping () -> Particles) {
		self.runMode = runMode
		self.particles = particles
	}
	
	var body: some View {
		TimelineView(.animation) { timeline in
			Canvas(opaque: false, rendersAsynchronously: true, renderer: { context, size in
				
			}, symbols: particles)
		}
	}
}

struct ParticleEmitter_Previews: PreviewProvider {
	static var previews: some View {
		ParticleEmitter(runMode: .infinite) {
			Circle()
				.frame(width: 10, height: 10, alignment: .bottom)
				.tag(0)
		}
	}
}
