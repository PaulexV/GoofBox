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
					ForEach(0..<7) {_ in
						HStack {
								Spacer()
								SoundItemView()
								SoundItemView()
								SoundItemView()
								Spacer()
						}
					}
					.padding()
					Spacer()
				}
			}
			.toolbar(content: {
				ToolbarItem(placement: .navigationBarTrailing) {
					Button {
						print("toto")
					} label: {
						Image(systemName: "plus.circle")
							.font(.title3)
							.foregroundColor(.accentColor)

					}
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
