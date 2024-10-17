//
//  ContentView.swift
//  MidtermSasidurka
//
//  Sasidurka Venkatesan - 991542294
//  Created by Sasidurka on 2024-10-17.
//

//Order View

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTopping = "Cheese"
    @State private var selectedSize = 0
    @State private var selectedType = 0
    @State private var quantity = 1
    
    // Array to store all orders
    @State private var orders = [Order]()
    
    let coffeeTypes = ["Dark Roast", "Original Blend", "Vanilla"]
    let coffeeSizes = ["Small", "Medium", "Large"]
    let pizzaToppings = ["Cheese", "Pepperoni", "Veggie", "Meat Lovers"]
    
    var body: some View {
        NavigationView {
            VStack {
               
              

                // Crust Type Picker
                Text("Select Coffee Type")
                Picker("Type", selection: $selectedType) {
                    ForEach(0..<coffeeTypes.count) {
                        Text(self.coffeeTypes[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Text("Select Coffee Size")
                Picker("Size", selection: $selectedSize) {
                    ForEach(0..<coffeeSizes.count) {
                        Text(self.coffeeSizes[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                // Quantity Stepper
                Stepper(value: $quantity, in: 1...10) {
                    Text("Quantity: \(quantity)")
                }
                .padding()
                
                // Add Order Button
                Button("Place the order") {
                    let newOrder = Order(size: selectedSize, toppings: selectedTopping, crust: crustOptions[selectedCrust], quantity: quantity)
                    orders.append(newOrder)
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                // Navigation Button to go to the next screen
                NavigationLink(destination: SummaryView(orders: $orders)) {
                    Text("Show My Orders")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Pizza Order")
            .padding()
        }
    }
}

struct Order: Identifiable {
    var id = UUID()
    var size: String
    var toppings: String
    var crust: String
    var quantity: Int
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
