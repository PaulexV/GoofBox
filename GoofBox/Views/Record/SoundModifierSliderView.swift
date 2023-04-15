//
//  SoundModifierSliderView.swift
//  GoofBox
//
//  Created by Paul-Alexis Verrier on 11/04/2023.
//

import SwiftUI

struct SoundModifierSliderView: View {

	var sliderName: String

	@State var sliderEffect: Float = 0.0

    var body: some View {
		VStack {
			HStack {
				Text(sliderName)
					.frame(width: 100)
			}
			.foregroundColor(.accentColor)
			.padding(.bottom, 30)

			VStack {
				Slider(value: $sliderEffect, in: 0...1)
					.padding(50)
			}
			.rotationEffect(.degrees(-90))
			.padding(.top, 200)
			.frame(width: 350, height: 10)
		}
    }
}

struct SoundModifierSliderView_Previews: PreviewProvider {
    static var previews: some View {
		ZStack {
			Color("BackgroundColor").ignoresSafeArea()
			SoundModifierSliderView(sliderName: "Echo").preferredColorScheme(.dark)
		}
    }
}
