//
//  ContentView.swift
//  GoofBox
//
//  Created by Paul-Alexis Verrier on 08/03/2023.
//

import SwiftUI
import PhotosUI

struct HomePageView: View {

	@StateObject var rec = RecordViewModel()

	@State private var avatarItem: PhotosPickerItem?
	@State private var avatarImage: Image?

	let columns = [
		GridItem(.adaptive(minimum: 110))
		]

    var body: some View {
		NavigationStack {
			VStack(alignment: .leading) {
				ScrollView {
					LazyVGrid(columns: columns) {
						ForEach(rec.recordingsList, id: \.createdAt) { recording in
							SoundItemView(
								recording: recording
							)
							.contextMenu(menuItems: {
								Button(action: {
									print("toto")
								}) {
									Label("Change Name", systemImage: "pencil")
								}
								Button(action: {
									rec.currentSound = recording
									rec.showImagePicker.toggle()
								}) {
									Label("Change Image", systemImage: "photo")
								}
								Button(role: .destructive, action: {
									rec.deleteRecording(url: recording.fileURL)
								}) {
									Label("Remove", systemImage: "trash")
								}
							})
						}
					}
					.padding(.top, 30)
				}
			}
			.onTapGesture {
				print(rec.recordingsList)
			}
			.toolbar(content: {
				ToolbarItem(placement: .navigationBarTrailing) {
					NavigationLink(
						destination: RecordPageView(),
					    label: {
						   Image(systemName: "plus.circle")
							   .font(.title3)
							   .foregroundColor(.accentColor)
					   }
					)
				}
			})
			.sheet(isPresented: $rec.showImagePicker, onDismiss: rec.changeSoundImage) {
				ImagePicker(sourceType: .photoLibrary, selectedImage: $rec.currentModifiedImage)
			}
			.navigationTitle("GoofBox")
			.background(Color("BackgroundColor"))
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		ZStack {
			Color("BackgroundColor").ignoresSafeArea()
			HomePageView().preferredColorScheme(.dark)
		}
    }
}
