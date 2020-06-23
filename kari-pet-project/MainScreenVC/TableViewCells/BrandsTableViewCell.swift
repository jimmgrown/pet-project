import UIKit

final class BrandsTableViewCell: UITableViewCell {

    static let reuseID: String = .init(describing: BrandsTableViewCell.self)
    let uiNib: UINib = UINib(nibName: String(describing: BrandsCollectionViewCell.self), bundle: nil)
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(uiNib, forCellWithReuseIdentifier: BrandsCollectionViewCell.reuseID)
        }
    }
    
    var images: [String] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
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

extension BrandsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: BrandsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: BrandsCollectionViewCell.reuseID,for: indexPath) as! BrandsCollectionViewCell
        cell.setup(image: images[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3
        let height = collectionView.frame.height / 3
        return CGSize(width: width, height: height)
    }
}
