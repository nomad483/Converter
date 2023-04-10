//
//  MenuView.swift
//  Converter
//
//  Created by Mykola Zakluka on 09.04.2023.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationView {
            Form {
                Section {
                    NavigationLink(destination: TemperatureConversionView()) {
                        Text("Temperature conversion")
                    }
                    NavigationLink(destination: LengthConversationView()) {
                        Text("Length conversion")
                    }
                    NavigationLink(destination: TimeConversationView()) {
                        Text("Time conversion")
                    }
                    NavigationLink(destination: VolumeConversionView()) {
                        Text("Volume conversion")
                    }
                } header: {
                    Text("Choose convertation")
                }
            }
            .navigationTitle("Converter")
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
