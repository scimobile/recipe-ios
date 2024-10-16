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
    private lazy var vm: CartVM = CartVM.shared
    private var headerView: RecipeCardCell?
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: UI Configuration
    private func configureUI() {
        title = "My Groceries"
        setupTableView()
        setupNavigationBar()
    
        vm.onIngredientsChanged = { [weak self] in
            self?.tableView.reloadData()
        }
        
        vm.onNoData = { [weak self] in
            self?.showNoDataView()
            self?.tableView.reloadData()
            self?.tableView.tableHeaderView = nil
        }
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        if !vm.recipeObjects.isEmpty {
            registerCells()
        }
    }
    
    private func registerCells() {
        let categoryTableViewCellNib = UINib(nibName: "CategoryTableViewCell", bundle: nil)
        
        headerView = Bundle.main.loadNibNamed("RecipeCardCell", owner: self, options: nil)?.first as? RecipeCardCell
        headerView?.configure(with: vm.recipeObjects, delegate: self)
        tableView.tableHeaderView = headerView
        tableView.register(categoryTableViewCellNib, forCellReuseIdentifier: "CategoryTableViewCell")
    }
    
    private func updateHeaderView() {
        headerView?.configure(with: vm.recipeObjects, delegate: self)
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
            print("DEBUG: Delete All Realm Data")
            self.vm.deleteAllData()
        }))
        actionSheet.addAction(UIAlertAction(title: "Share Ingredient List", style: .default, handler: { _ in
            print("Option 2 selected")
            self.shareAll()
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.view.tintColor = .label
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func shareAll() {
        let text = "This is the text...."
        let image = UIImage(named: "dummy")
        let myWebsite = NSURL(string:"www.google.com")!
        let shareAll = [text , image! , myWebsite] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func reloadData() {
        self.vm.loadRecipeDataFromRealm()
    }
    
    @objc func recipeDelete() {
        if vm.recipeObjects.isEmpty {
            print("DEBUG: No more recipes, hiding table view")
            tableView.reloadData()
            showNoDataView()
        } else {
            tableView.reloadData()
            updateHeaderView()
        }
    }
}

// MARK: Extensions
extension CartVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as? CategoryTableViewCell else {
            return UITableViewCell()
        }
        
        if indexPath.section < vm.ingredientsByCategory.count {
            let (recipe, ingredient) = vm.ingredientsByCategory[indexPath.section].1[indexPath.row]
            cell.configure(with: recipe, ingredient: ingredient, isDone: false)
            cell.setActiveStyle()
        } else {
            let (recipe, ingredient, _, _) = vm.doneIngredients[indexPath.row]
            cell.configure(with: recipe, ingredient: ingredient, isDone: true)
            UIView.animate(withDuration: 0.5) {
                cell.setInactiveStyle()
            }
        }
        
        cell.checkboxTapped = { [weak self] in
            self?.vm.handleCheckboxTap(at: indexPath)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < vm.ingredientsByCategory.count {
            return vm.ingredientsByCategory[section].0
        } else {
            return "Done"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return vm.numberOfSections()
    }
}
extension CartVC: RecipeCardViewCellDelegate {
    func didUpdateIngredientQuantity(forRecipeId recipeId: String, newQuantity: String) {
        vm.updateIngredientQuantity(recipeId: recipeId, newQuantity: newQuantity)
        self.reloadData()
    }

    func didTapDeleteRecipe(with recipeId: String) {
        vm.deleteRecipebyId(recipeId: recipeId)
        self.recipeDelete()
    }
}
