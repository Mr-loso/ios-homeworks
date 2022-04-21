//
//  FullScreenImageView.swift
//  Navigation
//
//  Created by Арсений Корнилов on 09.04.2022.
//

import UIKit

class FullScreenImageView: UIViewController {
    
    struct ViewModel: ViewModelProtocol {
        let picture: UIImage?
    }
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .cyan
        return image
    } ()
    
    private lazy var shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    private func setupView() {
        
        self.view.addSubview(self.shadowView)
        self.shadowView.addSubview(self.image)
        self.tabBarController?.tabBar.alpha = 0
        self.navigationController?.navigationBar.alpha = 0
    }
    
    private func setupConstraints() {
        
        let centerY = self.image.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        let centerX = self.image.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let imageViewAspectRatio = self.image.heightAnchor.constraint(equalTo: self.image.widthAnchor, multiplier: 1.0)
        let trailingImageAnchor = self.image.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        
        let shadowViewTopAnchor = self.shadowView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let shadowViewBottomAnchor = self.shadowView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        let shadowViewLeftAnchor = self.shadowView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let shadowViewRightAnchor = self.shadowView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        
        NSLayoutConstraint.activate([ centerX, centerY, imageViewAspectRatio, trailingImageAnchor, shadowViewTopAnchor, shadowViewBottomAnchor, shadowViewLeftAnchor, shadowViewRightAnchor].compactMap({ $0 }))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        setupConstraints()
    }
    

}

extension FullScreenImageView: Setupable {

    func setup(with viewModel: ViewModelProtocol) {
        guard let viewModel = viewModel as? ViewModel else { return }
            
        self.image.image = viewModel.picture
    }
}
