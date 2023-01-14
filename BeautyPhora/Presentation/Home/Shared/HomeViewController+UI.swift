//
//  HomeViewController+UI.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 14/01/2023.
//

import Foundation
import UIKit
import RxSwift
import RxRelay
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
        
        viewModel.sectionModels
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
