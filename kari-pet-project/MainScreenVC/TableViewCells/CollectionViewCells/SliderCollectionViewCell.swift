import UIKit

final class SliderCollectionViewCell: UICollectionViewCell {

    //MARK: Outlets
    
    @IBOutlet private weak var imageView: UIImageView!
    
    //MARK: Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    //MARK: Constants
    
    static let reuseID: String = .init(describing: SliderCollectionViewCell.self)
    
    //MARK: Methods
    
    func setup(image:String){
        if let url = URL(string: image){
            imageView.sd_setImage(with: url)
        }
    }
}
