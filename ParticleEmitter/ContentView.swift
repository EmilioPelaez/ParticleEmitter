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
		ParticleEmitter(runMode: .infinite(.fixed(1)), emissionRules: rules) {
			Rectangle()
				.foregroundColor(.yellow)
				.frame(width: 10, height: 10)
		}
	}
	
	var rules: EmissionRules {
		.init(emissionSource: .point(.init(x: 0.5, y: 0.5)),
					rotation: Angle(degrees: 45),
					scale: 2)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
