//
//  BarView.swift
//  GoofBox
//
//  Created by Paul-Alexis Verrier on 12/04/2023.
//

import SwiftUI

struct WaveFormView: View {

	var body: some View {
		VStack {

		}
	}
}

struct BarView_Previews: PreviewProvider {
    static var previews: some View {
		ZStack {
			Color("BackgroundColor").ignoresSafeArea()
			WaveFormView().preferredColorScheme(.dark)
		}
	}
}
