//
//  iDineApp.swift
//  iDine
//
//  Created by Apple on 03/06/22.
//

import SwiftUI

@main
struct iDineApp: App {
    @StateObject var order = Order()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(order)
        }
    }
}
