//
//  HeaderViewCell.swift
//  Navigation
//
//  Created by Арсений Корнилов on 18.03.2022.
//

import UIKit

final class HeaderTableViewCell: UITableViewCell {
    
    struct ViewModel: ViewModelProtocol {
        let view: ProfileHeaderView
    }

    private var headerHeightConstraint: NSLayoutConstraint?
    private var contentHeightConstraint: NSLayoutConstraint?
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
        self.contentView.backgroundColor = .white
        
        self.contentView.addSubview(profileHeaderView)
    
        
        let topConstraint = self.profileHeaderView.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        let leadingConstraint = self.profileHeaderView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        let trailingConstraint = self.profileHeaderView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        self.headerHeightConstraint = self.profileHeaderView.heightAnchor.constraint(equalToConstant: 192)
        self.contentHeightConstraint = self.contentView.heightAnchor.constraint(equalToConstant: 230)
        
        
        
        NSLayoutConstraint.activate([
            topConstraint
            , leadingConstraint
            , trailingConstraint
            , headerHeightConstraint
            , contentHeightConstraint
            
        ].compactMap({ $0 }))
    }
    
    
}
extension HeaderTableViewCell: ProfileHeaderViewProtocol {
    
    func didTapStatusButton(textFieldIsVisible: Bool, completion: @escaping () -> Void) {
        
        self.headerHeightConstraint?.constant = textFieldIsVisible ? 230 : 188
        
        UIView.animate(withDuration: 0.25, delay: 0.0) {
            self.contentView.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
}

extension HeaderTableViewCell: Setupable {

    func setup(with viewModel: ViewModelProtocol) {
        guard let viewModel = viewModel as? ViewModel else { return }
            
        self.profileHeaderView = viewModel.view
    }
}


protocol ViewModelProtocol {}

protocol Setupable {
    func setup(with viewModel: ViewModelProtocol)
}
