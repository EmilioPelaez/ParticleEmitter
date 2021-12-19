//
//  ConfettiView.swift
//  ParticleEmitter
//
//  Created by Emilio Peláez on 19/12/21.
//

import SwiftUI

struct ConfettiView: View {
	
	var body: some View {
		ParticleEmitter(runMode: runMode, emissionRules: rules, debug: true)
			.ignoresSafeArea()
	}
	
	var runMode: ParticleEmitter.RunMode {
		.once(particles: 500) {}
	}
	
	var rules: ParticleEmitter.Rules {
		.init(images: [
			Image(systemName: "diamond.fill"),
			Image(systemName: "octagon.fill"),
			Image(systemName: "hexagon.fill"),
			Image(systemName: "pentagon.fill"),
		],
		colors: [.red, .green, .blue, .yellow, .purple],
		matchImagesAndColors: false,
		lifetime: 5,
		lifetimeVariation: 0,
		emissionSource: .area(CGRect(x: 0, y: -1, width: 1, height: 1)),
		opacity: .constant(opacity: 1),
		speed: .init(dx: 0, dy: 400),
		speedVariation: .init(dx: 0, dy: 25),
		rotation: .zero,
		rotationVariation: .degrees(360),
		rotationSpeed: .degrees(90),
		rotationSpeedVariation: .degrees(90),
		scale: 0.5,
		scaleVariation: 0.25,
		scaleSpeed: 0,
		scaleSpeedVariation: 0)
	}
}
