//
//  ParticleEmitter.swift
//  ParticleEmitter
//
//  Created by Emilio Peláez on 18/12/21.
//

import SwiftUI

struct ParticleEmitter: View {
	let state: InternalState
	
	init(runMode: RunMode, emissionRules: Rules = .init()) {
		self.state = InternalState(runMode: runMode, emissionRules: emissionRules)
	}
	
	var body: some View {
		TimelineView(.animation) { timeline in
			Canvas(opaque: false, rendersAsynchronously: true) { context, size in
				guard !state.isFinished else { return }
				state.tick(date: timeline.date, canvasSize: size)
				for particle in state.particles {
					context.drawLayer { context in
						let position = CGPoint(x: particle.position.x * size.width,
						                       y: particle.position.y * size.height)
						context.translateBy(x: position.x, y: position.y)
						context.rotate(by: particle.rotation)
						context.scaleBy(x: particle.scale, y: particle.scale)
						context.translateBy(x: -position.x, y: -position.y)
						context.opacity = particle.opacity
						
						guard let resolved = context.resolveSymbol(id: particle.imageIndex) else {
							return
						}
						context.draw(resolved, at: position)
						context.blendMode = .sourceIn
						let rect = CGRect(center: position, size: resolved.size)
						let path = Path(rect)
						let color = state.emissionRules.colors[particle.colorIndex]
						context.fill(path, with: .color(color))
					}
				}
				context.draw(Text("Particles: \(state.particles.count)\nFPS: \(state.fps)"), at: CGPoint(x: 10, y: size.height - 10), anchor: .bottomLeading)
			} symbols: {
				ForEach(Array(state.emissionRules.images.enumerated()), id: \.offset) { index, image in
					image
						.tag(index)
				}
				
			}
		}
	}
}

struct ParticleEmitter_Previews: PreviewProvider {
	static var previews: some View {
		ParticleEmitter(runMode: .infinite(.fixed(10)))
	}
}
