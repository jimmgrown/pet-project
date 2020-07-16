import UIKit

// MARK: - Declaration

final class AddInfoTableViewCell: UITableViewCell, CellsRegistration {
    
    // MARK: Outlets
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(AddInfoCollectionViewCell.self)
        }
    }
    
    // MARK: Public roperties
    
    var data: [String] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
}

// MARK: - Public API

extension AddInfoTableViewCell {
    func setup(data: [String]) {
        self.data = data
    }
}

// MARK: - UICollectionViewDataSource

extension AddInfoTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: AddInfoCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setup(image: data[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension AddInfoTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 1.75
        let height = collectionView.frame.height - 50
        return CGSize(width: width, height: height)
    }
}
