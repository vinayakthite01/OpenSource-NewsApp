//
//  NewsList.swift
//  NewsApp
//
//  Created by Vinayak Thite on 21/08/22.
//

import UIKit

class NewsList: UIViewController {
    
    // MARK: Instance variables
    var viewModel: NewsListViewModelProtocol
    
    // MARK: Initializers

    init?(coder: NSCoder,
          viewModel: NewsListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("You must create this view controller.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
