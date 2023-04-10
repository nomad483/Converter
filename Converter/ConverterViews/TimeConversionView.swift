//
//  TimeConversionView.swift
//  Converter
//
//  Created by Mykola Zakluka on 09.04.2023.
//

import SwiftUI

struct TimeConversationView: View {
    @FocusState private var timeIsFocused: Bool
    
    @State private var inputTime = UnitDuration.seconds.symbol
    @State private var outputTime = UnitDuration.seconds.symbol
    @State private var time = 0.0
    
    let timeTypes = [
        UnitDuration.seconds.symbol,
        UnitDuration.minutes.symbol,
        UnitDuration.hours.symbol,
        "d"
    ]
    
    func getTimeValue(symbol: String) -> Int {
        switch symbol {
        case timeTypes[0]:
            return 1
        case timeTypes[1]:
            return 60
        case timeTypes[2]:
            return 3_600
        case timeTypes[3]:
            return 3_600 * 24
        default:
            return 1
        }
    }
    
    var calculatedTime: Double {
        let inputValue = Double(getTimeValue(symbol: inputTime))
        let outputValue = Double(getTimeValue(symbol: outputTime))
        
        return time * inputValue / outputValue
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Distance", value: $time, format: .number)
                        .keyboardType(.numberPad)
                        .focused($timeIsFocused)
                } header: {
                    Text("Time")
                }
                
                Section {
                    Picker("From", selection: $inputTime) {
                        ForEach(timeTypes, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("From")
                }
                
                Section {
                    Picker("To", selection: $outputTime) {
                        ForEach(timeTypes, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("To")
                }
                
                Section {
                    Text("\(calculatedTime.formatted()) \(outputTime)")
                } header: {
                    Text(time > 0.0 ? "Result: \(time, specifier: "%.2f") \(inputTime) are" : "Result")
                }
            }
            .navigationTitle("Length Conversation")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        timeIsFocused = false
                    }
                }
            }
        }
    }
}

struct TimeConversationView_Previews: PreviewProvider {
    static var previews: some View {
        TimeConversationView()
    }
}
