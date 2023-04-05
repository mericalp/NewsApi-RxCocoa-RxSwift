//
//  OnboardingCollectionViewCell.swift
//  NewsApp
//
//  Created by Meric Alp on 5.04.2023.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    func setup(_ slide: OnboardingSlide) {
        imageView.image = slide.image
        title.text = slide.title
        title.numberOfLines = 0
    }
}
