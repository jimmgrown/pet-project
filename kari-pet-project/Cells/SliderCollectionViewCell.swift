import UIKit

class SliderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static let identifier = "sliderCell"
    
    func setup(response:ModelBlockIdTwo){
        if let url = URL(string: response.image){
            print("Yes i'm here")
            imageView.sd_setImage(with: url)
        }
    }
}
