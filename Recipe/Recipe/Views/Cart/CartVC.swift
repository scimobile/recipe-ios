//
//  CartVC.swift
//  Recipe
//
//  Created by user(PaingLoop) on 17/08/2024.
//

import UIKit

class CartVC: UIViewController {
    
    // MARK: Properties
    private let tableView = UITableView(frame: .zero, style: .grouped)
    var dummyRecipeData = Recipe.dummyRecipeData()
    var ingredientsByCategory: [(String, [(Recipe, Ingredient)])] = []
    var doneIngredients: [(Recipe, Ingredient, originalSection: Int, originalIndex: Int)] = []
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if dummyRecipeData.isEmpty {
            showNoDataView()
        }
    }
    
    // MARK: UI Configuration
    private func configureUI() {
        title = "My Groceries"
        setupTableView()
        setupNavigationBar()
        groupIngredientsByCategory()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        if !dummyRecipeData.isEmpty {
            registerCells()
        }
    }
    
    private func registerCells() {
        let categoryTableViewCellNib = UINib(nibName: "CategoryTableViewCell", bundle: nil)
        let headerView = Bundle.main.loadNibNamed("RecipeCardCell", owner: self, options: nil)?.first as? RecipeCardCell
        headerView?.configure(with: dummyRecipeData)
        tableView.tableHeaderView = headerView
        tableView.register(categoryTableViewCellNib, forCellReuseIdentifier: "CategoryTableViewCell")
    }
    
    private func setupNavigationBar() {
        
        navigationController?.isNavigationBarHidden = false
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        navigationBarAppearance.backgroundColor = UIColor(named: "navigation-color")
        navigationBarAppearance.shadowColor = .clear
        
        navigationItem.standardAppearance = navigationBarAppearance
        navigationItem.compactAppearance = navigationBarAppearance
        navigationItem.scrollEdgeAppearance = navigationBarAppearance
        
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: #selector(showActionSheet))
        ]
    }
    
    private func groupIngredientsByCategory() {
        var tempDict = [String: [(Recipe, Ingredient)]]()
        
        for recipe in dummyRecipeData {
            for ingredient in recipe.ingredients {
                tempDict[ingredient.category, default: []].append((recipe, ingredient))
            }
        }
        
        ingredientsByCategory = tempDict.sorted(by: { $0.key < $1.key })
    }
    
    // MARK: No Data View
    func showNoDataView() {
        let noDataView = UIView(frame: tableView.bounds)
        noDataView.backgroundColor = UIColor(named: "navigation-color")
        
        let imageView = UIImageView(image: UIImage(named: "no_data_image"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = "Data Not Found"
        label.textAlignment = .center
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        
        noDataView.addSubview(imageView)
        noDataView.addSubview(label)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: noDataView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: noDataView.centerYAnchor, constant: -20),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            label.centerXAnchor.constraint(equalTo: noDataView.centerXAnchor)
        ])
        
        tableView.backgroundView = noDataView
    }
    
    // MARK: Selector
    @objc func showActionSheet() {
        let actionSheet = UIAlertController(title: "Choose an Option", message: "Select one of the following actions", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Clear List", style: .default, handler: { _ in
            print("Option 1 selected")
        }))
        actionSheet.addAction(UIAlertAction(title: "Share Ingredient List", style: .default, handler: { _ in
            print("Option 2 selected")
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.view.tintColor = .label
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func handleCheckboxTap(at indexPath: IndexPath) {
        var selectedIngredient: (Recipe, Ingredient)
        
        if indexPath.section < ingredientsByCategory.count {
            // Move from the original section to "Done"
            selectedIngredient = ingredientsByCategory[indexPath.section].1.remove(at: indexPath.row)
            doneIngredients.append((selectedIngredient.0, selectedIngredient.1, indexPath.section, indexPath.row))
            
            // Remove empty sections if necessary
            if ingredientsByCategory[indexPath.section].1.isEmpty {
                ingredientsByCategory.remove(at: indexPath.section)
            }
        } else {
            // Move back from "Done" to the original section
            let (recipe, ingredient, originalSection, originalIndex) = doneIngredients.remove(at: indexPath.row)
            
            if originalSection < ingredientsByCategory.count {
                ingredientsByCategory[originalSection].1.insert((recipe, ingredient), at: originalIndex)
            } else {
                ingredientsByCategory.append((ingredient.category, [(recipe, ingredient)]))
                ingredientsByCategory.sort(by: { $0.0 < $1.0 }) // Ensure sections remain sorted
            }
        }
        
        // Reload the table view to reflect the changes
        tableView.reloadData()    }
}

// MARK: Extensions
extension CartVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as? CategoryTableViewCell else {
            return UITableViewCell()
        }
        
        if indexPath.section < ingredientsByCategory.count {
            let (recipe, ingredient) = ingredientsByCategory[indexPath.section].1[indexPath.row]
            cell.configure(with: recipe, ingredient: ingredient, isDone: false)
            cell.setActiveStyle()
        } else {
            let (recipe, ingredient, _, _) = doneIngredients[indexPath.row]
            cell.configure(with: recipe, ingredient: ingredient, isDone: true)
            UIView.animate(withDuration: 0.5) {
                cell.setInactiveStyle()
            }
        }
        
        cell.checkboxTapped = { [weak self] in
            self?.handleCheckboxTap(at: indexPath)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < ingredientsByCategory.count {
            return ingredientsByCategory[section].1.count
        } else {
            return doneIngredients.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < ingredientsByCategory.count {
            return ingredientsByCategory[section].0
        } else {
            return "Done"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ingredientsByCategory.count + (doneIngredients.isEmpty ? 0 : 1)
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        // var selectedIngredient: (Recipe, Ingredient)
//
//        if indexPath.section < ingredientsByCategory.count {
//            let (recipe, ingredient) = ingredientsByCategory[indexPath.section].1.remove(at: indexPath.row)
//
//            doneIngredients.append((recipe, ingredient, indexPath.section, indexPath.row))
//
//            // Remove empty sections if necessary
//            if ingredientsByCategory[indexPath.section].1.isEmpty {
//                ingredientsByCategory.remove(at: indexPath.section)
//            }
//        } else {
//            let (recipe, ingredient, originalSection, originalIndex) = doneIngredients.remove(at: indexPath.row)
//            // If the original section still exists
//            if originalSection < ingredientsByCategory.count {
//                ingredientsByCategory[originalSection].1.insert((recipe, ingredient), at: originalIndex)
//            } else {
//                // If the original section was removed, recreate it
//                ingredientsByCategory.append((ingredient.category, [(recipe, ingredient)]))
//                ingredientsByCategory.sort(by: { $0.0 < $1.0 }) // Ensure sections are sorted
//            }
//        }
//
//        // Reload the table view to reflect the changes
//        tableView.reloadData()
//    }
}
