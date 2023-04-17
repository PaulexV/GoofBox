//
//  HomePageViewModel.swift
//  GoofBox
//
//  Created by Paul-Alexis Verrier on 17/04/2023.
//

import Foundation
import SwiftUI

class HomePageViewModel: ObservableObject {

	@Published var recordingsList = [Recording]()

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
}
