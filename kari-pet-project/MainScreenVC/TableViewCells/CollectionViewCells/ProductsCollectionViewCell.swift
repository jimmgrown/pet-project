import UIKit

final class ProductsCollectionViewCell: UICollectionViewCell {

    //MARK: Outlets
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var firstPriceLabel: UILabel!
    @IBOutlet private weak var currentPriceLabel: UILabel!
    @IBOutlet private weak var discountLabel: UILabel!
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var brandIcon: UIImageView!
    @IBOutlet private weak var rateView: RatingView!
    @IBOutlet private weak var ratingCount: UILabel!
    @IBOutlet private weak var colorsCollectionView: UICollectionView!
    
    //MARK: Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorsCollectionView.register(ColorsCollectionViewCell.uiNib, forCellWithReuseIdentifier: ColorsCollectionViewCell.reuseID)
        colorsCollectionView.dataSource = self
        colorsCollectionView.delegate = self
    }
    
    //MARK: Constants
    
    static let reuseID: String = .init(describing: ProductsCollectionViewCell.self)
    
    var rating: Int = 0
    var image: String = ""
    var colors: [Colors]? = []
    
    //MARK: Methods
    
    func setup(image:String, price:Price, title: String, brand: String, votes: Int, rating: Double, colors: [Colors]?){
        
        if let url = URL(string: image){
            imageView.sd_setImage(with: url)
        }
        
        if let url = URL(string: brand){
            brandIcon.sd_setImage(with: url)
        }
        self.image = image
        self.colors = colors
        labelTitle.text = title
        ratingCount.text = String(votes)
        self.rating = Int(rating)
        rateView.firstInit(rate: Int(rating),stkView: rateView)
        if price.discount != nil {
            
            currentPriceLabel.text = "\(String(price.current)) ₽"
            discountLabel.text = "-\(String(describing: price.discount!))%"
            
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(String(price.first!)) ₽")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            firstPriceLabel.attributedText = attributeString
            
        }
        else {
            firstPriceLabel.isHidden = true
            discountLabel.isHidden = true
            currentPriceLabel.text = "\(String(price.current)) ₽"
        }
    }
}

//MARK: - UICollectionViewDataSource

extension ProductsCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ColorsCollectionViewCell.reuseID,
            for: indexPath
            ) as! ColorsCollectionViewCell
        cell.setup(colors: colors?[indexPath.row])
        return cell
    }
    
    //MARK: Change preview by colors
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let url = URL(string: colors?[indexPath.row].preview ?? self.image){
//            imageView.sd_setImage(with: url)
//            colorsCollectionView.reloadData()
//        }
//    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ProductsCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let side = collectionView.frame.size.height
        return CGSize(width: side, height: side)
    }
}
