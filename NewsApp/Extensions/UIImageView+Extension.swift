//
//  UIImageView+Extension.swift
//  NewsApp
//
//  Created by Vinayak Thite on 23/08/22.
//

import UIKit
import Kingfisher

extension UIImageView {
        
    /// Downloads and sets the image from the given URL.
    /// Placeholder image is displayed while the image is being downloaded, and then replaced by the downloaded image.
    ///
    /// - Parameters:
    ///   - url: The image URL to use.
    ///   - placeholder: The placeholder image to use.
    func setKFImage(image url: String?, placeholder: String = "") {
        
        guard let path = url else { return }
                
        if placeholder.isEmpty {
            self.kf.indicatorType = .activity
            let indicator = self.kf.indicator?.view as? UIActivityIndicatorView
            indicator?.color = UIColor.systemBlue
        }
        
        self.kf.setImage(
            with: URL(string: path),
            placeholder: UIImage(named: placeholder),
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}
