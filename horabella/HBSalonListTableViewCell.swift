//
//  HBSalonListTableViewCell.swift
//  horabella
//
//  Created by Yan Correa Trindade on 10/27/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit
import HCSStarRatingView

class HBSalonListTableViewCell: UITableViewCell {

    @IBOutlet weak var salonImage: UIImageView!
    @IBOutlet weak var salonName: UILabel!
    @IBOutlet weak var salonAddress: UILabel!
    @IBOutlet weak var salonEvaluation: HCSStarRatingView!
    @IBOutlet weak var salonDistance: UILabel!
    @IBOutlet weak var salonFavorite: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
