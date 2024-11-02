//
//  CVSFicklrApp.swift
//  CVSFicklr
//
//  Created by Karthik Sankar on 10/31/24.
//

import SwiftUI

@main
struct CVSFicklrApp: App {
    
    // Launch with Brand Options
    init () {
        // Set Brand Value in here
        CVSUIKit.shared.brand = .Aetna
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
