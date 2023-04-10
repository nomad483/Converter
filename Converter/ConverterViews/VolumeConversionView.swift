//
//  VolumeConversionView.swift
//  Converter
//
//  Created by Mykola Zakluka on 09.04.2023.
//

import SwiftUI

struct VolumeConversionView: View {
    @FocusState private var volumeIsFocused: Bool
    
    @State private var inputVolume = UnitVolume.milliliters.symbol
    @State private var outputVolume = UnitVolume.milliliters.symbol
    @State private var volume = 0.0
    
    let volumeTypes = [
        UnitVolume.milliliters.symbol,
        UnitVolume.liters.symbol,
        UnitVolume.cups.symbol,
        UnitVolume.pints.symbol,
        UnitVolume.gallons.symbol
    ]
    let volumeDictionary = [
        UnitVolume.milliliters.symbol: UnitVolume.milliliters,
        UnitVolume.liters.symbol: UnitVolume.liters,
        UnitVolume.cups.symbol: UnitVolume.cups,
        UnitVolume.pints.symbol: UnitVolume.pints,
        UnitVolume.gallons.symbol: UnitVolume.gallons
    ]
    
    var calculatedTemperature: Double {
        let inputType = volumeDictionary[inputVolume]!
        let outputType = volumeDictionary[outputVolume]!
        
        let currentVolume = Measurement(value: volume, unit: inputType)
        let convertVolume = currentVolume.converted(to: outputType)
        
        return convertVolume.value
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Volume", value: $volume, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($volumeIsFocused)
                } header: {
                    Text("Volume")
                }
                
                Section {
                    Picker("From", selection: $inputVolume) {
                        ForEach(volumeTypes, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("From")
                }
                
                Section {
                    Picker("To", selection: $outputVolume) {
                        ForEach(volumeTypes, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("To")
                }
                
                Section {
                    Text("\(calculatedTemperature.formatted()) \(outputVolume)")
                } header: {
                    Text(volume > 0.0 ? "Result: \(volume.formatted()) \(inputVolume) are" : "Result")
                }
            }
            .navigationTitle("Temp Conversion")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        volumeIsFocused = false
                    }
                }
            }
        }
    }
}

struct VolumeConversionView_Previews: PreviewProvider {
    static var previews: some View {
        VolumeConversionView()
    }
}
