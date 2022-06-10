//
//  OrderView.swift
//  iDine
//
//  Created by Apple on 06/06/22.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var order: Order
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(order.items) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text("$\(item.price)")
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                Section {
                    NavigationLink(
                        destination: CheckOutView()) {
                        Text("place order")
                    }.disabled(order.items.isEmpty)
                }
            }
            .navigationTitle("Order")
            .listStyle(InsetGroupedListStyle())
            .toolbar {
                EditButton()
            }
        }
    }
    func deleteItems(at offsets: IndexSet) {
        order.items.remove(at: offsets.first ?? 0)
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView().environmentObject(Order())    }
}
