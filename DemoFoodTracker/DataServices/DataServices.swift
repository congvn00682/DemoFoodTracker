//
//  DataServices.swift
//  DemoFoodTracker
//
//  Created by Vu Ngoc Cong on 4/10/18.
//  Copyright © 2018 Vu Ngoc Cong. All rights reserved.
//

import UIKit

class DataServices{
    
    static let shared: DataServices = DataServices()
    
    private var _meals: [Meal]?
    
    var meal: [Meal]{
        set{
            _meals = newValue
        }
        get{
            if _meals == nil {
                updateData()
            }
            return _meals ?? []
        }
    }
    
    func updateData(){
        _meals = []
        let meal1 = Meal(name: "Caprese Salad", photo: #imageLiteral(resourceName: "meal1"), rating: 4)
        let meal2 = Meal(name: "Chicken and Potatoes", photo: #imageLiteral(resourceName: "meal2"), rating: 5)
        let meal3 = Meal(name: "Pasta with Meatballs", photo: #imageLiteral(resourceName: "meal3"), rating: 3)
        _meals = [meal1!, meal2!, meal3!]
    }
    
    func addMeal(_ meal: Meal){
        _meals?.append(meal)
    }
    
}
