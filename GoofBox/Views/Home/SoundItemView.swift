//
//  SoundItemView.swift
//  GoofBox
//
//  Created by Paul-Alexis Verrier on 22/03/2023.
//

import SwiftUI

struct SoundItemView: View {

	@ObservedObject var rec = RecordViewModel()
	var recording: Recording

    var body: some View {
		VStack {
			Image(recording.imagePath)
				.resizable(resizingMode: .stretch)
				.cornerRadius(20)
				.frame(width: 90, height: 90)
			Text(recording.soundName)
				.foregroundColor(Color.accentColor)
		}
		.onTapGesture {
			rec.startPlaying(url: recording.fileURL)
		}
    }
}
