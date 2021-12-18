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
		TimelineView(.animation) { timeline in
			Canvas(opaque: false, rendersAsynchronously: false) { context, size in
				guard let symbol = context.resolveSymbol(id: symbolId) else { return }
				(0..<amount).forEach { _ in
					let point = CGPoint(x: .random(in: 0..<size.width),
															y: .random(in: 0..<size.height))
					context.draw(symbol, at: point)
				}
				_ = timeline.date
			} symbols: {
				Circle()
					.stroke(.yellow)
					.frame(width: 10, height: 10)
					.tag(symbolId)
			}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
