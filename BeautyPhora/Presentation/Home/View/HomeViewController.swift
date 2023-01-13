//
//  HomeViewController.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 12/01/2023.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa
import RxDataSources

class HomeViewController: UIViewController {
    
    // MARK: - Variables
    private var viewModel: HomeViewModel!
    private let disposeBag = DisposeBag()
    
    // MARK: - Views
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
        collectionView.backgroundColor = .white
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        return collectionView
    }()
    
    lazy var activityIndicationView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    // MARK: - Life cycle
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        setupCollectionView()
        setupViews()
        setupConstraints()
        
        // setup binding
        bindViewModelToView()
    }
}

extension HomeViewController {
    
    // setup binding
    func bindViewModelToView() {
        bindCollectionView()
    }
    
    fileprivate func setupViews() {
        collectionView.addSubview(activityIndicationView)
        view.addSubview(collectionView)
    }
    
    fileprivate func setupConstraints() {
        collectionView
            .anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        
        NSLayoutConstraint.activate([
            activityIndicationView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            activityIndicationView.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor),
            activityIndicationView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    fileprivate func setupCollectionView() {
        // Set up collection view
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
    }
}

// MARK: - Setup UICollectionView

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section, _) -> NSCollectionLayoutSection? in
            if section == 0 {
                // item
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)
                
                // group
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalWidth(0.6)
                    ),
                    subitem: item,
                    count: 1
                )
                group.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
                
                // section
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
                
                // return
                return section
                
            } else if section == 1 {
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .fractionalWidth(0.6))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
                let spacing = CGFloat(10)
                group.interItemSpacing = .fixed(spacing)
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = spacing
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
                
                return section
            }
            return nil
        }
    }
}

// MARK: - Bind ViewModel To UI
extension HomeViewController {
    
    private func bindCollectionView() {
        
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
