//
//  RecordPageView.swift
//  GoofBox
//
//  Created by Paul-Alexis Verrier on 22/03/2023.
//

import SwiftUI

struct RecordPageView: View {
    var body: some View {
		NavigationStack {
			VStack(alignment: .leading) {
				ScrollView {

				}
			}
			.background(Color("BackgroundColor"))
		}
    }
}

struct RecordPageView_Previews: PreviewProvider {
    static var previews: some View {
		ZStack {
			Color("BackgroundColor").ignoresSafeArea()
			RecordPageView()
		}.preferredColorScheme(.dark)
    }
}
