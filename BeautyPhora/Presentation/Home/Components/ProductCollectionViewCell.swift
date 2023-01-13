//
//  ProductCollectionViewCell.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 13/01/2023.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ProductCollectionViewCell"
    
    lazy var container: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let productLabel: UILabel = {
        let label: UILabel = .init()
        label.sizeToFit()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .thin)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        self.debugView()
        setupViews()
        setupConstraint()
        //        setupShadowEffect()
    }
    
    fileprivate func setupViews() {
        contentView.addSubview(container)
        
        container.addSubview(imageView)
        container.addSubview(productLabel)
        
        //        contentView.debugView(color: .lightGray)
        
    }
    
    fileprivate func setupShadowEffect(on view: UIView) {
        view.backgroundColor = .systemBackground
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = CGSize(width: 0, height: 10) // .zero
        view.layer.shadowOpacity = 0.2
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.masksToBounds = false
    }
    
    fileprivate func setupConstraint() {
        container.fillSuperview()
        
        imageView.anchor(top: container.topAnchor, leading: container.leadingAnchor, bottom: nil, trailing: container.trailingAnchor,
                         padding: .init(top: 4, left: 8, bottom: 4, right: 8))
        
        productLabel.anchor(top: nil,
                            leading: container.leadingAnchor,
                            bottom: container.bottomAnchor,
                            trailing: container.trailingAnchor,
                            padding: .init(top: 4, left: 8, bottom: 8, right: 8))
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.7),
            productLabel.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.3)
        ])
    }
    
    public func setup(model: PProduct) {
        guard !model.image.small.isEmpty else {
            imageView.image = .init(named: "im_default")
            return
        }
        productLabel.text = model.name
        imageView.imageFromServerURL(model.image.small, placeHolder: .init(named: "im_default"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
