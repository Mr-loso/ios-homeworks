//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Арсений Корнилов on 27.02.2022.
//

import UIKit

protocol ProfileHeaderViewProtocol: AnyObject {
    func didTapStatusButton(textFieldIsVisible: Bool, completion: @escaping () -> Void)
}

class ProfileHeaderView: UIView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.alpha = 0
        imageView.backgroundColor = .systemRed
        imageView.layer.cornerRadius = 53
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3;
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var statusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(self.didTapStatusButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.setTitle("Set status", for: .normal)
       
        return button
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Set status"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = nil
        textField.backgroundColor = .systemGray4
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Arseny Kornilov"
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var buttonTopConstraint: NSLayoutConstraint?

    weak var delegate: ProfileHeaderViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawSelf()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawSelf() {
        self.addSubview(self.infoStackView)
        self.addSubview(self.statusButton)
        self.infoStackView.addArrangedSubview(self.imageView)
        self.infoStackView.addArrangedSubview(self.labelsStackView)
        self.labelsStackView.addArrangedSubview(self.nameLabel)
        self.labelsStackView.addArrangedSubview(self.statusLabel)
        self.labelsStackView.addArrangedSubview(self.textField)
        
        let topConstraint = self.infoStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 27)
        let leadingConstraint = self.infoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let trailingConstraint = self.infoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        
        let imageViewAspectRatio = self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: 1.0)
        
        self.buttonTopConstraint = self.statusButton.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 16)
        let leadingButtonConstraint = self.statusButton.leadingAnchor.constraint(equalTo: self.infoStackView.leadingAnchor)
        let trailingButtonConstraint = self.statusButton.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor)
        let bottomButtonConstraint = self.statusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        let heightButtonConstraint = self.statusButton.heightAnchor.constraint(equalToConstant: 50)
        
        
        
        NSLayoutConstraint.activate([
            topConstraint,
            leadingConstraint,
            trailingConstraint,
            imageViewAspectRatio,
            self.buttonTopConstraint,
            leadingButtonConstraint,
            trailingButtonConstraint,
            bottomButtonConstraint,
            heightButtonConstraint,
        ].compactMap({ $0 }))
        
    }
    
    
    
    @objc private func didTapStatusButton() {
            if textField.text != "" {
                self.statusLabel.text = self.textField.text
            }
            self.textField.text = nil
        }
    
}

extension UIImage {
    func showPictureFullScreen (image: String) {
        
    }
}
