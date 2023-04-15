//
//  RecordViewModel.swift
//  GoofBox
//
//  Created by Paul-Alexis Verrier on 13/04/2023.
//

import Foundation
import AVFoundation

class RecordViewModel : NSObject , ObservableObject , AVAudioPlayerDelegate {


	var audioRecorder : AVAudioRecorder!
	var audioPlayer : AVAudioPlayer!
	var playingURL : URL?
	var indexOfPlayer = 0

	@Published var isRecording : Bool = false
	@Published var isPlaying : Bool = false

	@Published var recordingsList = [Recording]()

    @Published var countSec = 0
	@Published var timerCount : Timer?
	@Published var blinkingCount : Timer?
	@Published var timer : String = "0:00"
	@Published var toggleColor : Bool = false

	override init(){
		super.init()
		fetchAllRecording()
	}

	func startRecording(){

		let recordingSession = AVAudioSession.sharedInstance()
		do {
			try recordingSession.setCategory(.playAndRecord, mode: .default)
			try recordingSession.setActive(true)
		} catch {
			print("Can not setup the Recording")
		}

		let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
		let fileName = path.appendingPathComponent("GoofBox : \(Date()).m4a")



		let settings = [
			AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
			AVSampleRateKey: 12000,
			AVNumberOfChannelsKey: 1,
			AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
		]


		do {
			audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
			audioRecorder.prepareToRecord()
			audioRecorder.record()
			isRecording = true

		} catch {
			print("Failed to Setup the Recording")
		}
	}


	func stopRecording(){
		audioRecorder.stop()
		isRecording = false
	}

	func fetchAllRecording(){

			let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
			let directoryContents = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)

			for i in directoryContents {
				recordingsList.append(
					Recording(
						soundName: "NewSound",
						fileURL : i,
						createdAt:getFileDate(for: i),
						imagePath: "",
						isPlaying: false))
			}

			recordingsList.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedDescending})

		}


		func startPlaying(url : URL) {

			playingURL = url

			let playSession = AVAudioSession.sharedInstance()

			do {
				try playSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
			} catch {
				print("Playing failed in Device")
			}

			do {
				audioPlayer = try AVAudioPlayer(contentsOf: url)
				audioPlayer.delegate = self
				audioPlayer.prepareToPlay()
				audioPlayer.play()
				isPlaying = true

				for i in 0..<recordingsList.count {
					if recordingsList[i].fileURL == url {
						recordingsList[i].isPlaying = true
					}
				}

			} catch {
				print("Playing Failed")
			}


		}

		func stopPlaying(url : URL) {

			audioPlayer.stop()
			isPlaying = false

			for i in 0..<recordingsList.count {
				if recordingsList[i].fileURL == url {
					recordingsList[i].isPlaying = false
				}
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

	func getFileDate(for file: URL) -> Date {
			if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
				let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
				return creationDate
			} else {
				return Date()
			}
		}
}
