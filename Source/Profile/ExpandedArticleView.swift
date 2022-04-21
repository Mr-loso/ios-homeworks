//
//  ExpandedArticleView.swift
//  Navigation
//
//  Created by Арсений Корнилов on 13.04.2022.
//

import UIKit


class ExpandedArticleView: UIViewController {
    
    override func viewDidLoad() {
        self.navigationItem.title = "Article"
        super.viewDidLoad()
        self.setupView()
    }
    
    var selectedDataLikes, selectedTitle, selectedDataDescription, selectedDataImage: String?
    var  selectedDataViews: Int?
    
    var likesCount = 0
    
    private lazy var NewsImage: UIImageView = {
        let im = UIImageView()
        im.clipsToBounds = true
        if let image = selectedDataImage {
            im.image = UIImage(named: selectedDataImage ?? "prof")
        }
        im.translatesAutoresizingMaskIntoConstraints = false
        return im
    } ()
    
    private lazy var backView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.layer.maskedCorners = [
            .layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner
        ]
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        
        if let text = selectedTitle {
            label.text = text
        }
        
        label.setContentCompressionResistancePriority(UILayoutPriority(250), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "System", size: 14)
        label.textColor = .darkGray
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        if let text = selectedDataDescription {
            label.text = text
        }
        label.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var dateTitle: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.alpha = 0
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .gray
        label.setContentCompressionResistancePriority(UILayoutPriority(750), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var viewsLabel: UIButton = {
        let label = UIButton()
        label.backgroundColor = .systemBlue
        label.alpha = 0.6
        label.setTitle("views: 1", for: .normal)
        label.layer.cornerRadius = 11
        label.clipsToBounds = true

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var likesButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.alpha = 0.6
        button.addTarget(self, action: #selector(self.didTapLikeButton), for: .touchUpInside)
        button.setTitle("likes: 0", for: .normal)
        button.layer.cornerRadius = 11
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        } ()
    
    
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.backView)
        self.backView.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.titleLabel)
        self.stackView.addArrangedSubview(self.NewsImage)
        self.stackView.addArrangedSubview(self.descriptionLabel)
        self.stackView.addArrangedSubview(self.dateTitle)
        self.stackView.addSubview(self.likesButton)
        self.stackView.addSubview(self.viewsLabel)
        let backViewConstraints = self.backViewConstraints()
        let stackViewConstraints = self.stackViewConstraints()
        NSLayoutConstraint.activate(backViewConstraints + stackViewConstraints)
    }
    private func backViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.backView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 18)
        let leadingConstraint = self.backView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
        let trailingConstraint = self.backView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
        let bottomConstraint = self.backView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -165)
        return [
            topConstraint, leadingConstraint, trailingConstraint, bottomConstraint
        ]
    }
    private func stackViewConstraints() -> [NSLayoutConstraint] {
        let topConstraint = self.stackView.topAnchor.constraint(equalTo: self.backView.topAnchor)
        let leadingConstraint = self.stackView.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor)
        let trailingConstraint = self.stackView.trailingAnchor.constraint(equalTo: self.backView.trailingAnchor)
        let bottomConstraint = self.stackView.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor)
        
        let imageViewAspectRatio = self.NewsImage.heightAnchor.constraint(equalTo: self.NewsImage.widthAnchor, multiplier: 0.5625)
    
        let trailingButtonConstraint = self.likesButton.trailingAnchor.constraint(equalTo: self.backView.safeAreaLayoutGuide.trailingAnchor)
        let topButtonConstraint = self.likesButton.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor)
        let widthButtonConstraint = self.likesButton.widthAnchor.constraint(equalToConstant: 90)
        let heightButtonConstraint = self.likesButton.heightAnchor.constraint(equalToConstant: 26)
        let trailingViewsLabelConstraint = self.viewsLabel.leadingAnchor.constraint(equalTo: self.backView.leadingAnchor)
        let topViewsLabelConstraint = self.viewsLabel.bottomAnchor.constraint(equalTo: self.backView.bottomAnchor)
        let widthiewsLabelConstraint = self.viewsLabel.widthAnchor.constraint(equalToConstant: 90)
        let heightiewsLabelConstraint = self.viewsLabel.heightAnchor.constraint(equalToConstant: 26)
        return [
            topConstraint, leadingConstraint, trailingConstraint, bottomConstraint, imageViewAspectRatio, heightButtonConstraint, trailingButtonConstraint, topButtonConstraint, widthButtonConstraint, trailingViewsLabelConstraint, topViewsLabelConstraint, widthiewsLabelConstraint, heightiewsLabelConstraint
        ]
    }
    
    
    
    
    @objc private func didTapLikeButton() {
        
        print("TAP")
        likesCount += 1
        self.likesButton.setTitle(String("likes: " + String (likesCount)), for: .normal)
    }
}


