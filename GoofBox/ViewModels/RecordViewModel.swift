//
//  RecordViewModel.swift
//  GoofBox
//
//  Created by Paul-Alexis Verrier on 13/04/2023.
//

import Foundation
import AVFoundation
import UIKit
import SwiftUI

class RecordViewModel : NSObject , ObservableObject , AVAudioPlayerDelegate {
	
	var playingURL : URL?
	var currentFileName : URL?
	var currentRecordingName : String? = nil
	var currentModifiedImage : UIImage? = nil
	var currentSound : Recording? = nil
	
	private var audioRecorder : AVAudioRecorder!
	private var audioPlayer : AVAudioPlayer!
	private var audioPlayerNode : AVAudioPlayerNode!
	private var audioEngine: AVAudioEngine!
	private var sampleRate: Double!
	private var bufferSize: UInt32!
	
	var samples = [Float]()
	
	@Published var isRecording : Bool = false
	@Published var isPlaying : Bool = false
	@Published var recordingsList = [Recording]()
	
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
		currentFileName = path.appendingPathComponent("GoofBox : \(Date()).m4a")
		
		let settings = [
			AVFormatIDKey: Int(kAudioFormatLinearPCM),
			AVSampleRateKey: 44100,
			AVNumberOfChannelsKey: 1,
			AVEncoderAudioQualityKey: AVAudioQuality.low.rawValue
		]
		let format = AVAudioFormat(standardFormatWithSampleRate: 44100, channels: 1)

		audioEngine = AVAudioEngine()
		audioPlayerNode = AVAudioPlayerNode()
		audioEngine.attach(audioPlayerNode)
		audioEngine.connect(audioPlayerNode, to: audioEngine.mainMixerNode, format: format)
		
		// Installer un tap pour récupérer les échantillons en temps réel
		let inputNode = audioEngine.inputNode
		let inputFormat = inputNode.inputFormat(forBus: 0)
		inputNode.installTap(onBus: 0, bufferSize: 1024, format: inputFormat) { [weak self] buffer, _ in
			let samples = buffer.floatChannelData![0]
				let count = Int(buffer.frameLength)

				var max: Float = 0
				var min: Float = 0
				for i in 0..<count {
					let sample = samples[i]
					if sample > max {
						max = sample
					}
					if sample < min {
						min = sample
					}
				}

				for i in 0..<count/150 {
					let sample = (samples[i] - min) / (max - min)
					self?.samples.append(sample)
				}
			DispatchQueue.main.async {
				self?.objectWillChange.send()
			}
		}
		
		do {
			audioRecorder = try AVAudioRecorder(url: self.currentFileName!, settings: settings)
			audioRecorder.prepareToRecord()
			audioRecorder.record()
			try audioEngine.start()
			isRecording = true
		} catch {
			print("Error info: \(error)")
			print("Failed to Setup the Recording")
		}
	}
	
	func stopRecording(){
		audioRecorder.stop()
		audioEngine.stop()
		audioEngine.reset()
		audioRecorder = nil
		isRecording = false
		
		if let filename = self.currentFileName {
			addRecording(url: filename)
		}
		recordingsList.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedDescending})
	}
	
	func getSamples() -> [Float] {
		return samples
	}
	
	func fetchAllRecording(){
		
		let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
		let directoryContents = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
		
		for i in directoryContents {
			addRecording(url: i)
		}
		recordingsList.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedDescending})
	}
	
	
	func startPlaying(url : URL) {
		
		playingURL = url
		let playSession = AVAudioSession.sharedInstance()
		do {
			try playSession.setCategory(.playback, mode: .default)
			try playSession.setActive(true)
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
	
	func addRecording(url: URL) {
		recordingsList.append(
			Recording(
				soundName: "NewSound",
				fileURL : url,
				createdAt:getFileDate(for: url),
				soundImage: Image("BlankImage"),
				isPlaying: false))
		recordingsList.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedDescending})
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
	
	func changeSoundImage() {
		if let image = currentModifiedImage {
			self.currentSound?.soundImage = Image(uiImage: image)
		}
	}
	
	//	func changeSoundName(newName: String) {
	//		if let name = currentRecordingName {
	//			self.currentSound?.soundName = newName
	//		}
	//	}
}

