//
//  InstructionCell.swift
//  InteractWithMe
//
//  Created by zein rezky chandra on 04/08/19.
//  Copyright © 2019 Zein Rezky Chandra. All rights reserved.
//

import UIKit

class InstructionCell: UITableViewCell {

    @IBOutlet var checkmarkButton: UIButton!
    @IBOutlet var descriptionLabel: UILabel!
    var type: RecipeInstructionType = .ingredient
    
    func configure(_ description: String) {
        descriptionLabel.text = description
    }
    
    @IBAction func checkmarkTapped(_ sender: AnyObject) {
        shouldStrikeThroughText(!checkmarkButton.isSelected)
    }
    
    func shouldStrikeThroughText(_ strikeThrough :Bool) {
        guard let text = descriptionLabel.text else {
            return
        }
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
        if strikeThrough {
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        }
        checkmarkButton.isSelected = strikeThrough
        descriptionLabel.attributedText = attributeString
    }
}
