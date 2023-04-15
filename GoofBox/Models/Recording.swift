//
//  Recording.swift
//  GoofBox
//
//  Created by Paul-Alexis Verrier on 13/04/2023.
//

import Foundation

struct Recording : Equatable {
	let soundName: String
	let fileURL : URL
	let createdAt : Date
	let imagePath: String
	var isPlaying : Bool
}
