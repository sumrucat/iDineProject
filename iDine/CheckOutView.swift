//
//  CheckOutView.swift
//  iDine
//
//  Created by Apple on 06/06/22.
//

import SwiftUI

struct CheckOutView: View {
    @EnvironmentObject var order: Order
    @State private var paymentType = "Cash"
    @State private var addLoyaltyDetails = false
    @State private var loyaltyNumber = ""
    @State private var tipAmount = 15
    @State private var showingPaymentAlert = false
    
    var totalPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        let total = Double(order.total)
        let tipValue = total / 100 * Double(tipAmount)
        
        return formatter.string(from: NSNumber(value: total + tipValue)) ?? "$0"
    }
    
    let paymentTypes = ["Cash","Credit card","iDine points"]
    let tipAmounts = [10,15,20,25,0]
    
    var body: some View {
        Form {
            Section {
                Picker("How do you want to pay?", selection: $paymentType) { //This is where the dollar sign comes in: Swift property wrappers use that to provide two-way bindings.
                    ForEach(paymentTypes, id: \ .self) {
                        Text($0)
                    }
                }
                Toggle("Add iDine loyalty card", isOn: $addLoyaltyDetails.animation())
                if addLoyaltyDetails {
                    TextField("Enter your iDine ID", text: $loyaltyNumber)
                }
            }
            Section(header: Text("Add a tip?")) {
                Picker("Percentage:", selection: $tipAmount) {
                    ForEach(tipAmounts, id: \.self) {
                        Text("\($0)%")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            Section(header:
                        Text("Total: \(totalPrice)")
                        .font(.largeTitle)
            ) {
                Button("Confirm Order") {
                    showingPaymentAlert.toggle()
                }
            }
        }
        .navigationTitle("Payement")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showingPaymentAlert) {
            Alert(title: Text("Order confirmed"), message: Text("Your total was \(totalPrice) – thank you!"), dismissButton: .default(Text("OK")))
        }
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView().environmentObject(Order())
    }
}

/*
 - Without @State we wouldn’t be able to change properties in our structs, because structs are fixed values.
 - Without StateObject we wouldn’t be able to create classes that stay alive for the duration of our app.
 - Without @EnvironmentObject we wouldn’t be able to receive shared data from elsewhere in our app.
 - Without ObservableObject we wouldn’t be notified when an external value changes.
 - Without $property two-way bindings we would need to update values by hand.
 */
