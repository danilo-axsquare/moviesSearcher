//
//  DetailMovieViewController.swift
//  MyMovies
//
//  Created by Danilo on 23/09/2018.
//  Copyright © 2018 Danilo Raspa. All rights reserved.
//

import UIKit

class DetailMovieViewController: MovieBaseViewController {
    
    public var movie: Movie?
    
    let backgroundImageView: UIImageView = {
        let poster = UIImageView()
        return poster
    }()
    
    let titleLabel: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.textAlignment = .left
        title.numberOfLines = 0
        title.font = UIFont.boldSystemFont(ofSize: 18)
        return title
    }()
    
    let descriptionTextView: UITextView = {
        let description = UITextView()
        description.textColor = .white
        description.textAlignment = .justified
        description.isOpaque = false
        description.backgroundColor = UIColor.clear
        description.font = UIFont.systemFont(ofSize: 17)
        return description
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Movie Details"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.showModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupUI() {
        self.view.addSubview(self.backgroundImageView)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.descriptionTextView)
        
        self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        
        //background image
        NSLayoutConstraint(item: self.backgroundImageView, attribute: .topMargin, relatedBy: .equal, toItem: self.view, attribute: .topMargin, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.backgroundImageView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.backgroundImageView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.backgroundImageView, attribute: .width, relatedBy: .equal, toItem: self.backgroundImageView, attribute: .height, multiplier: 16/9, constant: 0).isActive = true
       //title label
        NSLayoutConstraint(item: self.titleLabel, attribute: .top, relatedBy: .equal, toItem: self.backgroundImageView, attribute: .bottom, multiplier: 1, constant: 8).isActive = true
        NSLayoutConstraint(item: self.titleLabel, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -8).isActive = true
        NSLayoutConstraint(item: self.titleLabel, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 8).isActive = true
        //description text view
        NSLayoutConstraint(item: self.descriptionTextView, attribute: .top, relatedBy: .equal, toItem: self.titleLabel, attribute: .bottom, multiplier: 1, constant: 8).isActive = true
        NSLayoutConstraint(item: self.descriptionTextView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -8).isActive = true
        NSLayoutConstraint(item: self.descriptionTextView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 8).isActive = true
        NSLayoutConstraint(item: self.descriptionTextView, attribute: .bottomMargin, relatedBy: .equal, toItem: self.view, attribute: .bottomMargin, multiplier: 1, constant: 0).isActive = true
    }
    
    private func showModel() {
        self.titleLabel.text = self.movie?.title
        self.descriptionTextView.text = self.movie?.overview
        
        let defaultImage = UIImage(named: "default_backdrop")
        let urlBackground = self.movie?.retrieveBackgroundUrl()
        if let _urlBackground = urlBackground {
            self.backgroundImageView.setImage(withUrl: _urlBackground, defaultImage: defaultImage!)
        } else {
            self.backgroundImageView.image = defaultImage
        }        
    }
    
}
