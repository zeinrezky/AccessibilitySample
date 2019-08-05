//
//  InstructionModel.swift
//  InteractWithMe
//
//  Created by zein rezky chandra on 04/08/19.
//  Copyright © 2019 Zein Rezky Chandra. All rights reserved.
//

import Foundation

enum RecipeInstructionType {
    case ingredient
    case cookingInstructions
}

struct InstructionModel {
    let recipe: Ingredient?
    var type: RecipeInstructionType
    var ingredientsState = [Bool]()
    var directionsState = [Bool]()
    
    init(recipe: Ingredient, type: RecipeInstructionType) {
        self.recipe = recipe
        self.type = type
        if let ingredients = recipe.ingredients {
            ingredientsState = [Bool](repeating: false, count:ingredients.count)
        }
        if let directions = recipe.directions {
            directionsState = [Bool](repeating: false, count:directions.count)
        }
    }
    
    mutating func numberOfItems() -> Int {
        switch type {
        case .ingredient:
            if let ingredients = recipe?.ingredients {
                return ingredients.count
            }
        case .cookingInstructions:
            if let directions = recipe?.directions {
                return directions.count
            }
        }
        return 0
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func itemFor(_ index: Int) -> String? {
        switch type {
        case .ingredient:
            if let ingredients = recipe?.ingredients {
                return ingredients[index]
            }
        case .cookingInstructions:
            if let directions = recipe?.directions {
                return directions[index]
            }
        }
        return nil
    }
    
    func getStateFor(_ index: Int) -> Bool {
        switch type {
        case .ingredient:
            return ingredientsState[index]
        case .cookingInstructions:
            return directionsState[index]
        }
    }
    
    mutating func selectItemFor(_ index: Int) {
        switch type {
        case .ingredient:
            let previousState = ingredientsState[index]
            ingredientsState[index] = !previousState
        case .cookingInstructions:
            let previousState = directionsState[index]
            directionsState[index] = !previousState
        }
    }
}
