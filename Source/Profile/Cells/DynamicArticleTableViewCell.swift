//
//  DynamicArticleTableView.swift
//  Navigation
//
//  Created by Арсений Корнилов on 16.03.2022.
//

import UIKit

final class DynamicArticleTableViewCell: UITableViewCell {
    
    struct ViewModel: ViewModelProtocol {
        let title: String
        let description: String
        let publishedAt: String
        let likes: String
        let views: String
        let newsImage: UIImage?
    }
    
    var likesCount = 0
    
    private lazy var NewsImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
        label.setContentCompressionResistancePriority(UILayoutPriority(250), for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "System", size: 14)
        label.textColor = .systemGray
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(self.backView)
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
        let topConstraint = self.backView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10)
        let leadingConstraint = self.backView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
        let trailingConstraint = self.backView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        let bottomConstraint = self.backView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
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
        let topButtonConstraint = self.likesButton.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor)
        let widthButtonConstraint = self.likesButton.widthAnchor.constraint(equalToConstant: 90)
        let heightButtonConstraint = self.likesButton.heightAnchor.constraint(equalToConstant: 26)
        let trailingViewsLabelConstraint = self.viewsLabel.leadingAnchor.constraint(equalTo: self.backView.safeAreaLayoutGuide.leadingAnchor)
        let topViewsLabelConstraint = self.viewsLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor)
        let widthiewsLabelConstraint = self.viewsLabel.widthAnchor.constraint(equalToConstant: 90)
        let heightiewsLabelConstraint = self.viewsLabel.heightAnchor.constraint(equalToConstant: 26)
        return [
            topConstraint, leadingConstraint, trailingConstraint, bottomConstraint, imageViewAspectRatio, heightButtonConstraint, trailingButtonConstraint, topButtonConstraint, widthButtonConstraint, trailingViewsLabelConstraint, topViewsLabelConstraint, widthiewsLabelConstraint, heightiewsLabelConstraint
        ]
    }
    
    
    @objc private func didTapLikeButton() {
        likesCount += 1
        self.likesButton.setTitle(String("likes: " + String (likesCount)), for: .normal)
    }
}



extension DynamicArticleTableViewCell: Setupable {
    
    func setup(with viewModel: ViewModelProtocol) {
        guard let viewModel = viewModel as? ViewModel else { return }
        self.titleLabel.text = viewModel.title
        self.descriptionLabel.text = viewModel.description
        self.dateTitle.text = viewModel.publishedAt
        self.NewsImage.image = viewModel.newsImage
    }
}

