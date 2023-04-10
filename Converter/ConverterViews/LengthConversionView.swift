//
//  LengthConversionView.swift
//  Converter
//
//  Created by Mykola Zakluka on 09.04.2023.
//

import SwiftUI

struct LengthConversationView: View {
    @FocusState private var lengthIsFocused: Bool
    
    @State private var inputLength = UnitLength.meters.symbol
    @State private var outputLength = UnitLength.meters.symbol
    @State private var distance = 0.0
    
    let lengthTypes = [
        UnitLength.meters.symbol,
        UnitLength.kilometers.symbol,
        UnitLength.feet.symbol,
        UnitLength.yards.symbol,
        UnitLength.miles.symbol
    ]
    let lengthDictionary = [
        UnitLength.meters.symbol: UnitLength.meters,
        UnitLength.kilometers.symbol: UnitLength.kilometers,
        UnitLength.feet.symbol: UnitLength.feet,
        UnitLength.yards.symbol: UnitLength.yards,
        UnitLength.miles.symbol: UnitLength.miles
    ]
    
    var calculatedLength: Double {
        let inputType = lengthDictionary[inputLength]!
        let outputType = lengthDictionary[outputLength]!
        
        let currentLength = Measurement(value: distance, unit: inputType)
        let convertLength = currentLength.converted(to: outputType)
        
        return convertLength.value
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Distance", value: $distance, format: .number)
                        .keyboardType(.numberPad)
                        .focused($lengthIsFocused)
                } header: {
                    Text("Length")
                }
                
                Section {
                    Picker("From", selection: $inputLength) {
                        ForEach(lengthTypes, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("From")
                }
                
                Section {
                    Picker("To", selection: $outputLength) {
                        ForEach(lengthTypes, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("To")
                }
                
                Section {
                    Text("\(calculatedLength.formatted()) \(outputLength)")
                } header: {
                    Text(distance > 0.0 ? "Result: \(distance.formatted()) \(inputLength) are" : "Result")
                }
            }
            .navigationTitle("Length Conversation")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        lengthIsFocused = false
                    }
                }
            }
        }
    }
}

struct LengthConversationView_Previews: PreviewProvider {
    static var previews: some View {
        LengthConversationView()
    }
}
