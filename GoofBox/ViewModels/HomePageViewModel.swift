//
//  HomePageViewModel.swift
//  GoofBox
//
//  Created by Paul-Alexis Verrier on 17/04/2023.
//

import Foundation
import SwiftUI
import AVFAudio

class HomePageViewModel: ObservableObject {

	var audioPlayer : AVAudioPlayer!
	var currentSound : Recording? = nil

	@Published var showImagePicker : Bool = false
	@Published var recordingsList = [Recording]()
	@Published var isPlaying : Bool = false

	func onAppear() {
		recordingsList = self.fetchAllRecording()
	}

	private func fetchAllRecording() -> [Recording] {

		let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
		let directoryContents = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)


		let recordings = directoryContents
			.map { url in
				Recording(
					soundName: "NewSound",
					fileURL: url,
					createdAt: getFileDate(for: url),
					soundImage: Image("BlankImage"),
					isPlaying: false
				)
			}
			.sorted(by: { $0.createdAt.compare($1.createdAt) == .orderedDescending})
		return recordings
	}

	private func getFileDate(for file: URL) -> Date {
		if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
		   let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
			return creationDate
		} else {
			return Date()
		}
	}

	func deleteRecording(url : URL) {

		do {
			try FileManager.default.removeItem(at: url)
		} catch {
			print("Can't delete")
		}

		for i in 0..<recordingsList.count {

			if recordingsList[i].fileURL == url {
				if recordingsList[i].isPlaying == true{
					stopPlaying(url: recordingsList[i].fileURL)
				}
				recordingsList.remove(at: i)
				break
			}
		}
	}

	private func stopPlaying(url : URL) {

		audioPlayer.stop()
		isPlaying = false

		for i in 0..<recordingsList.count {
			if recordingsList[i].fileURL == url {
				recordingsList[i].isPlaying = false
			}
		}
	}
}
