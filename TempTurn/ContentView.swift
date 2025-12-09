//
//  ContentView.swift
//  TempTurn
//
//  Created by Eli J on 12/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var temperature = 0.0
    @State private var inputUnit: UnitTemperature = .celsius
    @State private var outputUnit: UnitTemperature = .fahrenheit
    @FocusState private var isTemperatureFieldFocused: Bool
    
    var convertedTemperature: Double {
        let input = Measurement(value: temperature, unit: inputUnit)
        return input.converted(to: outputUnit).value
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Input") {
                    TextField("Temperature",
                              value: $temperature,
                              format: .number)
                        .keyboardType(.decimalPad)
                    
                    Picker("From", selection: $inputUnit) {
                        Text("°C").tag(UnitTemperature.celsius)
                        Text("°F").tag(UnitTemperature.fahrenheit)
                        Text("K").tag(UnitTemperature.kelvin)
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Output") {
                    Picker("To", selection: $outputUnit) {
                        Text("°C").tag(UnitTemperature.celsius)
                        Text("°F").tag(UnitTemperature.fahrenheit)
                        Text("K").tag(UnitTemperature.kelvin)
                    }
                    .pickerStyle(.segmented)
                    
                    Text(convertedTemperature, format: .number)
                }
            }
            .navigationTitle("TempTurn")
        }
    }
}

#Preview {
    ContentView()
}
