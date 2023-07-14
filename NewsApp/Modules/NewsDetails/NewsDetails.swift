//
//  NewsDetails.swift
//  NewsApp
//
//  Created by Vinayak Thite on 21/08/22.
//

import UIKit

class NewsDetails: UIViewController {
    
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDetailDescription: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: Instance variables
    private var viewModel: NewsDetailsViewModelProtocol
    
    // MARK: Initializers

    init?(coder: NSCoder,
          viewModel: NewsDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("You must create this view controller.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        self.title = "Article Details"
        self.imageView.setKFImage(image: viewModel.getNewsImageUrl())
        self.newsTitle.text = viewModel.getNewsTitle()
        self.newsDetailDescription.text = viewModel.getNewsContent()
    }

}
