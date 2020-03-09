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
        
        let searchBarTextField = self.value(forKey: "searchField") as! UITextField
        let glassIconView = searchBarTextField.leftView as? UIImageView
        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
        glassIconView?.tintColor = .white
        
        searchBarTextField.layer.borderColor = UIColor.white.cgColor
        searchBarTextField.layer.borderWidth = 1.0
        searchBarTextField.layer.cornerRadius = 15.0
        searchBarTextField.leftView = glassIconView
        
        
        switch state {
        case .enabled:
            searchBarTextField.layoutSubviews()
        case .disabled:
            searchBarStyle = .default
            backgroundImage = UIImage()
            let searchBarTextField = self.value(forKey: "searchField") as! UITextField
            searchBarTextField.layer.borderColor = nil
            searchBarTextField.layer.borderWidth = 0
            searchBarTextField.layoutSubviews()
        }
    }
    
    func applyCornerRadius(value: CGFloat) {
        let searchBarTextField = self.value(forKey: "searchField") as! UITextField
        searchBarTextField.layer.cornerRadius = value
    }
    
}
