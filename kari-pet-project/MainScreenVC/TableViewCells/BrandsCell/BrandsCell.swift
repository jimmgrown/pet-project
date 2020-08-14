import UIKit

// MARK: - Declaration

final class BrandsCell: UITableViewCell, ReusableCell {
    
    // MARK: Outlets
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(BrandCell.self)
        }
    }
    
    // MARK: Private properties
    
    private var images: [String] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
}

// MARK: - Public API

extension BrandsCell {
    
    func setup(images: [String]) {
        self.images = images
    }
    
}

// MARK: - UICollectionViewDataSource

extension BrandsCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
        
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let cell: BrandCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setup(image: images[indexPath.row])
        return cell
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension BrandsCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.frame.width / 3
        let height = collectionView.frame.height / 3
        return CGSize(width: width, height: height)
    }
    
}
