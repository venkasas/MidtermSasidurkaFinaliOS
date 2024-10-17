//
//  SummaryView.swift
//  MidtermSasidurka
//
//  Created by Sasidurka on 2024-10-17.
//

import SwiftUI

struct SummaryView: View {
    
    @Binding var orders: [Order] // Use Binding to access the orders
    
    var body: some View {
        VStack {
            List {
                ForEach(orders.indices, id: \.self) { index in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Size: \(orders[index].size)")
                            Text("Type: \(orders[index].toppings)")
                            
                            Text("Quantity: \(orders[index].quantity)")
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .navigationTitle("My Orders")
        .padding()
    }
}

struct OrderListView_Previews: PreviewProvider {
    @State static var previewOrders = [
        Order(size: "Medium", toppings: "Pepperoni", crust: "Thin", quantity: 2)
    ]
    
    static var previews: some View {
        SummaryView(orders: $previewOrders)
    }
}
