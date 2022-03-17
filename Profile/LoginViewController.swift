//
//  LogInViewController.swift
//  Navigation
//
//  Created by Арсений Корнилов on 12.03.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupConstraints()
        view.backgroundColor = .white
    }

    private func setupView() {
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.contentView)
        self.contentView.addSubview(self.mainLogoImage)
        self.contentView.addSubview(self.logInButton)
        self.contentView.addSubview(loginPasswordStackView)
        self.loginPasswordStackView.addArrangedSubview(self.loginTextField)
        self.loginPasswordStackView.addArrangedSubview(self.passwordTextField)
        self.setupConstraints()
    }
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = self.view.bounds.size
        return scrollView
    }()
    
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
        button.backgroundColor = UIColor(named: "LoginButtonColor")
        button.addTarget(self, action: #selector(self.didTapStatusButton), for: .touchUpInside)
        button.setTitle("Log In", for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        } ()
    
    
    private func setupConstraints() {
        
        let scrollViewTopConstraint = self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let scrollViewRightConstraint = self.scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        let scrollViewBottomConstraint = self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        let scrollViewLeftConstraint = self.scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        
        let contentViewTopConstraint = self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor)
        let contentViewCenterXConstraint = self.contentView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        let contentViewBottomConstraint = self.contentView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        let contentViewWidthConstraint = self.contentView.widthAnchor.constraint(equalTo: self.view.widthAnchor)
        
        let topLogoConstraint = self.mainLogoImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 120)
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
            scrollViewTopConstraint
            , scrollViewRightConstraint
            , scrollViewBottomConstraint
            , scrollViewLeftConstraint
            
            , contentViewTopConstraint
            , contentViewCenterXConstraint
            , contentViewBottomConstraint
            , contentViewWidthConstraint
            
            , leadingButtonConstraint
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
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {super.viewWillAppear(animated)
        // подписаться на уведомления
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(kbdShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(kbdHide), name:UIResponder.keyboardWillHideNotification, object: nil)}
    
    
    override func viewDidDisappear(_ animated: Bool) {super.viewDidDisappear(animated)    // отписаться от уведомлений
        let nc = NotificationCenter.default
        nc.removeObserver(self, name:UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name:UIResponder.keyboardWillHideNotification, object: nil)}
    
    
    @objc private func didTapStatusButton() {
        show(ProfileViewController(), sender: nil)
        view.endEditing(true)
    }
    
    // Изменение отступов при появлении клавиатуры
    @objc private func kbdShow(notification: NSNotification) {
        if let kbdSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = kbdSize.height+40
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0,left: 0, bottom: kbdSize.height, right: 0)
            
        }
    }
    
    @objc private func kbdHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
}

}

