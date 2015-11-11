//
//  HBServicesTableViewCell.swift
//  horabella
//
//  Created by Erick Leal on 10/11/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit

class HBServicesTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let filterArrayON = ["filtro_cabeloON", "filtro_unhaON", "filtro_maquiagemON",
        "filtro_depilacaoON", "filtro_massagemON", "filtro_esteticaON",
        "filtro_popularidadeON", "filtro_localizacaoON", "filtro_favoritoON"]
    let filterArrayOFF = ["filtro_cabeloOFF", "filtro_unhaOFF", "filtro_maquiagemOFF",
        "filtro_depilacaoOFF", "filtro_massagemOFF", "filtro_esteticaOFF",
        "filtro_popularidadeOFF", "filtro_localizacaoOFF", "filtro_favoritoOFF"]

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.allowsMultipleSelection = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - CollectionView
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("serviceCell", forIndexPath: indexPath) as!  HBServiceCollectionViewCell
        
        cell.image.image = UIImage(named: "\(filterArrayON[indexPath.row])")
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! HBServiceCollectionViewCell
        
        UIView.transitionWithView(cell.image,
            duration:0.6,
            options: UIViewAnimationOptions.TransitionCrossDissolve,
            animations: {
                cell.image.image = UIImage(named: "\(self.filterArrayOFF[indexPath.row])")
            },
            completion: nil)
        
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! HBServiceCollectionViewCell
        
        UIView.transitionWithView(cell.image,
            duration:0.6,
            options: UIViewAnimationOptions.TransitionCrossDissolve,
            animations: {
                cell.image.image = UIImage(named: "\(self.filterArrayON[indexPath.row])")
            },
            completion: nil)
    }

}
