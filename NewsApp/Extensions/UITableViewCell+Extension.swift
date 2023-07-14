//
//  UITableViewCell+Extension.swift
//  NewsApp
//
//  Created by Vinayak Thite on 23/08/22.
//

import Foundation
import UIKit

protocol TableViewCellIdentifiable {
    static var cellIdentifier: String { get }
}

extension TableViewCellIdentifiable where Self: UITableViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: TableViewCellIdentifiable {}
