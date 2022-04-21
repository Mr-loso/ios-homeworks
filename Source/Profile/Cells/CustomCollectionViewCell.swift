

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    struct ViewModel: ViewModelProtocol {
        let picture: UIImage?
    }
    
    private let prifileImageTapGesture = UITapGestureRecognizer()
    
    private lazy var pic: UIImageView = {
        let pic = UIImageView()
        pic.backgroundColor = .systemRed
        pic.layer.cornerRadius = 6
        pic.image = UIImage (named: "5")
        pic.clipsToBounds = true
        pic.translatesAutoresizingMaskIntoConstraints = false
        pic.isUserInteractionEnabled = true
        return pic
    } ()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.contentView.addSubview(self.pic)
        let topTableConstraint = self.pic.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        let leadingTableConstraint = self.pic.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        let trailingTableConstraint = self.pic.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        let bottomTableConstraint = self.pic.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        
        NSLayoutConstraint.activate([topTableConstraint, leadingTableConstraint, trailingTableConstraint, bottomTableConstraint])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getImage () -> UIImage {
        return pic.image!
    }
}

extension CustomCollectionViewCell: Setupable {

    func setup(with viewModel: ViewModelProtocol) {
        guard let viewModel = viewModel as? ViewModel else { return }
            
        self.pic.image = viewModel.picture
    }
}
