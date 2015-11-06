//
//  FilterCollectionViewCell.swift
//  horabella
//
//  Created by Yan Correa Trindade on 11/4/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var filterNameLabel: UILabel!
    
    let filterArrayON = ["filtro_cabeloON", "filtro_unhaON", "filtro_maquiagemON",
        "filtro_depilacaoON", "filtro_favoritoON", "filtro_esteticaON",
        "filtro_popularidadeON", "filtro_localizacaoON", "filtro_favoritoON"]

    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        filterNameLabel.text = nil
        self.selected = false
    }
    
}
