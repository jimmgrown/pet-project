import UIKit

final class ProductsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var firstPriceLabel: UILabel!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var brandIcon: UIImageView!
    @IBOutlet weak var rateView: RatingView!
    
    static let reuseID: String = .init(describing: ProductsCollectionViewCell.self)
    
    func setup(image:String, price:Price, title: String, brand: String){
        
        if let url = URL(string: image){
            imageView.sd_setImage(with: url)
        }
        
        if let url = URL(string: brand){
            brandIcon.sd_setImage(with: url)
        }
        
        labelTitle.text = title
        
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
