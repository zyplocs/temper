//
//  ContentView.swift
//  TempTurn
//
//  Created by Eli J on 12/8/25.
//

import SwiftUI

struct ContentView: View {
    @State private var temperature: Double = 0.0
    @State private var inputUnit: UnitTemperature = .celsius
    @State private var outputUnit: UnitTemperature = .fahrenheit
    @FocusState private var isTemperatureFieldFocused: Bool
    
    private var clampedTempForConversion: Double {
        if inputUnit == .kelvin {
            return max(0, temperature)
        } else {
            return temperature
        }
    }
    
    private var convertedTemperature: Double {
        let input: Measurement<UnitTemperature> = Measurement(value: clampedTempForConversion,
                                                              unit: inputUnit)
        return input.converted(to: outputUnit).value
    }
    
    private var inputInKelvin: Double {
        let input = Measurement(value: clampedTempForConversion,
                                unit: inputUnit)
        return input.converted(to: .kelvin).value
    }
    
    private var temperatureColor: Color {
        continuousThermalColor(kelvin: inputInKelvin)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Input") {
                    TextField("Temperature",
                              value: $temperature,
                              format: .number)
                        .keyboardType(.numbersAndPunctuation)
                        .focused($isTemperatureFieldFocused)
                    
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
            .toolbar {
                if isTemperatureFieldFocused {
                    Button("Done") {
                        isTemperatureFieldFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
