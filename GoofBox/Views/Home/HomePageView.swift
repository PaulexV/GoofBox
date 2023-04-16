//
//  ContentView.swift
//  GoofBox
//
//  Created by Paul-Alexis Verrier on 08/03/2023.
//

import SwiftUI

struct HomePageView: View {

	@StateObject var rec = RecordViewModel()
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
								  };
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
