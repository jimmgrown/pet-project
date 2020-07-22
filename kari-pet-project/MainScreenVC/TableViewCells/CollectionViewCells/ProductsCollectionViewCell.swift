import UIKit

#warning("У тебя во всем этом файле отсутствуют необходимые вертикальные отступы до и после скоупов и присутствуют лишние отступы внутри скоупов. Если ты не понимаешь, где, то спроси у меня. Не надо просто удалять ворнинги, не исправив проблемы))))")

// MARK: - Declaration

final class ProductsCollectionViewCell: UICollectionViewCell, ReusableCell {

    // MARK: Outlets
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var firstPriceLabel: UILabel!
    @IBOutlet private weak var currentPriceLabel: UILabel!
    @IBOutlet private weak var discountLabel: UILabel!
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var brandIcon: UIImageView!
    @IBOutlet private weak var rateView: RatingView!
    @IBOutlet private weak var ratingCount: UILabel!
    @IBOutlet private weak var colorsCollectionView: UICollectionView! {
        didSet {
            colorsCollectionView.register(ColorsCollectionViewCell.self)
            colorsCollectionView.dataSource = self
            colorsCollectionView.delegate = self
        }
    }
    
    // MARK: Private properties
    
    private var rating: Int = 0
    private var image: String = ""
    private var colors: [Colors] = []

}

// MARK: - Public API

extension ProductsCollectionViewCell {

    func setup(
        image: String,
        price: Price,
        title: String,
        brand: String,
        votes: Int,
        rating: Double,
        colors: [Colors]?
        ) {
        
        if let url = URL(string: image){
            imageView.sd_setImage(with: url)
        }
        if let url = URL(string: brand){
            brandIcon.sd_setImage(with: url)
        }
        self.image = image
        if let colors = colors {
            self.colors = colors
        }
        
        labelTitle.text = title
        ratingCount.text = String(votes)
        self.rating = Int(rating)
        rateView.firstInit(rate: Int(rating),stkView: rateView)
        guard let firstPrice = price.first else { return }
        if let discount = price.discount {
            
            currentPriceLabel.text = "\(String(price.current)) ₽"
            discountLabel.text = "-\(String(describing: discount))%"
            
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "\(firstPrice) ₽")
            attributeString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            firstPriceLabel.attributedText = attributeString
            
        } else {
            firstPriceLabel.isHidden = true
            discountLabel.isHidden = true
            currentPriceLabel.text = "\(price.current) ₽"
        }
    }
    
}

// MARK: - UICollectionViewDataSource

extension ProductsCollectionViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: ColorsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setup(colors: colors[indexPath.row])
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProductsCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let side = collectionView.frame.size.height
        return CGSize(width: side, height: side)
    }
    
}
