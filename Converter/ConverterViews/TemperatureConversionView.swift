//
//  TemperatureConversionView.swift
//  Converter
//
//  Created by Mykola Zakluka on 09.04.2023.
//

import SwiftUI

struct TemperatureConversionView: View {
    @FocusState private var temperatureIsFocused: Bool
    
    @State private var inputTemp = UnitTemperature.celsius.symbol
    @State private var outputTemp = UnitTemperature.celsius.symbol
    @State private var temperature = 0.0
    
    let tempTypes = [
        UnitTemperature.celsius.symbol,
        UnitTemperature.fahrenheit.symbol,
        UnitTemperature.kelvin.symbol
    ]
    let tempDictionary = [
        UnitTemperature.celsius.symbol: UnitTemperature.celsius,
        UnitTemperature.fahrenheit.symbol: UnitTemperature.fahrenheit,
        UnitTemperature.kelvin.symbol: UnitTemperature.kelvin
    ]
    
    var calculatedTemperature: Double {
        let inputType = tempDictionary[inputTemp]!
        let outputType = tempDictionary[outputTemp]!
        
        let currentTemperature = Measurement(value: temperature, unit: inputType)
        let convertTemperature = currentTemperature.converted(to: outputType)
        
        return convertTemperature.value
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Temperature", value: $temperature, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($temperatureIsFocused)
                } header: {
                    Text("Temperature")
                }
                
                Section {
                    Picker("From", selection: $inputTemp) {
                        ForEach(tempTypes, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("From")
                }
                
                Section {
                    Picker("To", selection: $outputTemp) {
                        ForEach(tempTypes, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("To")
                }
                
                Section {
                    Text("\(calculatedTemperature.formatted()) \(outputTemp)")
                } header: {
                    Text(temperature > 0.0 ? "Result: \(temperature.formatted()) \(inputTemp) are" : "Result")
                }
            }
            .navigationTitle("Temp Conversion")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        temperatureIsFocused = false
                    }
                }
            }
        }
    }
}

struct TemperatureConversionView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureConversionView()
    }
}
