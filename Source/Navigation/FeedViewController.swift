//
//  FirstViewController.swift
//  Navigation
//
//  Created by Арсений Корнилов on 23.02.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupGesture ()
        self.setupNavigationBar()
    }
    
    struct post11 {
        var title: String = "Дожить бы до завтра"
        var textOfPost: String = "На улице дубак, на сердце тлен и мрак, В интернете, как всегда, кто-то не прав, но мне плевать, На улице дубак, скорее бы весна, Что мне ваши катастрофы и теракты, мне б не знать о них..."
    }

    private lazy var profilePhoto: UIImageView = {
        let image = UIImageView()
        image.image = UIImage (named: "Prof")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 12
        image.isUserInteractionEnabled = true
        return image
    } ()
    
    private lazy var shadowView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    } ()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.alpha = 0
        button.backgroundColor = .darkGray
        button.addTarget(self, action: #selector(self.didTapCloseButton), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    private var left: NSLayoutConstraint?
    private var right: NSLayoutConstraint?
    
    private var isExpanded = false
    
    @IBOutlet weak var showNewsButton: UIButton!
 
    
    
    private let prifileImageTapGesture = UITapGestureRecognizer()
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Лента"
        self.navigationItem.backButtonTitle = "Назад"
    }
    
    private func setupView() {
        
        
        view.addSubview(shadowView)
        view.addSubview(profilePhoto)
        shadowView.addSubview(closeButton)
    
       let centerY = self.profilePhoto.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        self.left = self.profilePhoto.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 120)
        self.right = self.profilePhoto.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -120)
        let imageViewAspectRatio = self.profilePhoto.heightAnchor.constraint(equalTo: self.profilePhoto.widthAnchor, multiplier: 1.0)
        
        let closeButtonTopAnchor = self.closeButton.topAnchor.constraint(equalTo: self.shadowView.topAnchor, constant: 100)
        let closeButtonRightAnchor = self.closeButton.trailingAnchor.constraint(equalTo: self.shadowView.trailingAnchor, constant: -20)
        let closeButtonHeightAnchor = self.closeButton.heightAnchor.constraint(equalToConstant: 30)
        let closeButtonWidthAnchor = self.closeButton.widthAnchor.constraint(equalToConstant: 70)
       
        
        
        let shadowViewTopAnchor = self.shadowView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let shadowViewBottomAnchor = self.shadowView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        let shadowViewLeftAnchor = self.shadowView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let shadowViewRightAnchor = self.shadowView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        
        self.showNewsButton.layer.cornerRadius = 12
        self.showNewsButton.clipsToBounds = true
        self.showNewsButton.setTitle(FeedViewController.post11.init().title, for: .normal)
        self.showNewsButton.backgroundColor = .systemBlue
        self.showNewsButton.setTitleColor(.white, for: .normal)
        
        
        NSLayoutConstraint.activate([ centerY, self.left, self.right, imageViewAspectRatio, shadowViewTopAnchor, shadowViewBottomAnchor, shadowViewLeftAnchor, shadowViewRightAnchor, closeButtonTopAnchor,closeButtonHeightAnchor ,closeButtonWidthAnchor , closeButtonRightAnchor ].compactMap({ $0 }))
    }
    
    private func setupGesture () {
        self.prifileImageTapGesture.addTarget(self, action: #selector(self.tapGesture(_:)))
        self.profilePhoto.addGestureRecognizer(self.prifileImageTapGesture)
    }
    
    @objc private func tapGesture(_ recognizedGesture: UITapGestureRecognizer) {
        guard self.prifileImageTapGesture === recognizedGesture else { return }
        
        self.isExpanded.toggle()
    
        self.left?.constant = self.isExpanded ? 0 : 100
        self.right?.constant = self.isExpanded ? 0 : -100
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.shadowView.alpha = self.isExpanded ? 0.8 : 0
            self.tabBarController?.tabBar.alpha = self.isExpanded ? 0 : 1
            self.navigationController?.navigationBar.alpha = self.isExpanded ? 0 : 1
        } completion: { _ in
    }
    
        UIView.animate(withDuration: 0.3, delay: 0.5) {
            self.closeButton.alpha = self.isExpanded ? 0.8 : 0
        } completion: { _ in
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "showPostSegue",
            let postViewController = segue.destination as? PostViewController
        else { return }

        postViewController.ViewPost1 = FeedViewController.post11.init()
    }
    
    @objc private func didTapCloseButton() {
        
        
        self.isExpanded.toggle()
        self.left?.constant = self.isExpanded ? 0 : 100
        self.right?.constant = self.isExpanded ? 0 : -100
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.shadowView.alpha = self.isExpanded ? 0.8 : 0
            self.tabBarController?.tabBar.alpha = self.isExpanded ? 0 : 1
            self.navigationController?.navigationBar.alpha = self.isExpanded ? 0 : 1
        } completion: { _ in
    }
    
        UIView.animate(withDuration: 0.3, delay: 0.5) {
            self.closeButton.alpha = self.isExpanded ? 0.8 : 0
        } completion: { _ in
        }    }
}

