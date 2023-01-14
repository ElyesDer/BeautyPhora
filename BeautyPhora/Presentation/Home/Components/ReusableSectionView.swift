//
//  ReusableSectionView.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 14/01/2023.
//

import UIKit

class ReusableSectionView: UICollectionReusableView {
    static let identifier = "ReusableSectionView"
    
    var label: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        label.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor,
                     padding: .init(top: 8, left: 10, bottom: 4, right: 4))
    }
    
    func setup(with label: String) {
        self.label.text = label
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
