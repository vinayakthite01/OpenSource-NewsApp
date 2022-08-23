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
    
    var newsArticlesCount: Int? = 0
    
    // MARK: Instance variables
    private var viewModel: NewsListViewModelProtocol
    private var country: String? {
        didSet {
            if let _country = country {
                self.title = "Top Headlines in \(_country)"
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
        self.title = "Top Headlines in US"
        viewModel.getTopHeadlines(forCountry: country?.lowercased() ?? "US".lowercased())
        viewModel.newsListResponder = updateUI(result: )
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
    
    // Update UI after the response
    private func updateUI(result: NewsListUIUpdateCase) {
        switch result {
        case .success:
            newsArticlesCount = viewModel.getNewsArticles()?.count
            self.newsTableView.reloadData()
        case .error(let error):
            let okHandler = { }
            showAlertView(title: "", message: error.localizedDescription, actions: [okHandler], titles: ["Ok"], actionStyle: .alert)
        }
    }
}

extension NewsList: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArticlesCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.cellIdentifier, for: indexPath) as? NewsCell {
            cell.newsImage.setKFImage(image: viewModel.getNewsImageUrl(forIndex: indexPath.row))
            cell.newsTitleLabel.text = viewModel.getNewsTitle(forIndex: indexPath.row)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.redirectToArticleDetails(forIndex: indexPath.row)
    }
}
