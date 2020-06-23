import UIKit

final class ProductsTableViewCell: UITableViewCell {

    static let reuseID: String = .init(describing: ProductsTableViewCell.self)
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(uiNib, forCellWithReuseIdentifier: ProductsCollectionViewCell.reuseID)
        }
    }
    
    @IBOutlet weak var labelName: UILabel!
    
    let uiNib: UINib = UINib(nibName: String(describing: ProductsCollectionViewCell.self), bundle: nil)
    
    var title: [String] = []
    var price: [Price] = []
    var brands: [String] = []
    var images: [String] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    func setup(images: [String], price: [Price], name: String, color: UIColor, title: [String], brands: [String]) {
        self.images = images
        self.price = price
        self.title = title
        self.brands = brands
        labelName.text = name
        collectionView.backgroundColor = color
        bgView.backgroundColor = color
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension ProductsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: ProductsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCollectionViewCell.reuseID,for: indexPath) as! ProductsCollectionViewCell
        cell.setup(image: images[indexPath.row], price: price[indexPath.row], title: title[indexPath.row], brand: brands[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 1.85
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
}
