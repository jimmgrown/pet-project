import UIKit

// MARK: - Declaration

final class CategoriesCell: UITableViewCell, ReusableCell {

    // MARK: Outlets
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet{
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(CategoryCell.self)
        }
    }
    
    // MARK: Private roperties
    
    private var data: [[String]] = [[]] {
        didSet {
            self.collectionView.reloadData()
        }
    }

}

// MARK: - Public API

extension CategoriesCell {
    
    func setup(data: [[String]]) {
        self.data = data
    }
    
}

// MARK: - UICollectionViewDataSource

extension CategoriesCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data[0].count
        
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: CategoryCell = collectionView.dequeueReusableCell(for: indexPath)
        
        cell.setup(image: data[0][indexPath.row],label: data[1][indexPath.row])
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CategoriesCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 4.5
        let height = collectionView.frame.height / 2
        return CGSize(width: width, height: height)
    }
    
}
