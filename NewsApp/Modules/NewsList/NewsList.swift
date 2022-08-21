//
//  NewsList.swift
//  NewsApp
//
//  Created by Vinayak Thite on 21/08/22.
//

import UIKit

final class NewsList: UIViewController {
    
    /// IBOutlets
    @IBOutlet private weak var newsTableView: UITableView!
    
    // MARK: Instance variables
    private var viewModel: NewsListViewModelProtocol
    private var country: String? {
        didSet {
            if let _country = country {
                viewModel.getTopHeadlines(forCountry: _country.lowercased())
            }
        }
    }
    
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
        viewModel.getTopHeadlines(forCountry: country?.lowercased() ?? "US".lowercased())
        // Do any additional setup after loading the view.
    }
    
    @IBAction func chooseCountry() {
        let chooseUS = { [weak self] () -> Void in
            self?.country = "US"
        }
        let chooseCanada = { [weak self] () -> Void in
            self?.country = "Canada"
        }
        showAlertView(title: "", message: "Choose Country", actions: [chooseUS, chooseCanada], titles: ["US", "Canada"], actionStyle: .actionSheet)
        
    }
}

extension NewsList: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
