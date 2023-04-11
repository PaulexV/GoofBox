//
//  RecordPageView.swift
//  GoofBox
//
//  Created by Paul-Alexis Verrier on 22/03/2023.
//

import SwiftUI

struct RecordPageView: View {
	@State private var echo: Float = 0.0
	@State private var reverb: Float = 0.0
	@State private var modulation: Float = 0.0

    var body: some View {
		NavigationStack {
			ZStack {
				Color("BackgroundColor").ignoresSafeArea()
				VStack(alignment: .center) {
					Spacer()

					Button {
						print("play")
					} label: {
						Image(systemName: "play.circle")
							.font(.system(size: 50))
							.foregroundColor(.accentColor)
					}
					.padding(.bottom, 20)

					HStack {
						Text("Echo")
							.frame(width: 100)
							.padding(.trailing, 30)
						Text("Reverb")
							.frame(width: 100)
							.padding(.trailing, 25)
						Text("Modulation")
							.frame(width: 100)
					}
					.foregroundColor(.accentColor)

					VStack {
						Slider(value: $echo, in: 0...1)
							.padding(50)
						Slider(value: $reverb, in: 0...1)
							.padding(50)
						Slider(value: $modulation, in: 0...1)
							.padding(50)
					}
					.rotationEffect(.degrees(-90))
					.padding(.top, 250)
					.frame(width: 350, height: 10)

					Spacer()

					Button {
						print("rec")
					} label: {
						Image(systemName: "record.circle")
							.font(.system(size: 70))
							.foregroundColor(.red)
					}
				}
				.background(Color("BackgroundColor"))
			}
		}
    }
}

struct RecordPageView_Previews: PreviewProvider {
    static var previews: some View {
		ZStack {
			Color("BackgroundColor").ignoresSafeArea()
			RecordPageView().preferredColorScheme(.dark)
		}
    }
}
