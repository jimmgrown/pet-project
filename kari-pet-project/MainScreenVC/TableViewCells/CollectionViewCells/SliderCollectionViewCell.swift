import UIKit

class SliderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    static let reuseID: String = .init(describing: SliderCollectionViewCell.self)
    
    func setup(image:String){
        if let url = URL(string: image){
            imageView.sd_setImage(with: url)
        }
    }
}
