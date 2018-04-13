//
//  ViewController.swift
//  DemoFoodTracker
//
//  Created by Vu Ngoc Cong on 4/10/18.
//  Copyright © 2018 Vu Ngoc Cong. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UISearchBarDelegate {

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var filtered: [Meal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        filtered = DataServices.shared.meal
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension MealViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MealTableViewCell
        let meals = filtered[indexPath.row]
        cell.nameMeal.text = meals.name
        cell.photoImageView.image = meals.photo
        cell.ratingControl.rating = meals.rating
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            if searchBar.text != "" {
                if let index = DataServices.shared.meal.index(of: filtered[indexPath.row]) {
                    DataServices.shared.meal.remove(at: index)
                    filtered.remove(at: indexPath.row)
                    tableView.reloadData()
                }
            }else{
                DataServices.shared.meal.remove(at: indexPath.row)
                filtered = DataServices.shared.meal
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .insert:
            print("insert")
        case .none:
            print("none")
        
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? DetailViewController {
            if let indexPath = tableView.indexPathForSelectedRow {
                if let index = DataServices.shared.meal.index(of: filtered[indexPath.row]) {
                    detailVC.index = index
                }
            }
        }
    }
}

