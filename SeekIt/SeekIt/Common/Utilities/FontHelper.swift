//
//  FontHelper.swift
//  SeekIt
//
//  Created by g.b.rastogi on 30/09/24.
//

import UIKit

struct FontHelper {

    // Header Font (Large)
    static func headerFont() -> UIFont {
        return UIFont(font: FontFamily.ColaborateBold.regular, size: 24) ?? UIFont.systemFont(ofSize: 24, weight: .bold)
    }

    // Subheader Font (Medium)
    static func subHeaderFont() -> UIFont {
        return UIFont(font: FontFamily.ColaborateMedium.regular, size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .bold)
    }

    // Body Font (Regular)
    static func bodyFont() -> UIFont {
        return UIFont(font: FontFamily.ColaborateRegular.regular, size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .regular)
    }

    // Button Font (Bold)
    static func buttonFont() -> UIFont {
        return UIFont(font: FontFamily.ColaborateRegular.regular, size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .bold)
    }

    // Caption Font (Small)
    static func captionFont() -> UIFont {
        return UIFont(font: FontFamily.ColaborateRegular.regular, size: 12) ?? UIFont.systemFont(ofSize: 12, weight: .regular)
    }
}
