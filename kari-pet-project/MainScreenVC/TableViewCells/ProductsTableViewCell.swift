import UIKit

protocol ProductsTableViewCellDelegate {
    #warning("Что это за имя?))) Пожалуйста, прочитай гайдлайны эпла, которые я кидал тебе, либо просто посмотри, как их делегаты оформлены")
    func productsCell()
}

// MARK: - Declaration

final class ProductsTableViewCell: UITableViewCell, ReusableCell {

    // MARK: Outlets

    @IBOutlet private weak var productsBackgroundView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            
            collectionView.register(ProductsCollectionViewCell.self)
        }
    }

    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: private roperties

    #warning("Сам здесь найди недопустимую ошибку. Запиши ее себе куда-нибудь и запомни, потому что ее вообще никогда нельзя допускать")
    private var delegate: ProductsTableViewCellDelegate?
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

extension ProductsTableViewCell {
    func setup(
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
        delegate: ProductsTableViewCellDelegate
        ) {
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

extension ProductsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

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

extension ProductsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 1.85
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.productsCell()
    }
}
