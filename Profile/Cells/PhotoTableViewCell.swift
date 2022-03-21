//
//  PhotoTableViewCell.swift
//  Navigation
//
//  Created by Арсений Корнилов on 20.03.2022.
//

import UIKit

final class PhotoTableViewCell: UITableViewCell {
    
    struct ViewModel: ViewModelProtocol {
        let numberOfPictures: Int
        let picture: UIImage?
    }
    
    private static var itemCount: CGFloat = 4
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        return layout
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
    
    var numberOfPictures: Int = 4
    
    private func setupView() {
        self.contentView.backgroundColor = .cyan
        
        self.contentView.addSubview(collectionView)
        
        let topConstraint = self.collectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        let leftConstraint = self.collectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        let rightConstraint = self.collectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        let bottomConstraint = self.collectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        let contentHeight = self.contentView.heightAnchor.constraint(equalToConstant: 50)
        
        NSLayoutConstraint.activate([
            topConstraint, leftConstraint, rightConstraint, bottomConstraint, contentHeight
        ].compactMap({ $0 }))
        
        
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func itemSize(for width: CGFloat, with spacing: CGFloat) -> CGSize {
        let neededWidth = width - 3 * spacing
        let itemWidth = floor(neededWidth / PhotoTableViewCell.itemCount)
        return CGSize(width: itemWidth, height: itemWidth)
    }
}


extension PhotoTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(PhotoTableViewCell.itemCount)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? CustomCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            
            cell.backgroundColor = .systemRed
            return cell
        }
    
       return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing
        
        return self.itemSize(for: collectionView.frame.width, with: spacing ?? 0)
    }

}

extension PhotoTableViewCell: Setupable {

    func setup(with viewModel: ViewModelProtocol) {
        guard let viewModel = viewModel as? ViewModel else { return }
            
        PhotoTableViewCell.itemCount = CGFloat(viewModel.numberOfPictures)
        
    }
}
