//
//  ToAllPhotosTableViewCell.swift
//  Navigation
//
//  Created by Арсений Корнилов on 22.03.2022.
//

import UIKit

final class ToAllPhotosTableViewCell: UITableViewCell {

    
    struct ViewModel: ViewModelProtocol {
        let numberOfPictures: Int
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var photoLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.backgroundColor = .clear
        label.numberOfLines = 1
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    private func setupView() {
        self.contentView.addSubview(photoLabel)
        
        let leftLabelConstraint = self.photoLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
    
        let centerY = self.photoLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
    
        NSLayoutConstraint.activate([
            leftLabelConstraint,
            centerY
        ].compactMap({ $0 }))
    }
}

extension ToAllPhotosTableViewCell: Setupable {

    func setup(with viewModel: ViewModelProtocol) {
        guard let viewModel = viewModel as? ViewModel else { return }
            
        self.photoLabel.text = "\(viewModel.numberOfPictures) photos"
        
    }
}
