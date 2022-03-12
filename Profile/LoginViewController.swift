//
//  LogInViewController.swift
//  Navigation
//
//  Created by Арсений Корнилов on 12.03.2022.
//

import UIKit

//protocol ProfileLogInViewProtocol: AnyObject {
//    func didTapStatusButton(textFieldIsVisible: Bool, completion: @escaping () -> Void)
//}

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraints()
        
        view.backgroundColor = UIColor.systemBlue
    }

    
    private func setupView() {
        self.view.addSubview(logInButton)
        self.setupConstraints()
        
    }
    
    private var mainLogoImage: UIImageView {
        let imview = UIImageView()
        imview.image = UIImage (named: "logo")
        
        return imview
    }

    private let logInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray
        button.setTitle("Log In", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        
        return button
        } ()
    
    private func setupConstraints() {
        //logInButton.center = view.center
        
        let leadingConstraint = self.logInButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        let trailingConstraint = self.logInButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        let buttomConstraint = self.logInButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        let hightConstraint = self.logInButton.heightAnchor.constraint(equalToConstant: 50)

        NSLayoutConstraint.activate([
            leadingConstraint,
            trailingConstraint,
            buttomConstraint,
            hightConstraint
        ].compactMap({ $0 }))
    }
    
    @objc private func didTapStatusButton() {
        self.logInButton.backgroundColor = .green
        show(ProfileViewController(), sender: nil)
        
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logInButton.addTarget(self, action: #selector(self.didTapStatusButton), for: .touchUpInside)
    }
}



