//
//  ContentView.swift
//  GoofBox
//
//  Created by Paul-Alexis Verrier on 08/03/2023.
//

import SwiftUI

struct HomePageView: View {
    var body: some View {
		NavigationStack {
			VStack(alignment: .leading) {
				ScrollView {
					ForEach(0..<5) {_ in
						HStack {
								Spacer()
								SoundItemView(soundName: "sound1")
								SoundItemView(soundName: "sound2")
								SoundItemView(soundName: "sound3")
								Spacer()
						}
					}
					.padding()
					Spacer()
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
