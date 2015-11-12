//
//  FilterCollectionViewCell.swift
//  horabella
//
//  Created by Yan Correa Trindade on 11/4/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit

class HBFilterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var filterNameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        filterNameLabel.text = nil
    }
    
}
