//
//  OrcerView.swift
//  MidtermSasidurka
//
//  Sasidurka Venkatesan - 991542294
//  Created by Sasidurka on 2024-10-17.


import SwiftUI

struct OrderView: View {
    // Properties for user inputs
    @State private var customerName: String = ""
    @State private var selectedCoffeeType = "Original Blend"
    @State private var selectedCoffeeSize = "Small"
    @State private var numberOfCups = ""
    @State private var addTip = false
    @State private var showAlert = false
    
    // Coffee types and sizes
    let coffeeTypes = ["Original Blend", "Dark Roast", "Vanilla"]
    let coffeeSizes = ["Small", "Medium", "Large"]
    
    // Nav state
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

                    Section (header: Text("Would you like to add tip for $2").bold()){
                        Toggle("Add Tip", isOn: $addTip)
                    }

                    Section(header: Text("Number of Cups").bold()) {
                        TextField("Enter number of cups", text: $numberOfCups)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }

                NavigationLink(destination: SummaryView(coffee: coffeeOrder ?? Coffee(size: "Small", type: "Original Blend", addTip: false, numberOfCups: 1), customerName: customerName), isActive: Binding(
                    get: { coffeeOrder != nil },
                    set: { _ in }
                )) {
                    Button(action: placeOrder) {
                        Text("Place the Order")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.top, 10)
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text("Please fill in all fields correctly."), dismissButton: .default(Text("OK")))
                }
            }
            .padding()
        }
    }

    func placeOrder() {
       
        guard !customerName.isEmpty, let cups = Int(numberOfCups), cups > 0 else {
            showAlert = true
            return
        }

        // Creating a coffee order
        coffeeOrder = Coffee(size: selectedCoffeeSize, type: selectedCoffeeType, addTip: addTip, numberOfCups: cups)
    }
}


struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}

