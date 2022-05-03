//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Арсений Корнилов on 27.02.2022.
//

import UIKit

class ProfileViewController: UIViewController, TapLikedDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        self.setupView()
        self.setupGesture()
        self.setupNavigationBar()
        self.addDataSource()
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.alpha = 0
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.didTapCloseButton), for: .touchUpInside)
        return button
    } ()
    
    private lazy var shadowView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    } ()
    
    var liked: Bool = false
    
    func tapLikedButton() {
        liked.toggle()
        self.tableView.reloadData()
    }
    
    private var centerX: NSLayoutConstraint?
    private var centerY: NSLayoutConstraint?
    private var imageWidth: NSLayoutConstraint?

    private var isExpanded = false
    
    private var heightConstraint: NSLayoutConstraint?
    
    private let prifileImageTapGesture = UITapGestureRecognizer()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(ToAllPhotosTableViewCell.self, forCellReuseIdentifier: "ToPhotosActionCell")
        tableView.register(HeaderTableViewCell.self, forCellReuseIdentifier: "HeaderCell")
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: "PhotoCell")
        tableView.register(DynamicArticleTableViewCell.self, forCellReuseIdentifier: "ArticleCell")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemRed
        imageView.image = UIImage(named: "Prof")
        imageView.layer.cornerRadius = 53
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    private func setupGesture () {
        self.prifileImageTapGesture.addTarget(self, action: #selector(self.tapGesture(_:)))
        self.imageView.addGestureRecognizer(self.prifileImageTapGesture)
    }
    
    @objc private func tapGesture(_ recognizedGesture: UITapGestureRecognizer) {
        guard self.prifileImageTapGesture === recognizedGesture else { return }
        
        self.isExpanded.toggle()
    
        self.centerX?.constant = self.isExpanded ? 0 : -118
        self.centerY?.constant = self.isExpanded ? -90 : -350
        self.imageWidth?.constant = self.isExpanded ? UIScreen.main.bounds.width : UIScreen.main.bounds.width/3.58
        
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.shadowView.alpha = self.isExpanded ? 0.9 : 0
            self.tabBarController?.tabBar.alpha = self.isExpanded ? 0 : 1
            self.navigationController?.navigationBar.alpha = self.isExpanded ? 0 : 1
            
            
        } completion: { _ in }
    
        UIView.animate(withDuration: 0.3, delay: 0.5) {
            self.closeButton.alpha = self.isExpanded ? 0.8 : 0
        } completion: { _ in }
    }
    
    @objc private func didTapCloseButton() {
        print("click")
        self.isExpanded.toggle()
    
        self.centerX?.constant = self.isExpanded ? 0 : -118
        self.centerY?.constant = self.isExpanded ? -90 : -350
        self.imageWidth?.constant = self.isExpanded ? UIScreen.main.bounds.width : UIScreen.main.bounds.width/3.58
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.shadowView.alpha = self.isExpanded ? 0.9 : 0
            self.tabBarController?.tabBar.alpha = self.isExpanded ? 0 : 1
            self.navigationController?.navigationBar.alpha = self.isExpanded ? 0 : 1
            
        } completion: { _ in }
    
        UIView.animate(withDuration: 0.3, delay: 0.5) {
            self.closeButton.alpha = self.isExpanded ? 0.8 : 0
        } completion: { _ in }
        
    }
    
    private lazy var jsonDecoder: JSONDecoder = {
        return JSONDecoder()
    }()
    
    //private var dataSource: [Posts] = []

    private func addDataSource() {
        dataSource.append(.init(author: "ИА 'Панорама'", description: "11 юристов из Королевства Саудовская Аравия войдут в специальную комиссию по разработке поправок к Конституции России, сообщает официальный сайт Кремля.", pic: "News0", id: "001", title: "Саудовские специалисты войдут в комиссию по разработке поправок в Конституцию РФ", publishedAt: "2022-03-14T18:00:00Z", likes: 50, views: 120))
        dataSource.append(.init(author: "Займись собой", description: "8 марта американский математик русского происхождения Генди Аджимов созвал консилиум математического общества США с предложением переименовать ось аппликат (или ось “Z”) в ось “И” краткое.", pic: "News1", id: "002", title: "Американская ассоциация математиков думает над переименованием оси Z ", publishedAt: "2022-03-14T18:00:00Z", likes: 50, views: 120))
        dataSource.append(.init(author: "ИА 'Панорама'", description: "В Москве с 15 марта начнут выписывать штрафы за ношение масок в публичных местах. Согласно указу мэра Сергея Собянина, масочный режим отменяется, равно как и ряд антиковидных мер для бизнеса.", pic: "News2", id: "003", title: "В Москве с завтрашнего дня будут штрафовать за ношение масок", publishedAt: "2022-03-14T18:00:00Z", likes: 10, views: 15))
        dataSource.append(.init(author: "ИА 'Панорама'", description: "Руководство Нижнетагильского металлургического комбината ждёт запросов от российских IT-компаний на поставку железа. Иностранные производители железа прекратили деятельность в России, освободив рынок.", pic: "News3", id: "005", title: "Нижнетагильский металлургический комбинат готов поставлять российским IT-компаниям железо для серверов", publishedAt: "2022-03-14T18:00:00Z", likes: 30, views: 40))
    }
    
