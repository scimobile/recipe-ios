//
//  HomeVC.swift
//  Recipe
//
//  Created by Thant Sin Htun on 23/08/2024.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var tvRecipe: UITableView!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var btnAddToCart: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        initBindings()
    }
    
    private func setupViews(){
        tvRecipe.registerCell(ofType: RecipeHorizontalCell.self)

        tvRecipe.dataSource = self
        tvRecipe.delegate = self
        tvRecipe.rowHeight = UITableView.automaticDimension
        tvRecipe.separatorStyle = .none
        tvRecipe.contentInset = .zero
        tvRecipe.showsVerticalScrollIndicator = false

        btnAddToCart.titleLabel?.font = .popB14
        
    }
    private func initBindings(){
        
    }
}

extension HomeVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.deque(RecipeHorizontalCell.self, indexPath)
        return cell
    }
    
    
}
extension HomeVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tap index \(indexPath.row)")
    }
}
