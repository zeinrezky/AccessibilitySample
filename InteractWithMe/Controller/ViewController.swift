//
//  ViewController.swift
//  InteractWithMe
//
//  Created by zein rezky chandra on 03/08/19.
//  Copyright © 2019 Zein Rezky Chandra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = 100
            tableView.rowHeight = UITableView.automaticDimension
        }
    }
    var ingredients = [Ingredient]()
    var selectedRecipe: Ingredient?
    
    // MARK: - UIView Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let seedRecipe = Ingredient.loadDefaultRecipe() {
            ingredients += seedRecipe
            ingredients = ingredients.sorted(by: { $0.name < $1.name })
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRecipe" {
            if let vc = segue.destination as? DetailViewController {
                vc.recipe = selectedRecipe
            }
        }
    }
}

// MARK: - TableView Delegate & TableView Data Source
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: IngredientsCell.self), for: indexPath) as! IngredientsCell
        let recipe = ingredients[indexPath.item]
        cell.configureCell(with: recipe)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedRecipe = ingredients[indexPath.item]
        performSegue(withIdentifier: "showRecipe", sender: self)
    }
}
