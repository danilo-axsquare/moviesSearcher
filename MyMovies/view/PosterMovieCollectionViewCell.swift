//
//  PosterMovieCollectionViewCell.swift
//  MyMovies
//
//  Created by Danilo on 23/09/2018.
//  Copyright © 2018 Danilo Raspa. All rights reserved.
//

import UIKit

class PosterMovieCollectionViewCell: UICollectionViewCell {
    
    let posterImageView: UIImageView = {
        let poster = UIImageView()
        poster.clipsToBounds = true
        return poster
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(self.posterImageView)
        
        self.posterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self.posterImageView, attribute: NSLayoutAttribute.topMargin, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.topMargin, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.posterImageView, attribute: NSLayoutAttribute.bottomMargin, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.bottomMargin, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.posterImageView, attribute: NSLayoutAttribute.leadingMargin, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.leadingMargin, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.posterImageView, attribute: NSLayoutAttribute.trailingMargin, relatedBy: NSLayoutRelation.equal, toItem: self.contentView, attribute: NSLayoutAttribute.trailingMargin, multiplier: 1, constant: 0).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setModel(_ movie: Movie?) {
        let defaultImage = UIImage(named: "default_poster")
        let urlPoster = movie?.retrievePosterUrl()
        if let _urlPoster = urlPoster {
            self.posterImageView.setImage(withUrl: _urlPoster, defaultImage: defaultImage!)
        } else {
            self.posterImageView.image = defaultImage
        }        
    }
    
}
