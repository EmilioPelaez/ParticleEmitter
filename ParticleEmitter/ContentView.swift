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
		ParticleEmitter(runMode: .once(particles: 1000, completion: completed), emissionRules: rules) {
			Image(systemName: "snowflake")
				.font(.caption2)
				.foregroundColor(.cyan)
		}
		.ignoresSafeArea()
	}
	
	func completed() {
		print("Done!")
	}
	
	var rules: EmissionRules {
		.init(lifetime: 1,
					lifetimeVariation: 0.95,
					emissionSource: .horizontalLine(offset: 0),
					speed: CGVector(dx: 0, dy: 100),
					speedVariation: CGVector(dx: 0, dy: 25),
					rotation: .zero,
					rotationVariation: .degrees(360),
					rotationSpeed: .zero,
					rotationSpeedVariation: .degrees(90),
					scale: 1,
					scaleVariation: 0.5,
					scaleSpeed: -0.1,
					scaleSpeedVariation: 0)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
