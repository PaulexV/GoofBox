//
//  RecordPageView.swift
//  GoofBox
//
//  Created by Paul-Alexis Verrier on 22/03/2023.
//

import SwiftUI

struct RecordPageView: View {

	@ObservedObject private var rec = RecordViewModel()

    var body: some View {
		NavigationStack {
			ZStack {
				Color("BackgroundColor").ignoresSafeArea()
				VStack(alignment: .center) {
					Spacer()

					Button {
						if rec.isPlaying {
							rec.stopPlaying(url: rec.recordingsList.first!.fileURL)
						} else {
							if (rec.recordingsList.first == nil) {
								return
							}
							rec.startPlaying(url: rec.recordingsList.first!.fileURL)
						}
					} label: {
						Image(systemName: rec.isPlaying ? "pause.circle" : "play.circle")
							.font(.system(size: 50))
							.foregroundColor(.accentColor)
					}
					.padding(.bottom, 20)

					HStack {
						SoundModifierSliderView(sliderName: "Pitch").frame(width: 100)
						SoundModifierSliderView(sliderName: "Reverb").frame(width: 100)
						SoundModifierSliderView(sliderName: "Modulation").frame(width: 100)
					}
					.padding(.bottom, 50)

					Spacer()

					Button {
						rec.isRecording ?
						rec.stopRecording() :
						rec.startRecording()
					} label: {
						Image(systemName: rec.isRecording ? "stop.circle" : "record.circle")
							.font(.system(size: 60))
							.foregroundColor(.red)
					}
				}
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
