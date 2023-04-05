//
//  UIView+Extensions.swift
//  NewsApp
//
//  Created by Meric Alp on 5.04.2023.
//

import UIKit

extension UIView{
    @IBInspectable var cornerRadius: CGFloat{
        get { return self.cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    
}
