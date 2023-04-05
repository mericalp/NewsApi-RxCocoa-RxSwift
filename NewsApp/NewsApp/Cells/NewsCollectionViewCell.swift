//
//  NewsCollectionViewCell.swift
//  NewsApp
//
//  Created by Meric Alp on 4.04.2023.
//

import UIKit

class NewsCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.numberOfLines = 0
        descriptionLabel.numberOfLines = 0
    }
 
}
