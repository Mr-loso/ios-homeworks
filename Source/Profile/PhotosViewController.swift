//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Арсений Корнилов on 22.03.2022.
//

import UIKit

final class PhotosViewController: UIViewController {
    
    private var isExpanded = false
    var recivedImage: UIImage?
    static var itemsInRowCount: CGFloat = 3
    private let prifileImageTapGesture = UITapGestureRecognizer()
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        return layout
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.backgroundColor = .darkGray
        button.addTarget(self, action: #selector(self.didSelectedImage), for: .touchUpInside)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    private lazy var shadowView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()
    
    private lazy var expandedPhoto: UIImageView = {
        let image = UIImageView()
        image.alpha = 0
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.isUserInteractionEnabled = true
        return image
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupGesture ()
        self.navigationItem.title = "Photo Gallery"
        
        self.view.backgroundColor = .white
        self.view.addSubview(self.collectionView)
        self.view.addSubview(shadowView)
        self.view.addSubview(expandedPhoto)
        self.shadowView.addSubview(closeButton)
        let topConstraint = self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 8)
        let leftConstraint = self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8)
        let rightConstraint = self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 8)
        let bottomConstraint = self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 8)
        
        
        let centerY = self.expandedPhoto.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        let left = self.expandedPhoto.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let right = self.expandedPhoto.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let imageViewAspectRatio = self.expandedPhoto.heightAnchor.constraint(equalTo: self.expandedPhoto.widthAnchor, multiplier: 1.0)
        
        let shadowViewTopAnchor = self.shadowView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let shadowViewBottomAnchor = self.shadowView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        let shadowViewLeftAnchor = self.shadowView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let shadowViewRightAnchor = self.shadowView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        
        let closeButtonTopAnchor = self.closeButton.topAnchor.constraint(equalTo: self.shadowView.topAnchor, constant: 100)
        let closeButtonRightAnchor = self.closeButton.trailingAnchor.constraint(equalTo: self.shadowView.trailingAnchor, constant: -20)
        let closeButtonHeightAnchor = self.closeButton.heightAnchor.constraint(equalToConstant: 30)
        let closeButtonWidthAnchor = self.closeButton.widthAnchor.constraint(equalToConstant: 70)
        
        NSLayoutConstraint.activate([
            topConstraint, leftConstraint, rightConstraint, bottomConstraint, centerY, left, right, imageViewAspectRatio, shadowViewTopAnchor, shadowViewBottomAnchor, shadowViewLeftAnchor, shadowViewRightAnchor, closeButtonTopAnchor, closeButtonHeightAnchor ,closeButtonWidthAnchor , closeButtonRightAnchor
        ])
    }
    
        private func setupGesture () {
            self.prifileImageTapGesture.addTarget(self, action: #selector(self.tapGesture(_:)))
            self.expandedPhoto.addGestureRecognizer(self.prifileImageTapGesture)
        }
        
        @objc private func tapGesture(_ recognizedGesture: UITapGestureRecognizer) {
            guard self.prifileImageTapGesture === recognizedGesture else { return }

            self.isExpanded.toggle()
            
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
                self.shadowView.alpha = self.isExpanded ? 1 : 0
                self.tabBarController?.tabBar.alpha = self.isExpanded ? 0 : 1
                self.navigationController?.navigationBar.alpha = self.isExpanded ? 0 : 1
                self.expandedPhoto.alpha = self.isExpanded ? 1 : 0
                
            } completion: { _ in
            }
        }
    
    private func itemSize(for width: CGFloat, with spacing: CGFloat) -> CGSize {
        let neededWidth = width - 2 * spacing
        let itemWidth = floor(neededWidth / PhotosViewController.itemsInRowCount)
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
 
    
        
}

extension PhotosViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(19)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? CustomCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
        
            
            return cell
        }
        
        let viewModel = CustomCollectionViewCell.ViewModel(picture: UIImage(named: String(indexPath.row)))
        
        cell.setup(with: viewModel)
    
    
       return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing
        
        return self.itemSize(for: collectionView.frame.width, with: spacing ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell
        print(indexPath)
        recivedImage = cell?.getImage()
        didSelectedImage()
    }
    
    @objc private func didSelectedImage() {
        self.isExpanded.toggle()
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
            self.shadowView.alpha = self.isExpanded ? 1 : 0
            self.tabBarController?.tabBar.alpha = self.isExpanded ? 0 : 1
            self.navigationController?.navigationBar.alpha = self.isExpanded ? 0 : 1
            self.expandedPhoto.alpha = self.isExpanded ? 1 : 0
            
        } completion: { _ in
        }
        expandedPhoto.image = recivedImage
    }
    
    
    
}
