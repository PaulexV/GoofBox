//
//  RecordPageView.swift
//  GoofBox
//
//  Created by Paul-Alexis Verrier on 22/03/2023.
//

import SwiftUI

struct RecordPageView: View {
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
						SoundModifierSliderView(sliderName: "Echo").frame(width: 100)
						SoundModifierSliderView(sliderName: "Reverb").frame(width: 100)
						SoundModifierSliderView(sliderName: "Modulation").frame(width: 100)
					}
					.padding(.bottom, 50)

					Spacer()

					Button {
						print("rec")
					} label: {
						Image(systemName: "record.circle")
							.font(.system(size: 60))
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
