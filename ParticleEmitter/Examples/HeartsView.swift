//
//  HeartsView.swift
//  ParticleEmitter
//
//  Created by Emilio Peláez on 27/03/22.
//

import SwiftUI

struct HeartsView: View {
	
	@State var particles = false
	
	var body: some View {
		ZStack {
			Color.clear
			Button {
				particles = true
			} label: {
				Image(systemName: "heart")
					.symbolVariant(particles ? .fill : .none)
					.foregroundStyle(.pink)
					.font(.title)
			}
			.overlay(alignment: .bottom) {
				if particles {
					ParticleEmitter(runMode: runMode, emissionRules: rules)
						.frame(width: 50, height: 75, alignment: .bottom)
				}
			}
		}
	}
	
	var runMode: ParticleEmitter.RunMode {
		.once(particles: 4) {
			particles = false
		}
	}
	
	var rules: ParticleEmitter.Rules {
		.init(images: [Image(systemName: "heart.fill")],
		      colors: [.pink],
		      matchImagesAndColors: false,
		      lifetime: 0.9,
		      lifetimeVariation: 0.1,
		      emissionSource: .area(CGRect(x: 0.25, y: 0.65, width: 0.5, height: 0.2)),
		      opacity: .fadeOut(duration: 0.15),
		      gravity: .init(dx: 0, dy: -50),
		      velocity: .init(dx: 0, dy: -10),
		      velocityVariation: .init(dx: 0, dy: 5),
		      rotation: .zero,
		      rotationVariation: .degrees(15),
		      rotationSpeed: .zero,
		      rotationSpeedVariation: .zero,
		      scale: 0.8,
		      scaleVariation: 0.2,
		      scaleSpeed: 0,
		      scaleSpeedVariation: 0)
	}
}
