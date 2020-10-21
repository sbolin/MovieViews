//
//  MovieViewController.swift
//  MovieViews
//
//  Created by Scott Bolin on 10/20/20.
//

import UIKit

class MovieViewController: UIViewController {
    
// MARK: - Properties
    let moviesController = MovieController()
    var collectionView: UICollectionView! = nil
    var dataSource: UICollectionViewDiffableDataSource<MovieController.MovieCollection, MovieController.Movie>! = nil
    var currentSnapshot: NSDiffableDataSourceSnapshot<MovieController.MovieCollection, MovieController.Movie>! = nil
    static let sectionHeaderElementKind = "section-header-element-kind"
    static let sectionFooterElementKind = "section-footer-element-kind"
    
    
// MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Popcorn Swirl"
        configureHierarchy()
        configureDataSource()
    }
}
// MARK: - Extensions
extension MovieViewController {
    
    func createLayout() -> UICollectionViewLayout {
        
        let cellHeight:CGFloat = 250
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 12
        
        let sectionProvider = {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // if we have the space, adapt and go 2-up + peeking 3rd item
            let groupFractionalWidth = CGFloat(layoutEnvironment.container.effectiveContentSize.width > 500 ?
                                                0.425 : 0.85)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupFractionalWidth), heightDimension: .absolute(cellHeight))
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPagingCentered // originally .continuous
            section.interGroupSpacing = 10
            //           section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: MovieViewController.sectionHeaderElementKind,
                alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
            return section
        }
        
        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: sectionProvider, configuration: config)
        return layout
    }
}

extension MovieViewController {
    func configureHierarchy() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration
        <MovieCell, MovieController.Movie> { (cell, indexPath, movie) in
            // Populate the cell with our item description.
            cell.titleLabel.text = movie.title
            cell.descriptionLabel.text = movie.genre
            cell.yearLabel.text = String(movie.year)
        }
        
        dataSource = UICollectionViewDiffableDataSource
        <MovieController.MovieCollection, MovieController.Movie>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, movie: MovieController.Movie) -> UICollectionViewCell? in
            // Return the cell.
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: movie)
        }
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<TitleSupplementaryView>(elementKind: "Footer") { (supplementaryView, string, indexPath) in
            if let snapshot = self.currentSnapshot {
                let movieCollection = snapshot.sectionIdentifiers[indexPath.section]
                supplementaryView.label.text = movieCollection.genre
            }
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: supplementaryRegistration, for: index)
        }
        
        currentSnapshot = NSDiffableDataSourceSnapshot
        <MovieController.MovieCollection, MovieController.Movie>()
        moviesController.collections.forEach {
            let collection = $0
            currentSnapshot.appendSections([collection])
            currentSnapshot.appendItems(collection.movies)
        }
        dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
}
