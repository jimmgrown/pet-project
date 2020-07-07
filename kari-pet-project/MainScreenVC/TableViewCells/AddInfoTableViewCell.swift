import UIKit

final class AddInfoTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    
    //MARK: Outlets
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(AddInfoCollectionViewCell.self)
        }
    }
    
    //MARK: Properties
    
    var data: [String] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    //MARK: Methods
    
    func setup(data: [String]) {
        self.data = data
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//MARK: - UICollectionViewDataSource

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

//MARK: - UICollectionViewDelegateFlowLayout

extension AddInfoTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 1.75
        let height = collectionView.frame.height - 50
        return CGSize(width: width, height: height)
    }
}
