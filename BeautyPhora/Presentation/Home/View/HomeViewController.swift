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
    private var viewModel: HomeViewModel!
    private let disposeBag = DisposeBag()
    
    // MARK: - Views
    
    lazy var collectionViewLayout: UICollectionViewLayout = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.collectionView?.allowsSelection = true
        layout.itemSize = Dimensions.photosItemSize
        let numberOfCellsInRow = floor(Dimensions.screenWidth / Dimensions.photosItemSize.width)
        let inset = (Dimensions.screenWidth - (numberOfCellsInRow * Dimensions.photosItemSize.width)) / (numberOfCellsInRow + 1)
        layout.sectionInset = .init(top: inset,
                                    left: inset,
                                    bottom: inset,
                                    right: inset)
        return layout
        
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .white
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
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

// MARK: - Setup ViewController

extension HomeViewController {
    
    //    private func setupCollectionView() {
    //        self.view.addSubview(collectionView)
    //
    //        NSLayoutConstraint.activate([
    //            collectionView.leftAnchor
    //                .constraint(equalTo: self.view.leftAnchor),
    //            collectionView.topAnchor
    //                .constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
    //            collectionView.rightAnchor
    //                .constraint(equalTo: self.view.rightAnchor),
    //            collectionView.bottomAnchor
    //                .constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
    //        ])
    //
    //
    //        collectionView.register(PhotoCollectionViewCell.nib(),
    //                                forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
    //    }
    
    //    func createCollectionViewLayout() -> UICollectionViewFlowLayout {
    //        let layout = UICollectionViewFlowLayout()
    //        layout.scrollDirection = .vertical
    //        layout.collectionView?.allowsSelection = true
    //        layout.itemSize = Dimensions.photosItemSize
    //        let numberOfCellsInRow = floor(Dimensions.screenWidth / Dimensions.photosItemSize.width)
    //        let inset = (Dimensions.screenWidth - (numberOfCellsInRow * Dimensions.photosItemSize.width)) / (numberOfCellsInRow + 1)
    //        layout.sectionInset = .init(top: inset,
    //                                    left: inset,
    //                                    bottom: inset,
    //                                    right: inset)
    //        return layout
    //    }
}

// MARK: - Bind ViewModel To UI
extension HomeViewController {
    
    private func bindCollectionView() {
        
        viewModel.productList
            .filter({ !$0.isEmpty })
            .bind(to: collectionView.rx
                .items(cellIdentifier: ProductCollectionViewCell.identifier,
                       cellType: ProductCollectionViewCell.self)) { _, _, _ in}
            .disposed(by: disposeBag)
        
        collectionView.rx.willDisplayCell
            .observe(on: MainScheduler.instance)
            .compactMap({ ($0.cell as? ProductCollectionViewCell, $0.at.item) })
            .subscribe { [weak self] cell, indexPath in
                guard let self = self else { return }
                
                print("rendeering indexPath: ", indexPath)
                cell?.setup(model: self.viewModel.productList.value[indexPath])
                
                //                if let cachedImage = self.cachedImages[indexPath] {
                //                    /// use image from cached images
                //                    cell.imageView.image = cachedImage
                //                } else {
                //                    /// start animation for download image
                //                    cell.activityIndicator.startAnimating()
                //                    cell.imageView.image = nil
                //
                //                    /// download image
                //                    self.viewModel.loadImageFromGivenItem(with: indexPath)
                //                }
                
            }
            .disposed(by: disposeBag)
        
        //        // MARK: Bind selected model
        /// showing full screen when image clicked
        //        collectionView.rx.itemSelected
        //            .map({ $0.item })
        //            .subscribe { [weak self] indexPath in
        //                let row = indexPath.element ?? 0
        //
        //                if let cell = self?.collectionView.cellForItem(at: IndexPath(item: row, section: 0) ) as? PhotoCollectionViewCell {
        //                    let configuration = ImageViewerConfiguration { config in
        //                        config.imageView = cell.imageView
        //                    }
        //
        //                    let imageViewerController = ImageViewerController(configuration: configuration)
        //
        //                    self?.present(imageViewerController, animated: true)
        //                }
        //            }
        //            .disposed(by: disposeBag)
        
        //        // MARK: Trigger scroll view when ended
        //        collectionView.rx.willDisplayCell
        //            .filter({
        //                let currentSection = $0.at.section
        //                let currentItem    = $0.at.row
        //                let allCellSection = self.collectionView.numberOfSections
        //                let numberOfItem   = self.collectionView.numberOfItems(inSection: currentSection)
        //
        //                return currentSection == allCellSection - 1
        //                                        &&
        //                       currentItem >= numberOfItem - 1
        //            })
        //            .map({ _ in () })
        //            .bind(to: viewModel.scrollEnded)
        //            .disposed(by: disposeBag)
    }
    
    /// bind loaded image to cell
    //    private func bindImageLoader() {
    //        viewModel.imageDownloaded
    //            .observeOn(MainScheduler.instance)
    //            .filter({ $0.1 != nil })
    //            .map({ ($0.0, $0.1!) })
    //            .subscribe(onNext: { [unowned self] index, image in
    //                guard let cell = collectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? PhotoCollectionViewCell else {
    //                    return
    //                }
    //
    //                cell.animateCellWithImage(cell, image)
    //
    //                self.cachedImages[index] = image
    //            })
    //            .disposed(by: disposeBag)
    //    }
}
