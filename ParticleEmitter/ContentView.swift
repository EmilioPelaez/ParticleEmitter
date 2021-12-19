//
//  ContentView.swift
//  ParticleEmitter
//
//  Created by Emilio Peláez on 18/12/21.
//

import SwiftUI

struct ContentView: View {
	let symbolId = "Symbol"
	let amount: Int = 10_000
	
	var body: some View {
		ParticleEmitter(runMode: .infinite(.variable(starting: 100, rate: 1000, maximum: 500)), emissionRules: rules)
			.ignoresSafeArea()
	}
	
	func completed() {
		print("Done!")
	}
	
	var rules: EmissionRules {
		.init(images: [Image(systemName: "star.fill"), Image(systemName: "snowflake")],
					colors: [.yellow, .cyan],
					matchImagesAndColors: true,
					lifetime: 2,
					lifetimeVariation: 0.95,
					emissionSource: .canvas,
					opacity: .fadeInOut(duration: 0.15),
					speed: .zero,
					speedVariation: .init(dx: 10, dy: 10),
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

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
