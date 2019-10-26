//
//  TaskVO.swift
//  firestoreAssignment
//
//  Created by Aung Ko Ko on 25/10/2019.
//  Copyright © 2019 Phone Zaw Myint. All rights reserved.
//

import Foundation
struct FoodVO {
    var amount : String?
    var food_name : String?
    var imageUrl : String?
    var rating: String?
    var waiting_time: String?
    var id: String
    
    var dictionary: [String: Any] {
        return
            [ "amount": amount,
              "food_name": food_name,
              "imageUrl" : imageUrl,
              "rating" : rating,
              "waiting_time" : waiting_time,
                ]
    }
}

extension FoodVO{
    init?(dictionary:[String: Any],id: String) {
        guard let amount = dictionary["amount"] as? String,
              let food_name = dictionary["food_name"] as?  String,
        let imageUrl = dictionary["imageUrl"] as?  String,
        let rating = dictionary["rating"] as?  String,
        let waiting_time = dictionary["waiting_time"] as?  String
        else {return nil}
        
        self.init(amount: amount, food_name: food_name, imageUrl: imageUrl, rating: rating, waiting_time: waiting_time, id: id)
    }
}
