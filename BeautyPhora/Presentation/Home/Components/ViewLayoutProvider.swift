//
//  ViewLayoutProvider.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 14/01/2023.
//

import UIKit

enum ViewLayoutProvider: Int {
    case favorite = 0
    case `default` = 1
    
    var layout: NSCollectionLayoutSection {
        switch self {
            case .favorite:
                return buildFavoriteLayout()
            case .default:
                return buildStandardLayout()
        }
    }
    
    private var sectionHeader: NSCollectionLayoutBoundarySupplementaryItem {
        return .init(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(45.0)),
                     elementKind: UICollectionView.elementKindSectionHeader,
                     alignment: .top)
    }
    
    private func buildStandardLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(0.6))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        let spacing = CGFloat(10)
        group.interItemSpacing = .fixed(spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    private func buildFavoriteLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalWidth(0.6)
            ),
            subitem: item,
            count: 1
        )
        group.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
}
