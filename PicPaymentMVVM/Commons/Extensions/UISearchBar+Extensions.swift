//
//  UISearchBar+Extensions.swift
//  PicPayment
//
//  Created by Hundily Cerqueira on 11/09/19.
//  Copyright © 2019 PicPayment. All rights reserved.
//

import UIKit

enum SearchBarState {
    case enabled
    case disabled
}

extension UISearchBar {

    func setLayout(state: SearchBarState) {
        searchBarStyle = .minimal
        setShowsCancelButton(true, animated: true)

        let searchBarTextField = self.value(forKey: "searchField") as? UITextField

        if let searchBarText = searchBarTextField {
            let glassIconView = searchBarText.leftView as? UIImageView
            glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
            glassIconView?.tintColor = .white

            searchBarText.layer.borderColor = UIColor.white.cgColor
            searchBarText.layer.borderWidth = 1.0
            searchBarText.layer.cornerRadius = 15.0
            searchBarText.leftView = glassIconView

            switch state {
            case .enabled:
                searchBarText.layoutSubviews()
            case .disabled:
                searchBarStyle = .default
                backgroundImage = UIImage()
                let searchBarTextField = self.value(forKey: "searchField") as? UITextField
                if let searchBarText = searchBarTextField {
                    searchBarText.layer.borderColor = nil
                    searchBarText.layer.borderWidth = 0
                    searchBarText.layoutSubviews()
                }
            }
        }
    }

    func applyCornerRadius(value: CGFloat) {
        let searchBarTextField = self.value(forKey: "searchField") as? UITextField
        if let searchBarText = searchBarTextField {
            searchBarText.layer.cornerRadius = value
        }
    }
}
