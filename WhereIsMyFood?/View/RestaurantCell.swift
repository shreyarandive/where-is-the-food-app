//
//  RestaurantCell.swift
//  WhereIsMyFood?
//
//  Created by Shreya Randive on 7/24/19.
//  Copyright © 2019 Shreya Randive. All rights reserved.
//

import UIKit
import AlamofireImage

class RestaurantCell: UITableViewCell {

    @IBOutlet weak var restaurantImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    //@IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var actionBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with restaurant: RestaurantList) {
        restaurantImg.af_setImage(withURL: restaurant.imageUrl)
        nameLbl.text = restaurant.name
        //distanceLbl.text = restaurant.distance
    }
}
