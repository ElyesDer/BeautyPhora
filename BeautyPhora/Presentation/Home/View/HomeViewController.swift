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

class HomeViewController: UIViewController {
    
    // MARK: - Variables
    
    var viewModel: HomeViewModel
    let disposeBag = DisposeBag()
    
    // MARK: - Views
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
        collectionView.backgroundColor = .white
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
        title = "Morning 💄"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Do any additional setup after loading the view.
        setupCollectionView()
        setupViews()
        setupConstraints()
        
        // setup binding
        bindViewModelToView()
    }
}

extension HomeViewController {
    
    private func bindViewModelToView() {
        bindCollectionView()
        
        viewModel.state
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] event in
                switch event {
                    case .next(let state):
                        switch state {
                            case .loading:
                                self?.activityIndicationView.startAnimating()
                            case .idle:
                                self?.activityIndicationView.stopAnimating()
                            case .error:
                                self?.activityIndicationView.stopAnimating()
                        }
                    default:
                        break
                }
            }
            .disposed(by: disposeBag)
    }
    
    fileprivate func setupViews() {
        collectionView.addSubview(activityIndicationView)
        view.addSubview(collectionView)
    }
    
    fileprivate func setupConstraints() {
        collectionView
            .anchor(top: view.safeAreaLayoutGuide.topAnchor,
                    leading: view.leadingAnchor,
                    bottom: view.safeAreaLayoutGuide.bottomAnchor,
                    trailing: view.trailingAnchor)
        
        activityIndicationView
            .center(with: collectionView)
        
        NSLayoutConstraint.activate([
            activityIndicationView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    fileprivate func setupCollectionView() {
        // Set up collection view
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        
        collectionView.register(ReusableSectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ReusableSectionView.identifier)
    }
}

// MARK: - Setup UICollectionView

extension HomeViewController {
    fileprivate func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (section, _) -> NSCollectionLayoutSection? in
            return ViewLayoutProvider(rawValue: section)?.layout ?? ViewLayoutProvider.default.layout
        }
    }
}
