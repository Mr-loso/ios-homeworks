//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Арсений Корнилов on 27.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        setupNavigationBar()
        self.fetchArticles { [weak self] articles in
            self?.dataSource = articles
            self?.tableView.reloadData()
        }
    }
    
    private var heightConstraint: NSLayoutConstraint?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(DynamicArticleTableViewCell.self, forCellReuseIdentifier: "ArticleCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var jsonDecoder: JSONDecoder = {
        return JSONDecoder()
    }()
    
    private var dataSource: [News.Article] = []

    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    private func setupNavigationBar() {
        self.navigationItem.title = "Profile"
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = .white
        navBarAppearance.shadowImage = nil
        navBarAppearance.shadowColor = nil
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }

    private func setupView() {
        
        
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.profileHeaderView)
        
        let topTableConstraint = self.tableView.topAnchor.constraint(equalTo: self.profileHeaderView.bottomAnchor)
        let leadingTableConstraint = self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingTableConstraint = self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomTableConstraint = self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        self.profileHeaderView.backgroundColor = .systemGray6
        let topConstraint = self.profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let leadingConstraint = self.profileHeaderView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
        let trailingConstraint = self.profileHeaderView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        self.heightConstraint = self.profileHeaderView.heightAnchor.constraint(equalToConstant: 192)
        
        NSLayoutConstraint.activate([
            topConstraint
            , leadingConstraint
            , trailingConstraint
            , self.heightConstraint
            
            , topTableConstraint
            , leadingTableConstraint
            , trailingTableConstraint
            , bottomTableConstraint
        ].compactMap({ $0 }))
    }
    
    private func fetchArticles(completion: @escaping ([News.Article]) -> Void) {
        if let path = Bundle.main.path(forResource: "news", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
//                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let news = try self.jsonDecoder.decode(News.self, from: data)
                print("json data: \(news)")
                completion(news.articles)
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            fatalError("Invalid filename/path.")
        }
    }
    
}

extension ProfileViewController: ProfileHeaderViewProtocol {
    
    func didTapStatusButton(textFieldIsVisible: Bool, completion: @escaping () -> Void) {
        self.heightConstraint?.constant = textFieldIsVisible ? 230 : 188
        
        UIView.animate(withDuration: 0.25, delay: 0.0) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
}
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? DynamicArticleTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        
        let article = self.dataSource[indexPath.row]
        let viewModel = DynamicArticleTableViewCell.ViewModel(title: article.title,
                                                              description: article.description,
                                                              publishedAt: article.publishedAtString,
                                                              likes: article.likes,
                                                              views: article.views,
                                                              newsImage: UIImage(named: article.pic)
        )
        cell.setup(with: viewModel)
        return cell
    }
}
