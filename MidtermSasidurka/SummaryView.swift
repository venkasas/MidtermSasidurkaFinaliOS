//
//  SummaryView.swift
//  MidtermSasidurka

//  Sasidurka Venkatesan - 991542294
//  Created by Sasidurka on 2024-10-17.
//
import SwiftUI

struct SummaryView: View {
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

// Preview for SummaryView
struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView(coffee: Coffee(size: "Medium", type: "Original Blend", addTip: true, numberOfCups: 2), customerName: "Sasi")
    }
}

struct Coffee {
    // Stored prop
    var size: String
    var type: String
    var addTip: Bool
    var numberOfCups: Int
    
    // Base Price calc
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
    
    // HST calc
    var hst: Double {
        return basePrice * 0.13
    }
    
    // Tip calc
    var tip: Double {
        return addTip ? 2.00 : 0.00
    }
    
    // Total calc
    var totalPrice: Double {
        return basePrice + hst + tip
    }
}
