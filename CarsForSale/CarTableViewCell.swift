//
//  CarTableViewCell.swift
//  CarsForSale
//
//  Created by Nishant Aggarwal on 8/29/17.
//  Copyright © 2017 Nishant Aggarwal. All rights reserved.
//

import UIKit

class CarTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var carInfo: UILabel!
    
    @IBOutlet weak var carPrice: UILabel!
    
}
