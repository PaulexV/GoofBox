//
//  Recording.swift
//  GoofBox
//
//  Created by Paul-Alexis Verrier on 13/04/2023.
//

import Foundation
import SwiftUI

struct Recording : Equatable {
	var soundName: String
	let fileURL : URL
	let createdAt : Date
	var soundImage: Image
	var isPlaying : Bool
}
