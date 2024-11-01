//
//  CVSUINavigationSearchBar.swift
//  CVSFicklr
//
//  Created by Karthik Sankar on 10/31/24.
//
// CVSUINavigationSearchBar is custom SwiftUI
// Reusable Nav Bar
import SwiftUI

// Custom Navigation bar with Search text field
struct CVSUINavigationSearchBar: View {
    
    var title: String                   // Title of Navigation Bar
    @Binding var searchText: String     // Search Text
    
    var body: some View {
            VStack {
                // Navigation Title
                Text(title)
                    .font(.headline)
                    .foregroundColor(CVSUIKit.shared.brandSecondary)
                    .accessibilityLabel("\(title) Search Bar")     // Accessibility Label for title
                    .accessibilityAddTraits(.isHeader)             // Making this as header for screen readers
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    // Search Text Field
                    TextField("Search...", text: $searchText)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .accessibilityLabel("Search field")             // Accessible label for the text field
                        .accessibilityHint("Type to start searching")   // Accessible hint for screen readers
                }
                .padding(.horizontal)
            }
            .frame(height: 80) // Navigation Bar Height
            .background(CVSUIKit.shared.brandPrimaryColor) // Branding based on CVSUIKit Brand
    }
}
