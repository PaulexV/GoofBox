//
//  SoundItemView.swift
//  GoofBox
//
//  Created by Paul-Alexis Verrier on 22/03/2023.
//

import SwiftUI

struct SoundItemView: View {

	@ObservedObject var rec = RecordViewModel()
	var soundName: String
	var recording: Recording

    var body: some View {
		VStack {
			Image("BlankImage")
				.resizable(resizingMode: .stretch)
				.cornerRadius(20)
				.frame(width: 90, height: 90)
			Text(soundName)
				.foregroundColor(Color.accentColor)
		}
		.onTapGesture {
			rec.startPlaying(url: recording.fileURL)
		}
		.contextMenu(menuItems: {
			Button(action: {
				print("toto")
			}) {
				Label("Change Name", systemImage: "pencil")
			};
			Button(role: .destructive, action: {
				rec.deleteRecording(url: recording.fileURL)
			}) {
				Label("Remove", systemImage: "trash")
			}
		})
    }
}
