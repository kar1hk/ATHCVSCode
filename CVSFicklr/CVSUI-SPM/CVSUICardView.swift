//
//  CVSUICardView.swift
//  CVSFicklr
//
//  Created by Karthik Sankar on 10/31/24.
//
// CVSUICardView - houses a image and title
// This can be used any where and themed based on branding.
import SwiftUI

struct CVSUICardView: View {
    
    var imageURL: String    //  Image Source URL
    var title: String       //  Image Title
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Load the image asynchronously with overlay
            AsyncImage(url: URL(string: imageURL.secureURL())) { phase in
                    // Check for Image download phases and update UI
                     switch phase {
                     case .empty:
                         ProgressView()
                             .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                     case .success(let image):
                         image
                             .resizable()
                             .aspectRatio(contentMode: .fit)
                             .frame(maxWidth: .infinity, maxHeight: 300)
                     case .failure:
                         // On Faliure default to system photo
                         Image(systemName: "photo")
                             .resizable()
                             .aspectRatio(contentMode: .fit)
                             .foregroundColor(.gray)
                             .frame(maxWidth: .infinity, maxHeight: 300)
                     @unknown default:
                         EmptyView()
                     }
            }
            // Title overlay with black opacity
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding(8)
                .background(Color.black.opacity(0.6))
                .cornerRadius(5)
                .padding([.leading, .bottom], 8)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding(.vertical, 8)
        
        // Adding Accessibility to tell that this card
        // Can be tappable and navigates to details
        // Include all elements include children
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text(title))
        .accessibilityHint("Tap to view details.")
        .accessibilityAddTraits(.isButton)
    }
}

#Preview("CVSUICardView", traits: .sizeThatFitsLayout) {
    CVSUICardView(imageURL: CVSUIKit.shared.brandLogoURL, title: "Aetna Photo Title")
        .padding() // Optional padding for a better view
}
