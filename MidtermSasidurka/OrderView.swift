//
//  ContentView.swift
//  MidtermSasidurka
//
//  Sasidurka Venkatesan - 991542294
//  Created by Sasidurka on 2024-10-17.
//Order View
//

import SwiftUI

struct ContentView: View {
    // Properties for user inputs
    @State private var customerName: String = ""
    @State private var selectedCoffeeType = "Original Blend"
    @State private var selectedCoffeeSize = "Small"
    @State private var numberOfCups = ""
    @State private var addTip = false
    @State private var showSummary = false
    @State private var showAlert = false
    
    // Coffee types and sizes
    let coffeeTypes = ["Original Blend", "Dark Roast", "Vanilla"]
    let coffeeSizes = ["Small", "Medium", "Large"]
    
    // Summary data
    @State private var coffeeOrder: Coffee?

    var body: some View {
        NavigationView {
            VStack {
                Text("Midterm Exam")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                Text("Order View")
                    .font(.title2)
                    .bold()
                
                Form {
                    Section {
                        TextField("Enter Customer Name", text: $customerName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.bottom, 10)
                    }

                    Section(header: Text("Select Coffee type:").bold()) {
                        Picker("Select Coffee Type", selection: $selectedCoffeeType) {
                            ForEach(coffeeTypes, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }

                    Section(header: Text("Select Coffee Size:").bold()) {
                        Picker("Select Coffee Size", selection: $selectedCoffeeSize) {
                            ForEach(coffeeSizes, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }

                    Section {
                        Toggle("Add Tip", isOn: $addTip)
                    }

                    Section(header: Text("Number of Cups").bold()) {
                        TextField("Enter number of cups", text: $numberOfCups)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }

                Button(action: placeOrder) {
                    Text("Place the Order")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.top, 10)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text("Please fill in all fields correctly."), dismissButton: .default(Text("OK")))
                }
                .sheet(isPresented: $showSummary) {
                    if let order = coffeeOrder {
                        SummaryView(coffee: order, customerName: customerName)
                    }
                }
            }
            .padding()
        }
    }

    func placeOrder() {
        // Input validation
        guard !customerName.isEmpty, let cups = Int(numberOfCups), cups > 0 else {
            showAlert = true
            return
        }

        // Create a coffee order
        coffeeOrder = Coffee(size: selectedCoffeeSize, type: selectedCoffeeType, addTip: addTip, numberOfCups: cups)

        // Ensure the coffee order is ready before showing the summary
        showSummary = true
    }
}

struct SumaryView: View {
    let coffee: Coffee
    let customerName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Hi \(customerName)")
                .font(.title)
                .bold()
            
            Text("Your order details:")
                .font(.headline)
            
            Text("\(coffee.type) \(coffee.size)")
            Text("Quantity \(coffee.numberOfCups)")
            
            Text("Base Price: $\(coffee.basePrice, specifier: "%.2f")")
            Text("HST: $\(coffee.hst, specifier: "%.2f")")
            Text("Tip: $\(coffee.tip, specifier: "%.2f")")
            Text("Total Price: $\(coffee.totalPrice, specifier: "%.2f")")
            
            Spacer()
        }
        .padding()
        .navigationTitle("Summary")
    }
}

struct Coffee {
    // Stored Properties
    var size: String
    var type: String
    var addTip: Bool
    var numberOfCups: Int
    
    // Base Price Calculation
    var basePrice: Double {
        var pricePerCup: Double = 0.0
        
        switch type {
        case "Dark Roast":
            pricePerCup = 2.50
        case "Original Blend":
            pricePerCup = 3.00
        case "Vanilla":
            pricePerCup = 3.50
        default:
            pricePerCup = 0.0
        }
        
        // Adjust price based on size
        switch size {
        case "Medium":
            pricePerCup += 0.50
        case "Large":
            pricePerCup += 1.00
        default:
            break
        }
        
        return pricePerCup * Double(numberOfCups)
    }
    
    // HST Calculation (13%)
    var hst: Double {
        return basePrice * 0.13
    }
    
    // Tip Calculation
    var tip: Double {
        return addTip ? 2.00 : 0.00
    }
    
    // Total Price Calculation
    var totalPrice: Double {
        return basePrice + hst + tip
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


