import UIKit

final class ProductsTableViewCell: UITableViewCell, ReusableView, NibLoadableView {
    
    //MARK: Outlets
    
    @IBOutlet private weak var bgView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(ProductsCollectionViewCell.self)
        }
    }
    
    @IBOutlet weak var labelName: UILabel!
    
    //MARK: Properties
    
    var vc = MainScreenVC()
    var ratingCount: [Int] = []
    var title: [String] = []
    var price: [Price] = []
    var brands: [String] = []
    var rating: [Double] = []
    var colors: [[Colors]?] = [[]]
    var images: [String] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    //MARK: Methods
    
    func setup(images: [String], price: [Price], name: String, color: UIColor,
        title: [String], brands: [String], fontColor: UIColor, ratingCount: [Int],
        rating: [Double], colors: [[Colors]?], vc: MainScreenVC) {
        self.colors = colors
        self.images = images
        self.price = price
        self.title = title
        self.brands = brands
        self.ratingCount = ratingCount
        self.rating = rating
        self.vc = vc
        
        labelName.text = name
        labelName.textColor = fontColor
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

//MARK: - UICollectionViewDataSource

extension ProductsTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        
        cell.setup(image: images[indexPath.row], price: price[indexPath.row], title: title[indexPath.row], brand: brands[indexPath.row], votes: ratingCount[indexPath.row], rating: rating[indexPath.row], colors: colors[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            vc.switchToViewController(identifier: "goods")
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ProductsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 1.85
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
}
