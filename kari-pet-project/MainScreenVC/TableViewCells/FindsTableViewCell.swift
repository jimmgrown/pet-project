import UIKit

// MARK: - Declaration

final class FindsTableViewCell: UITableViewCell, ReusableCell {
    
    // MARK: Outlets
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(FindsCollectionViewCell.self)
        }
    }
    
    // MARK: Public roperties
    
    var images: [String] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
}

// MARK: - Public API

extension FindsTableViewCell {
    func setup(images: [String]) {
        self.images = images
    }
}

// MARK: - UICollectionViewDataSource

extension FindsTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: FindsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setup(image: images[indexPath.row])
        return cell
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FindsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 1.25
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
}
