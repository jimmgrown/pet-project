import UIKit

final class CategoryTableViewCell: UITableViewCell {

    //MARK: Constants
    
    static let uiNib: UINib = UINib(nibName: String(describing: CategoryTableViewCell.self), bundle: nil)
    static let reuseID: String = .init(describing: CategoryTableViewCell.self)
    
    let uiNib: UINib = UINib(nibName: String(describing: CategoryCollectionViewCell.self), bundle: nil)
    
    //MARK: Outlets
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet{
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(uiNib, forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseID)
        }
    }
    
    //MARK: Properties
    
    var data: [[String]] = [[]] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    //MARK: Methods
    
    func setup(data: [[String]]) {
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

extension CategoryTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data[0].count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCollectionViewCell.reuseID,
            for: indexPath
            ) as! CategoryCollectionViewCell
        
        cell.setup(image: data[0][indexPath.row],label: data[1][indexPath.row])
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension CategoryTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 4.5
        let height = collectionView.frame.height / 2
        return CGSize(width: width, height: height)
    }
    
}
