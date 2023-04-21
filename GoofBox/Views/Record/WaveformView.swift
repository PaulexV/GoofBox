//
//  BarView.swift
//  GoofBox
//
//  Created by Paul-Alexis Verrier on 12/04/2023.
//

import SwiftUI
import DSWaveformImageViews
import DSWaveformImage

struct WaveformView: View {

	var liveConfiguration: Waveform.Configuration = Waveform.Configuration(
		style: .striped(.init(color: .systemYellow, width: 5, spacing: 3)),
		verticalScalingFactor: 0.7,
		shouldAntialias: true
		)
	var samples: [Float]

	var body: some View {
		VStack {
			WaveformLiveCanvas(samples: samples, configuration: liveConfiguration, shouldDrawSilencePadding: true)
		}
		.frame(height: 100)
	}
}

struct WaveformView_Previews: PreviewProvider {
    static var previews: some View {
		ZStack {
			Color("BackgroundColor").ignoresSafeArea()
			WaveformView(samples:[0.0]).preferredColorScheme(.dark)
		}
	}
}
