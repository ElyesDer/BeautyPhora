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
    
    lazy var contentStackView: UIStackView = {
        let stackView: UIStackView = .init()
        
        // setup stackview
        stackView.axis = .vertical
        stackView.spacing = 1
        stackView.distribution = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 8, bottom: 0, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let productLabel: UILabel = {
        let label: UILabel = .init()
        label.sizeToFit()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label: UILabel = .init()
        label.sizeToFit()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 9, weight: .thin)
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
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
        
        setupViews()
        setupConstraint()
    }
    
    fileprivate func setupViews() {
        contentView.addSubview(container)
        
        container.addSubview(imageView)
        container.addSubview(contentStackView)
        
        contentStackView.addArrangedSubview(priceLabel)
        contentStackView.addArrangedSubview(productLabel)
        contentStackView.addArrangedSubview(descriptionLabel)
        
        contentStackView.backgroundColor = .white.withAlphaComponent(0.3)
        container.debugView(color: .lightGray.withAlphaComponent(0.1))
    }
    
    fileprivate func setupConstraint() {
        container.fillSuperview()
        
        imageView.anchor(top: container.topAnchor, leading: container.leadingAnchor, bottom: nil, trailing: container.trailingAnchor,
                         padding: .init(top: 0, left: 0, bottom: 4, right: 0))
        
        contentStackView.anchor(top: nil,
                                leading: container.leadingAnchor,
                                bottom: container.bottomAnchor,
                                trailing: container.trailingAnchor,
                                padding: .init(top: 4, left: 8, bottom: 8, right: 8))
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.6),
            contentStackView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.4)
        ])
    }
    
    public func setup(model: ProductModel) {
        guard let urlPreview = model.previewSmallImage else {
            imageView.image = .init(named: "im_default")
            return
        }
        productLabel.text = model.title
        descriptionLabel.text = model.description
        priceLabel.text = model.price
        imageView.imageFromServerURL(urlPreview, placeHolder: .init(named: "im_default"))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
