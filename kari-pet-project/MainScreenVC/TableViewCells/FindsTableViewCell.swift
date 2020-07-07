import UIKit

final class FindsTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    
    //MARK: Outlets
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(FindsCollectionViewCell.self)
        }
    }
    
    //MARK: Properties
    
    var images: [String] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    //MARK: Methods
    
    func setup(images: [String]) {
        self.images = images
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

//MARK: - UICollectionViewDataSource

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

//MARK: - UICollectionViewDelegateFlowLayout

extension FindsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 1.25
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
}
