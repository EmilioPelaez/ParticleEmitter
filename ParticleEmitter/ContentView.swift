//
//  ContentView.swift
//  ParticleEmitter
//
//  Created by Emilio Peláez on 18/12/21.
//

import SwiftUI

struct ContentView: View {
	var body: some View {
		NavigationView {
			List {
				NavigationLink("Snowfall") {
					SnowfallView()
						.navigationTitle("Snowfall")
				}
				NavigationLink("Confetti") {
					ConfettiView()
						.navigationTitle("Confetti")
				}
				NavigationLink("Starry Night") {
					StarryNight()
						.navigationTitle("Starry Night")
				}
			}
			.navigationTitle("Examples")
		}
	}
	
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
