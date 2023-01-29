//
//  ContentView.swift
//  WeSplit
//
//  Created by Biagio Ricci on 26/01/23.
//

import SwiftUI

///
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
        .font(.largeTitle)
        .foregroundColor(.blue)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}
//Just created and not used
///
struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    //let tipPercentages = [10, 15, 20, 25, 0]
    var dollarFormatter : FloatingPointFormatStyle<Double>.Currency {
        let currencyCode = Locale.current.currency?.identifier ?? "USD"
        return FloatingPointFormatStyle<Double>.Currency(code: currencyCode)
    }
    
    var totalAmount: Double {
        //let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        
        return grandTotal
    }
    var totalPerPerson: Double {
        let total = totalAmount
        let peopleCount = Double(numberOfPeople + 2)
        //let tipSelection = Double(tipPercentage)
        
        //let tipValue = checkAmount / 100 * tipSelection
        //let grandTotal = checkAmount + tipValue
        let amountPerPerson = total / peopleCount
        
        
        return amountPerPerson
    }
    
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: dollarFormatter)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section{
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalAmount, format: dollarFormatter)
                        .foregroundColor(tipPercentage == 0 ? .red : .green)
                } header: {
                    Text("Total amount")
                }
                Section {
                    Text(totalPerPerson, format: dollarFormatter)
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
