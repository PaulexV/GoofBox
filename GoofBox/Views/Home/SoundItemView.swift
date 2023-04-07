//
//  SoundItemView.swift
//  GoofBox
//
//  Created by Paul-Alexis Verrier on 22/03/2023.
//

import SwiftUI

struct SoundItemView: View {
    var body: some View {
        VStack {
            Image("BlankImage")
                .resizable(resizingMode: .stretch)
                .cornerRadius(20)
                .frame(width: 90, height: 90)
            Text("SoundItem")
                .foregroundColor(Color.accentColor)
        }
    }
}

struct SoundItemView_Previews: PreviewProvider {
    static var previews: some View {
		ZStack {
			Color("BackgroundColor").ignoresSafeArea()
			SoundItemView().preferredColorScheme(.dark)
		}
    }
}
