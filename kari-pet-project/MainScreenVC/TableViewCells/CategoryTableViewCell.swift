import UIKit

final class CategoryTableViewCell: UITableViewCell {

    static let reuseID: String = .init(describing: CategoryTableViewCell.self)
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet{
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(uiNib, forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseID)
        }
    }
    
     let uiNib: UINib = UINib(nibName: String(describing: CategoryCollectionViewCell.self), bundle: nil)
    
    var data: [[String]] = [[]] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
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

extension CategoryTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data[0].count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: CategoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.reuseID,for: indexPath) as! CategoryCollectionViewCell
        cell.setup(image: data[0][indexPath.row],label: data[1][indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 4.5
        let height = collectionView.frame.height / 2
        return CGSize(width: width, height: height)
    }
}
