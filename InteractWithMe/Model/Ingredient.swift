//
//  Ingredient.swift
//  InteractWithMe
//
//  Created by zein rezky chandra on 03/08/19.
//  Copyright © 2019 Zein Rezky Chandra. All rights reserved.
//

import UIKit

struct Ingredient {
    let name: String
    let price: String
    let photo: UIImage?
    let photoDescription: String
    let prepTime: Int
    let cookTime: Int
    let yield: Int
    let ingredients: [String]?
    let directions: [String]?
}

extension Ingredient {
    init?(dict: [String: AnyObject]) {
        guard let name = dict["name"] as? String,
            let price = dict["price"] as? String,
            let prepTime = dict["prepTime"] as? Int,
            let cookTime = dict["cookTime"] as? Int,
            let yield = dict["yield"] as? Int,
            let ingredients = dict["ingredients"] as? [String],
            let directions = dict["directions"] as? [String],
            let photoDescription = dict["photoDescription"] as? String else {
                return nil
        }
        
        self.name = name
        self.price = price
        self.prepTime = prepTime
        self.cookTime = cookTime
        self.yield = yield
        self.ingredients = ingredients
        self.directions = directions
        self.photoDescription = photoDescription
        
        if let imageName = dict["imageName"] as? String, !imageName.isEmpty {
            photo = UIImage(named: imageName)
        } else {
            photo = nil
        }
    }
}

// MARK: - Load Sample Data
extension Ingredient {
    static func loadDefaultRecipe() -> [Ingredient]? {
        return self.loadRecipeFrom("RecipeList")
    }
    static func loadRecipeFrom(_ plistName: String) -> [Ingredient]? {
        guard let path = Bundle.main.path(forResource: plistName, ofType: "plist"),
            let array = NSArray(contentsOfFile: path) as? [[String: AnyObject]] else {
                return nil
        }
        return array.map { Ingredient(dict: $0) }
            .filter { $0 != nil }
            .map { $0! }
    }
}
