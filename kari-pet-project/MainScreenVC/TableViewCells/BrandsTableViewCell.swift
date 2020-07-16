import UIKit

// MARK: - Declaration

final class BrandsTableViewCell: UITableViewCell, CellsRegistration {
    
    // MARK: Outlets
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(BrandsCollectionViewCell.self)
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

extension BrandsTableViewCell {
    func setup(images: [String]) {
        self.images = images
    }
}

// MARK: - UICollectionViewDataSource

extension BrandsTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: BrandsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setup(image: images[indexPath.row])
        return cell
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension BrandsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3
        let height = collectionView.frame.height / 3
        return CGSize(width: width, height: height)
    }
}
