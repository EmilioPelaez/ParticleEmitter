//
//  StarryNightView.swift
//  ParticleEmitter
//
//  Created by Emilio Peláez on 19/12/21.
//

import SwiftUI

struct StarryNight: View {
	
	var body: some View {
		ParticleEmitter(runMode: runMode, emissionRules: rules, debug: true)
			.ignoresSafeArea()
	}
	
	var runMode: ParticleEmitter.RunMode {
		.infinite(.fixed(50))
	}
	
	var rules: ParticleEmitter.Rules {
		.init(images: [Image(systemName: "star.fill")],
		      colors: [.yellow],
		      matchImagesAndColors: false,
		      lifetime: 5,
		      lifetimeVariation: 4.5,
		      emissionSource: .canvas,
		      opacity: .fadeInOut(duration: 0.15),
		      rotation: .zero,
		      rotationVariation: .degrees(360),
		      rotationSpeed: .zero,
		      rotationSpeedVariation: .degrees(15),
		      scale: 0.5,
		      scaleVariation: 0.25,
		      scaleSpeed: 0,
		      scaleSpeedVariation: 0)
	}
}
