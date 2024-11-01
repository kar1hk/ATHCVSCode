//
//  CVSUIProgressView.swift
//  CVSFicklr
//
//  Created by Karthik Sankar on 10/31/24.
//
// CVSUIProgressView UI - Custom Progress Bar
// with message and a spinner adapting to CVSUIKit Branding
import SwiftUI

struct CVSUIProgressView: View {
    
    // Prgress Bar Message
    private var message: String
    
    // Custom initializer without parameter label
    init(_ message: String) {
        self.message = message
    }
    
    // View Body
    var body: some View {
            ProgressView("\(message)...")
                .padding()
                .tint(CVSUIKit.shared.brandPrimaryColor)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 10)
    }
}

#Preview("CVSUIProgressView", traits: .sizeThatFitsLayout) {
    CVSUIProgressView("Loading...")
}
