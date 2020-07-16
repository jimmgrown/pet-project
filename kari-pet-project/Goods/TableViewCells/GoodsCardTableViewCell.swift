import UIKit

// MARK: - Declaration

final class GoodsCardTableViewCell: UITableViewCell, CellsRegistration {

    // MARK: Outlets
    
    @IBOutlet private weak var discountLabel: UILabel!
    @IBOutlet private weak var currentPriceLabel: UILabel!
    @IBOutlet private weak var discountPriceLabel: UILabel!
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var brandImage: UIImageView!
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            
            collectionView.register(GoodsCardCollectionViewCell.self)
        }
    }
    
    @IBOutlet private weak var otherColorsCollectionView: UICollectionView! {
        didSet {
            otherColorsCollectionView.dataSource = self
            otherColorsCollectionView.delegate = self
            
            otherColorsCollectionView.register(OtherColorsCollectionViewCell.self)
        }
    }
    
    @IBOutlet private weak var sizesCollectionView: UICollectionView!  {
        didSet {
            sizesCollectionView.dataSource = self
            sizesCollectionView.delegate = self
            
            sizesCollectionView.register(SizesCollectionViewCell.self)
        }
    }

    // MARK: Public properties
    
    private var colors: [Colors] = []
    private var sizes: [Size] = []
    
}

// MARK: - Public API

extension GoodsCardTableViewCell {
    func setup(title: String, brandImage: String, price: Price, colors: [Colors], sizes: [Size]){
        self.sizes = sizes
        self.colors = colors
        self.title.text = title
        if let url = URL(string: brandImage){
            self.brandImage.sd_setImage(with: url)
        }
        
        if price.discount != nil {
            
            currentPriceLabel.text = "\(String(price.current)) ₽"
            discountLabel.text = "-\(String(describing: price.discount!))%"
            
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(String(price.first!)) ₽")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            discountPriceLabel.attributedText = attributeString
            
        } else {
            
            discountPriceLabel.isHidden = true
            discountLabel.isHidden = true
            currentPriceLabel.text = "\(String(price.current)) ₽"
            
        }
    }
}

// MARK: - UICollectionViewDataSource

extension GoodsCardTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pageControl.numberOfPages = colors.count
        switch collectionView {
        
        case sizesCollectionView:
            return sizes.count
            
        default:
            return colors.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        
        case sizesCollectionView:
            let cell: SizesCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            
            cell.setup(size: sizes[indexPath.row])
            return cell
            
        case otherColorsCollectionView:
            let cell: OtherColorsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            
            cell.setup(image: colors[indexPath.row].preview)
            return cell
            
        default:
            let cell: GoodsCardCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            
            cell.setup(image: colors[indexPath.row].preview)
            return cell
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.row
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GoodsCardTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let heightSize = collectionView.frame.size.height
        let widthSize = collectionView.frame.size.width
        
        switch collectionView{
            
        case otherColorsCollectionView, sizesCollectionView :
            return CGSize(width: widthSize / 5, height: heightSize)
            
        default:
            return CGSize(width: widthSize, height: heightSize)
        }
    }
    
}

