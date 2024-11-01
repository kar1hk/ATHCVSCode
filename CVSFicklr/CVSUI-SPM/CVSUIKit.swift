//
//  CVSUIKit.swift
//  CVSUIKit
//
//  Created by Karthik Sankar on 10/31/24.
//
// CVSUIKit class helps to manage
// Different Branding for the UI
import SwiftUI

// Supported theming Brands this can be expanded as needed
enum Brand {
    case CVS
    case Athena
    
    // Brand Title to be used in Apps
    fileprivate var title: String {
        switch self {
            case .CVS: return "CVS Health"
            case .Athena: return "Athena Health"
        }
    }
    
    // Brand Primary Color
    fileprivate var primaryColor: Color {
        switch self {
            case .CVS: return Color(hex: "#cc0000")
            case .Athena: return Color(hex: "#582c83")
        }
    }
    
    // Brand Secondary Color
    fileprivate var secondaryColor: Color {
        switch self {
            case .CVS: return Color(hex: "#ffffff")
            case .Athena: return Color(hex: "#ffffff")
        }
    }
    
    // Brand Logo
    fileprivate var logoURL: String {
        switch self {
            case .CVS: return "https://cadiversityawards.com/wp-content/uploads/2024/06/CVS-Health-Awardee.png"
            case .Athena: return "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFEmTpwlJJ9Jb8YQthS1IaZMDj8yIKt2rFAw&s"
        }
    }
}

// MARK: CVSUIKit Class
// Acts a control center for the UI elements in the package
class CVSUIKit {
    
    // Singleton Shared Instance
    static let shared = CVSUIKit()
    
    // Private Init to make sure this is not called
    private init() {}
    
    // Current Design System
    var brand: Brand = .CVS
    
    // Get Brand Title
    var brandTitle: String {
        return brand.title
    }
    
    // Get Primary Brand Color
    var brandPrimaryColor: Color {
        return brand.primaryColor
    }
    
    // Get Secondary Brand Color
    var brandSecondary: Color {
        return brand.secondaryColor
    }
    
    // Get Brand Logo
    var brandLogoURL: String {
        return brand.logoURL
    }
}
