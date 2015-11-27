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
    var categoriesArray:Array<Int> = []

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
        return categoriesArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("serviceCell", forIndexPath: indexPath) as!  HBServiceCollectionViewCell
        
        if categoriesArray.count > 0 {
            let category = categoriesArray[indexPath.row]
            cell.image.image = UIImage(named: "\(filterArrayON[category])")
            cell.tag = category
            
            cell.image.transform = CGAffineTransformMakeScale(0.1, 0.1)
            
            var delay = Double(indexPath.row)
            delay = delay/10
            
            UIView.animateWithDuration(0.5, delay: delay, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
                cell.image.transform = CGAffineTransformMakeScale(0.6, 0.6)
                }, completion: nil)
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! HBServiceCollectionViewCell
        
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            cell.image.transform = CGAffineTransformMakeScale(0.3, 0.3)
            }) { (Bool) -> Void in
                cell.image.image = UIImage(named: "\(self.filterArrayOFF[cell.tag])")
        }
        
        UIView.animateWithDuration(0.2, delay: 0.2, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            cell.image.transform = CGAffineTransformMakeScale(0.6, 0.6)
            }, completion: nil)
        
        //salvar num singleton
        print("Salvo no Singleton")
        HBServiceFilterSingleton.sharedInstance.selected.append(cell.tag)
        print(HBServiceFilterSingleton.sharedInstance.selected)
        
        //get a reference of tableview and refresh it
        //let tableView = cell.superview?.superview?.superview?.superview?.superview as! UITableView
        //tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! HBServiceCollectionViewCell
        
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            cell.image.transform = CGAffineTransformMakeScale(0.3, 0.3)
            }) { (Bool) -> Void in
                cell.image.image = UIImage(named: "\(self.filterArrayON[cell.tag])")
        }
        
        UIView.animateWithDuration(0.2, delay: 0.2, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            cell.image.transform = CGAffineTransformMakeScale(0.6, 0.6)
            }, completion: nil)
        
        //retirar do singleton
        print("Não Selecionado")
        for var i = 0; i < HBServiceFilterSingleton.sharedInstance.selected.count; i++ {
            if cell.tag == HBServiceFilterSingleton.sharedInstance.selected[i] {
                HBServiceFilterSingleton.sharedInstance.selected.removeAtIndex(i)
            }
        }
        print(HBServiceFilterSingleton.sharedInstance.selected)
    
        //get a reference of tableview and refresh it
        /*let tableView = cell.superview?.superview?.superview?.superview?.superview as! UITableView
        tableView.reloadData()*/
    }

}
