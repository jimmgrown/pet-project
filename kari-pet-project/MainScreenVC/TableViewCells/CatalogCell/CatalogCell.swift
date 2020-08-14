import UIKit

// MARK: - CatalogCellDelegate

protocol CatalogCellDelegate: class {
    func catalogCell(_ catalogCell: CatalogCell, didReceiveTapOnProductWith vendoreCode: String)
}

// MARK: - Declaration

final class CatalogCell: UITableViewCell, ReusableCell {

    // MARK: Outlets

    @IBOutlet private weak var productsBackgroundView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(ThumbnailCell.self)
        }
    }

    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: private roperties

    private weak var delegate: CatalogCellDelegate?
    private var vendorCode: [String] = []
    private var ratingCount: [Int] = []
    private var title: [String] = []
    private var price: [Price] = []
    private var brands: [String] = []
    private var rating: [Double] = []
    private var colors: [[Colors]?] = [[]]
    private var images: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
}

// MARK: - Public API

extension CatalogCell {
    func setup(
        vendorCode: [String],
        images: [String],
        price: [Price],
        name: String,
        color: UIColor,
        title: [String],
        brands: [String],
        fontColor: UIColor,
        ratingCount: [Int],
        rating: [Double],
        colors: [[Colors]?],
        delegate: CatalogCellDelegate
        ) {
        self.vendorCode = vendorCode
        self.colors = colors
        self.images = images
        self.price = price
        self.title = title
        self.brands = brands
        self.ratingCount = ratingCount
        self.rating = rating
        self.delegate = delegate
        
        titleLabel.text = name
        titleLabel.textColor = fontColor
        collectionView.backgroundColor = color
        productsBackgroundView.backgroundColor = color
    }
}

// MARK: - UICollectionViewDataSource

extension CatalogCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: ThumbnailCell = collectionView.dequeueReusableCell(for: indexPath)

        cell.setup(
            image: images[indexPath.row],
            price: price[indexPath.row],
            title: title[indexPath.row],
            brand: brands[indexPath.row],
            votes: ratingCount[indexPath.row],
            rating: rating[indexPath.row],
            colors: colors[indexPath.row]
        )
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CatalogCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.frame.width / 1.85
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.catalogCell(self, didReceiveTapOnProductWith: vendorCode[indexPath.row])
    }
    
}
