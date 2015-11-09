//
//  HBFilterCollectionViewController.swift
//  horabella
//
//  Created by Yan Correa Trindade on 11/3/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit
import QuartzCore

private let reuseIdentifier = "cell"

class HBFilterCollectionViewController: UICollectionViewController {
    
    let filterArrayON = ["filtro_cabeloON", "filtro_unhaON", "filtro_maquiagemON",
        "filtro_depilacaoON", "filtro_massagemON", "filtro_esteticaON",
        "filtro_popularidadeON", "filtro_localizacaoON", "filtro_favoritoON"]
    let filterName = ["CABELO", "UNHA", "MAQUIAGEM",
    "DEPILAÇÃO", "MASSAGEM", "ESTÉTICA",
    "POPULARES", "PRÓXIMOS", "FAVORITOS"]
    let filterArrayOFF = ["filtro_cabeloOFF", "filtro_unhaOFF", "filtro_maquiagemOFF",
        "filtro_depilacaoOFF", "filtro_massagemOFF", "filtro_esteticaOFF",
        "filtro_popularidadeOFF", "filtro_localizacaoOFF", "filtro_favoritoOFF"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NavBarSettings
        navigationController!.navigationBar.barTintColor = UIColor(netHex: 0x472C44) //background color
        self.navigationItem.title = "Filtros"
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        
        //Collection view settings
        self.collectionView?.delegate = self
        self.collectionView?.allowsMultipleSelection = true

        //layoutViewFlow
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1.0
        layout.minimumLineSpacing = 1.0
        layout.scrollDirection = .Vertical
        self.collectionView?.collectionViewLayout = layout
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }

    @IBAction func doneButtonBarItem(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! FilterCollectionViewCell
        
        //configure cell
        cell.filterNameLabel.text = filterName[indexPath.row]
        cell.backgroundColor = UIColor.clearColor()
        if (cell.selected) {
            let imageName = filterArrayON[indexPath.row]
            cell.imageView.image = UIImage(named: imageName)
            cell.filterNameLabel.textColor = UIColor.whiteColor()
            cell.layer.borderWidth = 0.5
            cell.layer.borderColor = UIColor.blackColor().CGColor
        } else {
            let imageName = filterArrayOFF[indexPath.row]
            cell.imageView.image = UIImage(named: imageName)
            cell.filterNameLabel.textColor = UIColor(hex: 0xff687a)
            cell.layer.borderWidth = 0.5
            cell.layer.borderColor = UIColor(hex: 0xff687a).CGColor
        }
        
        return cell;
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        let numberOfColumns = 3
        let numberOfRows = 3
        let itemWidth = (CGRectGetWidth(self.collectionView!.frame) - CGFloat(numberOfColumns - 1)) / CGFloat(numberOfColumns);
        let navPlusStatusBar = UIApplication.sharedApplication().statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.size.height)!
        let tabBarHeight = CGFloat(50)
        let itemHeight = (CGRectGetHeight(self.collectionView!.frame) - navPlusStatusBar - tabBarHeight - CGFloat(numberOfRows - 1)) / CGFloat(numberOfRows)
        //let itemHeight = (CGRectGetHeight(self.collectionView!.frame) - CGFloat(10) - CGFloat(numberOfRows - 1)) / CGFloat(numberOfRows)
        
        return CGSizeMake(itemWidth, itemHeight)
    }
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! FilterCollectionViewCell
        //cell.imageView.image = UIImage(named: filterArrayOFF[indexPath.row])
        let toImage = UIImage(named:filterArrayOFF[indexPath.row])
        UIView.transitionWithView(cell.imageView,
            duration:1.2,
            options: UIViewAnimationOptions.TransitionFlipFromBottom,
            animations: {
                cell.imageView.image = toImage
                cell.backgroundColor = UIColor.whiteColor()
                cell.filterNameLabel.textColor = UIColor(hex: 0xff687a)
            },
            completion: nil)
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! FilterCollectionViewCell
       // cell.imageView.image = UIImage(named: filterArrayON[indexPath.row])
        let toImage = UIImage(named:filterArrayON[indexPath.row])
        UIView.transitionWithView(cell.imageView,
            duration:1.2,
            options: UIViewAnimationOptions.TransitionFlipFromTop,
            animations: {
                cell.imageView.image = toImage
                cell.filterNameLabel.textColor = UIColor.whiteColor()
                cell.backgroundColor = UIColor(hex: 0xff687a)
            },
            completion: nil)
    }
    
}

extension UIColor {
    
    convenience init(hex: Int) {
        
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
        
    }
    
}
