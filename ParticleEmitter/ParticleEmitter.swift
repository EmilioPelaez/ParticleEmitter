//
//  ParticleEmitter.swift
//  ParticleEmitter
//
//  Created by Emilio Peláez on 18/12/21.
//

import SwiftUI

struct ParticleEmitter<Particle: View>: View {
	
	let particleId = 0
	
	let state: InternalState
	let particle: Particle
	
	init(runMode: RunMode, emissionRules: EmissionRules = .init(), particle: () -> Particle) {
		self.state = InternalState(runMode: runMode, emissionRules: emissionRules)
		self.particle = particle()
	}
	
	var body: some View {
		TimelineView(.animation) { timeline in
			Canvas(opaque: false, rendersAsynchronously: true) { context, size in
				state.tick(date: timeline.date, canvasSize: size)
				guard let symbol = context.resolveSymbol(id: particleId) else {
					return assertionFailure("Missing symbol")
				}
				for particle in state.particles {
					let position = CGPoint(x: particle.position.x * size.width,
																 y: particle.position.y * size.height)
					context.translateBy(x: position.x, y: position.y)
					context.rotate(by: particle.rotation)
					context.scaleBy(x: particle.scale, y: particle.scale)
					context.translateBy(x: -position.x, y: -position.y)
					context.draw(symbol, at: position)
					context.transform = .identity
				}
				context.draw(Text("FPS: \(state.fps)"), at: CGPoint(x: 10, y: size.height - 10), anchor: .bottomLeading)
			} symbols: {
				particle
					.tag(particleId)
			}
		}
	}
}

struct ParticleEmitter_Previews: PreviewProvider {
	static var previews: some View {
		ParticleEmitter(runMode: .infinite(.fixed(10))) {
			Circle()
				.frame(width: 10, height: 10, alignment: .bottom)
				.tag(0)
		}
	}
}
