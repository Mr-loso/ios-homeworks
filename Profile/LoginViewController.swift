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
        
        view.backgroundColor = .white
    }

    
    private func setupView() {
        self.view.addSubview(self.mainLogoImage)
        self.view.addSubview(self.logInButton)
        self.view.addSubview(loginPasswordStackView)
        self.loginPasswordStackView.addArrangedSubview(self.loginTextField)
        self.loginPasswordStackView.addArrangedSubview(self.passwordTextField)
        self.setupConstraints()
        
    }
    
    private lazy var loginPasswordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    } ()
    
    private lazy var loginTextField: UITextField = {
        let login = UITextField()
        
        login.placeholder = " Email or phone"
        login.layer.borderWidth = 0.5
        login.layer.borderColor = UIColor.lightGray.cgColor
        login.layer.cornerRadius = 10
        login.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        login.backgroundColor = .systemGray6
        login.translatesAutoresizingMaskIntoConstraints = false
        
        return login
    } ()
    
    private lazy var passwordTextField: UITextField = {
        let pass = UITextField()
        
        
        pass.placeholder = " Password"
        pass.layer.borderWidth = 0.5
        pass.layer.borderColor = UIColor.lightGray.cgColor
        pass.layer.cornerRadius = 10
        pass.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        pass.isSecureTextEntry = true
        pass.backgroundColor = .systemGray6
        pass.translatesAutoresizingMaskIntoConstraints = false
        return pass
    } ()
    
    private lazy var mainLogoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage (named: "logo")
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    } ()

    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor (named: "LoginButtonColor")
        button.setTitle("Log In", for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
        } ()
    
    private func setupConstraints() {
        
        let topLogoConstraint = self.mainLogoImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 120)
        let heghtLogoConstraint = self.mainLogoImage.heightAnchor.constraint(equalToConstant: 100)
        let xPosLogoConstraint = self.mainLogoImage.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: self.view.center.x)
        let logoAspectRatio = self.mainLogoImage.heightAnchor.constraint(equalTo: self.mainLogoImage.widthAnchor, multiplier: 1.0)
        
        let stackViewTopConstraint = self.loginPasswordStackView.topAnchor.constraint(equalTo: self.mainLogoImage.bottomAnchor, constant: 120)
        let stackViewTrailingConstraint = self.loginPasswordStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        let stackViewLeadingConstraint = self.loginPasswordStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        let stackViewHeightConstraint = self.loginPasswordStackView.heightAnchor.constraint(equalToConstant: 100)
        
        let leadingButtonConstraint = self.logInButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        let trailingButtonConstraint = self.logInButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        let topButtonConstraint = self.logInButton.topAnchor.constraint(equalTo: self.loginPasswordStackView.bottomAnchor, constant: 16)
        let heghtButtonConstraint = self.logInButton.heightAnchor.constraint(equalToConstant: 50)

        NSLayoutConstraint.activate([
            leadingButtonConstraint
            , trailingButtonConstraint
            , topButtonConstraint
            , heghtButtonConstraint
            
            , logoAspectRatio
            , topLogoConstraint
            , heghtLogoConstraint
            , xPosLogoConstraint
            
            , stackViewTopConstraint
            , stackViewTrailingConstraint
            , stackViewLeadingConstraint
            , stackViewHeightConstraint
        ].compactMap({ $0 }))
    }
    
    @objc private func didTapStatusButton() {
        self.logInButton.alpha = 0.9
        show(ProfileViewController(), sender: nil)
        
    
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logInButton.addTarget(self, action: #selector(self.didTapStatusButton), for: .touchUpInside)
        
        
    }
    
    
}



