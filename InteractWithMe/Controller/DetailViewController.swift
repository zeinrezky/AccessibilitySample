//
//  DetailViewController.swift
//  InteractWithMe
//
//  Created by zein rezky chandra on 04/08/19.
//  Copyright © 2019 Zein Rezky Chandra. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    fileprivate var headerView: UIView!
    fileprivate let kTableHeaderHeight: CGFloat = 300.0
    fileprivate var instructionViewModel: InstructionModel!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = 79
            tableView.rowHeight = UITableView.automaticDimension
        }
    }
    @IBOutlet var dishImageView: UIImageView!
    @IBOutlet var dishLabel: UILabel!
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    var recipe: Ingredient!

    override func viewDidLoad() {
        super.viewDidLoad()
        assert(recipe != nil)
        instructionViewModel = InstructionModel(recipe: recipe, type: .ingredient)
        setupRecipe()
    }
    @IBAction func toggleSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            instructionViewModel.type = .ingredient
        } else {
            instructionViewModel.type = .cookingInstructions
        }
        tableView.reloadData()
    }
    @IBAction func tapBackButton(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }
}

// MARK: - Setup
private extension DetailViewController {
    func setupRecipe() {
        dishImageView.image = recipe.photo
        dishLabel.text = recipe.name
    }
}

// MARK: - TableView Delegate & TableView Data Source
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return instructionViewModel.numberOfSections()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return instructionViewModel.numberOfItems()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: String(describing: InstructionCell.self), for: indexPath) as? InstructionCell)!
        if let description = instructionViewModel.itemFor(indexPath.item) {
            cell.configure(description)
        }
        let strike = instructionViewModel.getStateFor(indexPath.item)
        cell.shouldStrikeThroughText(strike)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        instructionViewModel.selectItemFor(indexPath.item)
        let cell = tableView.cellForRow(at: indexPath) as! InstructionCell
        let strike = instructionViewModel.getStateFor(indexPath.item)
        cell.shouldStrikeThroughText(strike)
    }
}
