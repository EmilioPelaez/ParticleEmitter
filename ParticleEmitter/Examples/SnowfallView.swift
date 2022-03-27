//
//  SnowfallView.swift
//  ParticleEmitter
//
//  Created by Emilio Peláez on 19/12/21.
//

import SwiftUI

struct SnowfallView: View {
	
	var body: some View {
		ParticleEmitter(runMode: runMode, emissionRules: rules, debug: true)
			.ignoresSafeArea()
	}
	
	var runMode: ParticleEmitter.RunMode {
		.infinite(.variable(starting: 15, rate: 50, maximum: 100))
	}
	
	var rules: ParticleEmitter.Rules {
		.init(images: [Image(systemName: "snowflake")],
		      colors: [.cyan],
		      matchImagesAndColors: false,
		      lifetime: 5,
		      lifetimeVariation: 4.5,
		      emissionSource: .horizontalLine(offset: -0.1),
		      opacity: .fadeOut(duration: 0.15),
		      gravity: .init(dx: 0, dy: 0),
		      speed: 100,
		      speedVariation: 25,
		      direction: .degrees(90),
		      rotation: .zero,
		      rotationVariation: .degrees(360),
		      rotationSpeed: .zero,
		      rotationSpeedVariation: .degrees(45),
		      scale: 1,
		      scaleVariation: 0.5,
		      scaleSpeed: -0.05,
		      scaleSpeedVariation: 0)
	}
}
