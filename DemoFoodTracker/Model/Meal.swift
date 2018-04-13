//
//  Meal.swift
//  DemoFoodTracker
//
//  Created by Vu Ngoc Cong on 4/10/18.
//  Copyright © 2018 Vu Ngoc Cong. All rights reserved.
//

import UIKit

class Meal: Equatable{
    static func ==(lhs: Meal, rhs: Meal) -> Bool {
        return lhs.name == rhs.name
    }
    
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    init?(name: String, photo: UIImage?, rating: Int) {
        
        guard !name.isEmpty else {
            return nil
        }
        
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
}