//    struct Posts: Equatable {
//        let author, description, pic, id, title, publishedAt: String
//        var likes, views: Int
//    }
//
//    var dataSource: [Posts] = []
    
    
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
        
        self.tableView.addSubview(self.shadowView)
        self.view.addSubview(self.tableView)
        self.shadowView.addSubview(closeButton)
        self.tableView.addSubview(self.imageView)
    
        
        let topTableConstraint = self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let leadingTableConstraint = self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingTableConstraint = self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomTableConstraint = self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        let topShadowConstraint = self.shadowView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let leadingShadowConstraint = self.shadowView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingShadowConstraint = self.shadowView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomShadowConstraint = self.shadowView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        
        let closeButtonTopAnchor = self.closeButton.topAnchor.constraint(equalTo: self.shadowView.topAnchor, constant: 100)
        let closeButtonRightAnchor = self.closeButton.trailingAnchor.constraint(equalTo: self.shadowView.trailingAnchor, constant: -20)
        let closeButtonHeightAnchor = self.closeButton.heightAnchor.constraint(equalToConstant: 30)
        let closeButtonWidthAnchor = self.closeButton.widthAnchor.constraint(equalToConstant: 70)
        
        self.centerX = self.imageView.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor, constant: -118)
        self.centerY = self.imageView.centerYAnchor.constraint(equalTo: self.tableView.centerYAnchor, constant: -350)
        
        self.imageWidth = self.imageView.widthAnchor.constraint(equalToConstant: 106)
        
    
        let imageViewAspectRatio = self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 1.0)

        
        NSLayoutConstraint.activate([
             topTableConstraint
            , leadingTableConstraint
            , trailingTableConstraint
            , bottomTableConstraint
            , imageViewAspectRatio
             , self.centerY
             , self.centerX
             , self.imageWidth
             , topShadowConstraint
             , leadingShadowConstraint
             , trailingShadowConstraint
             , bottomShadowConstraint
             , closeButtonTopAnchor
             , closeButtonRightAnchor
             , closeButtonHeightAnchor
             , closeButtonWidthAnchor
        ].compactMap({ $0 }))
    }

//    private func fetchArticles(completion: @escaping ([News.Article]) -> Void) {
//        if let path = Bundle.main.path(forResource: "news", ofType: "json") {
//            do {
//                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
//
//                let news = try self.jsonDecoder.decode(News.self, from: data)
//                print("json data: \(news)")
//                completion(news.articles)
//            } catch let error {
//                print("parse error: \(error.localizedDescription)")
//            }
//        } else {
//            fatalError("Invalid filename/path.")
//        }
//    }
    
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count+3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.row {
        case 0 :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as? HeaderTableViewCell else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            let viewModel = HeaderTableViewCell.ViewModel(view: ProfileHeaderView())
            cell.setup(with: viewModel)
            return cell
        
        
       
        
        case 1:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToPhotosActionCell", for: indexPath) as? ToAllPhotosTableViewCell else {
                            
                            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                            return cell
                        }
                        let viewModel = ToAllPhotosTableViewCell.ViewModel(numberOfPictures: 4)
                        cell.setup(with: viewModel)
                        return cell
            
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotoTableViewCell else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            let viewModel = PhotoTableViewCell.ViewModel(numberOfPictures: 4, picture: UIImage(named: "News1"))
            cell.setup(with: viewModel)
            return cell
        
        default :
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? DynamicArticleTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            cell.likedDelegate = self
            if liked {
                dataSource[indexPath.row-3].likes += 1
                liked.toggle()
            }
            
            
            let article = dataSource[indexPath.row - 3]
            let viewModel = DynamicArticleTableViewCell.ViewModel(title: article.title, description: article.description, publishedAt: article.publishedAt, likes: article.likes, views: article.views, newsImage: UIImage(named: article.pic), ID: article.id)
            cell.setup(with: viewModel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        
        case 0,2:
            return
            
        case 1:
        self.navigationController?.pushViewController(PhotosViewController(), animated: true)
        
        default:
            let viewController = ExpandedArticleView()
            viewController.selectedDataImage = dataSource[indexPath.row - 3].pic
            viewController.selectedDataLikes = dataSource[indexPath.row - 3].likes
            viewController.selectedDataViews = dataSource[indexPath.row - 3].views + 1
            dataSource[indexPath.row - 3].views += 1
            viewController.selectedTitle = dataSource[indexPath.row - 3].title
            viewController.selectedDataDescription = dataSource[indexPath.row - 3].description
            self.tableView.reloadRows(at: [indexPath], with: .none)
            viewController.selectedDataID = dataSource [indexPath.row - 3].id
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}



extension ProfileViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: #selector(dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
        
    }
}
