//
//  MovieBaseViewController.swift
//  MyMovies
//
//  Created by Danilo on 22/09/2018.
//  Copyright © 2018 Danilo Raspa. All rights reserved.
//

import UIKit

class MovieBaseViewController: UIViewController {
    
    private var spinnerView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    internal func showAlert(withMessage message: String) {
        self.hideLoader()
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    internal func showLoader() {
         self.view.endEditing(true)
        if (self.spinnerView == nil) {
            self.spinnerView = UIView.init(frame: self.view.bounds)
            self.spinnerView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        }
            let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
            ai.startAnimating()
            ai.center = (self.spinnerView?.center)!
        
        DispatchQueue.main.async {
            self.spinnerView?.addSubview(ai)
            self.view.addSubview(self.spinnerView!)
        }
    }
    
    internal func hideLoader() {
        DispatchQueue.main.async {
            self.spinnerView?.removeFromSuperview()
        }
    }
}
