import UIKit

class CollectionViewCellHot: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var firstPrice: UILabel!
    @IBOutlet weak var currentPrice: UILabel!
    @IBOutlet weak var videoIcon: UIImageView!
    
    static let identifier = "hotCell"
    
    func setup(response:ModelBlockIdFour){
        if let url = URL(string: response.preview){
            //print(url)
            imageView.sd_setImage(with: url)
        }
        if response.withVideo == false {
            videoIcon.isHidden = true
        }
        if response.price.discount != nil {
            //firstPrice.text = "\(String(response.price.first!))₽"
            currentPrice.text = "\(String(response.price.current))₽"
            discount.text = "-\(String(describing: response.price.discount!))%"
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(String(response.price.first!))₽")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            firstPrice.attributedText = attributeString
        }
        else {
            firstPrice.isHidden = true
            discount.isHidden = true
            currentPrice.text = "\(String(response.price.current))₽"
        }
        
    }
}

