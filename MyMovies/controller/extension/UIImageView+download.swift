//
//  UIImageView+download.swift
//  MyMovies
//
//  Created by Danilo on 23/09/2018.
//  Copyright © 2018 Danilo Raspa. All rights reserved.
//

import Foundation
import UIKit

public extension UIImageView {
    
    public func setImage(withUrl url: URL, defaultImage: UIImage) {
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            var localImage = defaultImage
            if let _data = data {
                localImage = UIImage(data: _data)!
            }
            DispatchQueue.main.async {
                self.image = localImage
            }
        }
    }
    
}
