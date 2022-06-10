//
//  ItemRow.swift
//  iDine
//
//  Created by Apple on 03/06/22.
//

import SwiftUI

struct ItemRow: View {
    let item: MenuItem
    let colors: [String: Color] = ["D": .purple, "G": .black, "N": .red, "S": .blue, "V": .green]
    var body: some View {
        NavigationLink(
            destination: ItemDetail(item: item)) {
            HStack {
                Image(item.thumbnailImage).clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2.0))
                VStack(alignment: .leading) {
                    Text(item.name).font(.headline)
                    Text("$\(item.price)")
                    Spacer() // we’re going to force the restriction text to be spaced apart from the rest of the row.That will automatically take up all available free space
                    ForEach(item.restrictions, id: \.self) { restriction in
                        Text(restriction)
                            .font(.caption)
                            .fontWeight(.black)
                            .padding(5)
                            .background(colors[restriction, default: Color.black])
                            .clipShape(Circle())
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

struct ItemDetail : View {
    let item: MenuItem
    @EnvironmentObject var order: Order
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Image(item.mainImage)
                    .resizable()
                    .scaledToFit()
                Text("Photo: \(item.photoCredit)")
                    .padding(4)
                    .background(Color.black)
                    .font(.caption)
                    .foregroundColor(.white)
                    .offset(x: -5, y: -5)
            } //Tip: If you swap the order of the padding() and background() modifiers the result is different. The order matters!
            Text(item.description)
                .padding()
            Button("Order This") {
                order.add(item: item)
            }.font(.headline)
            .buttonStyle(GrowingButton())
            Spacer()
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//button style whatever you want
struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}


