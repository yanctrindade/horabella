//
//  IJProgressView.swift
//  IJProgressView
//
//  Created by Isuru Nanayakkara on 1/14/15.
//  Copyright (c) 2015 Appex. All rights reserved.
//

import UIKit

public class IJProgressView {
    
    var containerView = UIView()
    var progressView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    var label = UILabel()
    
    public class var shared: IJProgressView {
        struct Static {
            static let instance: IJProgressView = IJProgressView()
        }
        return Static.instance
    }
    
    public func showProgressView(view: UIView) {
        containerView.frame = view.frame
        containerView.center = view.center
        containerView.center.y = view.center.y as CGFloat
        containerView.backgroundColor = UIColor(hex: 0xffffff, alpha: 0.3)
        
        progressView.frame = CGRectMake(0, 0, 120, 120)
        progressView.center = view.center
        progressView.backgroundColor = UIColor(hex: 0x444444, alpha: 0.7)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRectMake(0, 0, 80, 80)
        activityIndicator.activityIndicatorViewStyle = .WhiteLarge
        activityIndicator.center = CGPointMake(progressView.bounds.width / 2, progressView.bounds.height / 2)
        
        //Minha Alteração
        label.text = NSLocalizedString("Loading", comment: "")
        label.textAlignment = .Center
        label.textColor = UIColor.whiteColor()
        label.frame = CGRectMake(0, 0, 100, 30)
        label.center = CGPointMake(progressView.bounds.width / 2, progressView.bounds.height / 2-40)
        
        progressView.addSubview(activityIndicator)
        progressView.addSubview(label)
        containerView.addSubview(progressView)
        view.addSubview(containerView)
        
        activityIndicator.startAnimating()
    }
    
    public func showProgressView(view: UIView, message: String) {
        containerView.frame = view.frame
        containerView.center = view.center
        containerView.center.y = view.center.y as CGFloat
        containerView.backgroundColor = UIColor(hex: 0xffffff, alpha: 0.3)
        
        progressView.frame = CGRectMake(0, 0, 120, 120)
        progressView.center = view.center
        progressView.backgroundColor = UIColor(hex: 0x444444, alpha: 0.7)
        progressView.clipsToBounds = true
        progressView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRectMake(0, 0, 80, 80)
        activityIndicator.activityIndicatorViewStyle = .WhiteLarge
        activityIndicator.center = CGPointMake(progressView.bounds.width / 2, progressView.bounds.height / 2)
        
        //Minha Alteração
        label.text = message
        label.textAlignment = .Center
        label.textColor = UIColor.whiteColor()
        label.frame = CGRectMake(0, 0, 100, 30)
        label.center = CGPointMake(progressView.bounds.width / 2, progressView.bounds.height / 2-40)
        
        progressView.addSubview(activityIndicator)
        progressView.addSubview(label)
        containerView.addSubview(progressView)
        view.addSubview(containerView)
        
        activityIndicator.startAnimating()
    }
    
    public func hideProgressView() {
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
}

extension UIColor {
    
    convenience init(hex: UInt32, alpha: CGFloat) {
        let red = CGFloat((hex & 0xFF0000) >> 16)/256.0
        let green = CGFloat((hex & 0xFF00) >> 8)/256.0
        let blue = CGFloat(hex & 0xFF)/256.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}