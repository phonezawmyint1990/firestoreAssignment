//
//  FoodItemTableViewCell.swift
//  firestoreAssignment
//
//  Created by Aung Ko Ko on 25/10/2019.
//  Copyright © 2019 Phone Zaw Myint. All rights reserved.
//

import UIKit
import SDWebImage

class FoodItemTableViewCell: UITableViewCell {
    @IBOutlet weak var ivFood: UIImageView!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var lblWaitingIssues: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
    var food: FoodVO?{
        didSet{
            if let food = food {
    lblFoodName.text = food.food_name
    lblAmount.text = "$ \(food.amount!) "
    lblWaitingIssues.text = "Prepare in \(food.waiting_time!) mins"
                ivFood.sd_setImage(with: URL(string: food.imageUrl!), placeholderImage: UIImage(named: "place_holder"))
    
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        ivFood.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
