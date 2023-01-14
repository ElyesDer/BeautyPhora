//
//  HomeViewController+UI.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 14/01/2023.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

// MARK: - Bind ViewModel To UI

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func bindCollectionView() {
        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionViewModel> { _, collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for: indexPath) as? ProductCollectionViewCell
            cell?.setup(model: item)
            return cell ?? .init()
        }
        
        dataSource.configureSupplementaryView = {(section, collectionView, _, indexPath) -> UICollectionReusableView in
            
            guard let header = collectionView
                .dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ReusableSectionView.identifier, for: indexPath) as? ReusableSectionView
            else {
                return UICollectionReusableView()
            }
            header.setup(with: section[indexPath.section].header)
            return header
        }
        
        viewModel.sectionModels
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: ReusableSectionView.identifier,
            for: indexPath) as? ReusableSectionView else { return UICollectionReusableView(frame: .zero) }
        
        return headerView
    }
}
