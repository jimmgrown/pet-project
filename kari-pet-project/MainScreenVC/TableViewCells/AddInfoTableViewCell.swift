import UIKit

final class AddInfoTableViewCell: UITableViewCell {

    static let reuseID: String = .init(describing: AddInfoTableViewCell.self)
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(uiNib, forCellWithReuseIdentifier: AddInfoCollectionViewCell.reuseID)
        }
    }
    
    let uiNib: UINib = UINib(nibName: String(describing: AddInfoCollectionViewCell.self), bundle: nil)
    
    var data: [String] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
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

extension AddInfoTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: AddInfoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: AddInfoCollectionViewCell.reuseID,for: indexPath) as! AddInfoCollectionViewCell
        cell.setup(image: data[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 1.75
        let height = collectionView.frame.height - 50
        return CGSize(width: width, height: height)
    }
}