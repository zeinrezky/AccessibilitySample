//
//  IngredientsCell.swift
//  InteractWithMe
//
//  Created by zein rezky chandra on 03/08/19.
//  Copyright © 2019 Zein Rezky Chandra. All rights reserved.
//

import UIKit

class IngredientsCell: UITableViewCell {

    @IBOutlet var roundedBackgroundView: UIView! {
        didSet {
            roundedBackgroundView.layer.cornerRadius = 3.0
            roundedBackgroundView.layer.masksToBounds = false
            roundedBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
            roundedBackgroundView.layer.shadowColor = #colorLiteral(red: 0.05439098924, green: 0.1344551742, blue: 0.1884709597, alpha: 1).cgColor
            roundedBackgroundView.layer.shadowRadius = 1.0
            roundedBackgroundView.layer.shadowOpacity = 0.3
        }
    }
    @IBOutlet var foodImageView: UIImageView! {
        didSet {
            foodImageView.layer.cornerRadius = 3.0
        }
    }
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet var dishNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func configureCell(with recipe:Ingredient) {
        dishNameLabel.text = recipe.name
        foodImageView.image = recipe.photo
        priceLabel.text = recipe.price
    }
}
