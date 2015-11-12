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
        
        //Collection view settings
        self.collectionView?.delegate = self
        self.collectionView?.allowsMultipleSelection = true
        self.collectionView?.allowsSelection = true

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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! HBFilterCollectionViewCell
        
        //configure cell
        cell.filterNameLabel.text = filterName[indexPath.row]
        cell.backgroundColor = UIColor.clearColor()
        //cell.selected
        if (HBFilter.sharedInstance.filtersArray.contains(String(indexPath.row))) {
            let imageName = filterArrayON[indexPath.row]
            cell.imageView.image = UIImage(named: imageName)
            cell.filterNameLabel.textColor = UIColor.whiteColor()
            cell.layer.borderWidth = 0.5
            cell.backgroundColor = UIColor(hex: 0xff687a)
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
        
        return CGSizeMake(itemWidth, itemHeight)
    }
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! HBFilterCollectionViewCell
        
        if HBFilter.sharedInstance.filtersArray.contains("\(indexPath.row)"){
            HBFilter.sharedInstance.filtersArray.removeAtIndex(indexPath.row)
        }
        
        print(HBFilter.sharedInstance.filtersArray)
        
        let toImage = UIImage(named:filterArrayOFF[indexPath.row])
        
        UIView.animateWithDuration(0.4) { () -> Void in
            cell.backgroundColor = UIColor.whiteColor()
            cell.filterNameLabel.textColor = UIColor(hex: 0xff687a)
        }
        
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            cell.imageView.transform = CGAffineTransformMakeScale(0.5, 0.5)
            }) { (Bool) -> Void in
                cell.imageView.image = toImage
        }
        
        UIView.animateWithDuration(0.2, delay: 0.2, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            cell.imageView.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: nil)
        
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! HBFilterCollectionViewCell
    
        HBFilter.sharedInstance.filtersArray.append("\(indexPath.row)")
        print(HBFilter.sharedInstance.filtersArray)
        
        let toImage = UIImage(named:filterArrayON[indexPath.row])
        
        UIView.animateWithDuration(0.4) { () -> Void in
            cell.backgroundColor = UIColor(hex: 0xff687a)
            cell.filterNameLabel.textColor = UIColor.whiteColor()
        }
        
        UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            cell.imageView.transform = CGAffineTransformMakeScale(0.5, 0.5)
            }) { (Bool) -> Void in
                cell.imageView.image = toImage
        }
        
        UIView.animateWithDuration(0.2, delay: 0.2, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            cell.imageView.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: nil)
        
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
