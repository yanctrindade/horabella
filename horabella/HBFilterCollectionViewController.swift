//
//  HBFilterCollectionViewController.swift
//  horabella
//
//  Created by Yan Correa Trindade on 11/3/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class HBFilterCollectionViewController: UICollectionViewController {
    
    let filterArrayON = ["filtro_cabeloON", "filtro_unhaON", "filtro_maquiagemON",
        "filtro_depilacaoON", "filtro_favoritoON", "filtro_esteticaON",
        "filtro_popularidadeON", "filtro_localizacaoON", "filtro_favoritoON"]
    let filterName = ["CABELO", "UNHA", "MAQUIAGEM",
    "DEPILAÇÃO", "MASSAGEM", "ESTÉTICA",
    "POPULARIDADE", "LOCALIZAÇÃO", "FAVORITOS"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NavBarSeetings
        self.navigationController?.title = "Filtros"

        // Do any additional setup after loading the view.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1.0
        layout.minimumLineSpacing = 1.0
        layout.scrollDirection = .Vertical
        self.collectionView?.collectionViewLayout = layout
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! FilterCollectionViewCell
        
        let imageName = filterArrayON[indexPath.row]
        cell.imageView.image = UIImage(named: imageName)
        cell.filterNameLabel.text = filterName[indexPath.row]
        // Configure the cell
        //cell.backgroundColor = UIColor.blackColor()
        //cell.contentMode = .Center*/
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        let numberOfColumns = 3
        let itemWidth = (CGRectGetWidth(self.collectionView!.frame) - CGFloat(numberOfColumns - 1)) / CGFloat(numberOfColumns);
        
        return CGSizeMake(itemWidth, itemWidth+30)
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
