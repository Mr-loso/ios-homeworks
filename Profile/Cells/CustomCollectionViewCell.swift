

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    struct ViewModel: ViewModelProtocol {
        let picture: UIImage?
    }
    
    private lazy var pictire: UIImageView = {
        let pic = UIImageView()
        pic.backgroundColor = .systemRed
        pic.layer.cornerRadius = 6
        pic.clipsToBounds = true
        pic.translatesAutoresizingMaskIntoConstraints = false
        return pic
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.pictire)
        let topTableConstraint = self.pictire.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        let leadingTableConstraint = self.pictire.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        let trailingTableConstraint = self.pictire.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        let bottomTableConstraint = self.pictire.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        
        NSLayoutConstraint.activate([topTableConstraint, leadingTableConstraint, trailingTableConstraint, bottomTableConstraint])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomCollectionViewCell: Setupable {

    func setup(with viewModel: ViewModelProtocol) {
        guard let viewModel = viewModel as? ViewModel else { return }
            
        self.pictire.image = viewModel.picture
    }
}
