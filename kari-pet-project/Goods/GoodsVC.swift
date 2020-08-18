import SDWebImage
import UIKit

protocol GoodsPresenting: class {
    var vendorCode: String { get set }
    var goodCards: [GoodsCard] { get set}
    var blocksCount: Int { get }
    var relatedProducts: [ProductsModel] { get set }
    var recommendedProducts: [ProductsModel] { get set }
    var uniqueSizesId: [[String]] { get set }
    var view: GoodsDisplaying { get }
    var router: GoodsRouter! { get set }
    func configureView(with vendorCode: String)
}

// MARK: - Declaration

final class GoodsVC: UIViewController, ReusableVC {
    
    // MARK: Outlets
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.register(GoodsCardsCell.self)
            tableView.register(CatalogCell.self)
        }
    }
    
    // MARK: Private properties
    
    lazy var presenter: GoodsPresenting = GoodsPresenter(view: self)
    
    // MARK: Properties
    
    var vendorCode: String = ""
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GoodsAssembler.configure(with: self)
        presenter.configureView(with: vendorCode)
    }
    
}

// MARK: - GoodsDisplaying

extension GoodsVC: GoodsDisplaying {
    
    func updateData() {
        tableView.reloadData()
    }
    
}

// MARK: - CatalogCellDelegate

extension GoodsVC: CatalogCellDelegate {
    
    func catalogCell(_ catalogCell: CatalogCell, didReceiveTapOnProductWith vendorCode: String) {
        presenter.router.showView(vendorCode: vendorCode)
    }
    
}

// MARK: - UITableViewDataSource

extension GoodsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.blocksCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 1, 2:
            var nameProductsBanner: String = ProductsType.alternative.rawValue
            
            if indexPath.row == 2 {
                nameProductsBanner = ProductsType.related.rawValue
            }
            
            let products = [presenter.recommendedProducts, presenter.relatedProducts]
            let bgColor: UIColor = .white
            let fontColor: UIColor = .black
            let productsBlock: [ProductsModel] = products[indexPath.row - 1]
            let imagesProducts = productsBlock.map { $0.preview }
            let priceProducts = productsBlock.map { $0.price }
            let titleProductBanner = productsBlock.map { $0.title }
            let brandsProduct = productsBlock.map { $0.brand.image }
            let ratingCount = productsBlock.map { $0.rate?.numberOfVotes ?? 0 }
            let rating = productsBlock.map { $0.rate?.votes ?? 0 }
            let colors = productsBlock.map { $0.colors }
            let vendorCode = productsBlock.map { $0.articul }
            let cell: CatalogCell = tableView.dequeueReusableCell(for: indexPath)
            
            cell.setup(
                vendorCode: vendorCode,
                images: imagesProducts,
                price: priceProducts,
                name: nameProductsBanner,
                color: bgColor,
                title: titleProductBanner,
                brands: brandsProduct,
                fontColor: fontColor,
                ratingCount: ratingCount,
                rating: rating,
                colors: colors,
                delegate: self
            )
            
            return cell
            
        default:
            let cell: GoodsCardsCell = tableView.dequeueReusableCell(for: indexPath)
            let card = presenter.goodCards[indexPath.row]
            
            cell.setup(
                title: card.title,
                brandImage: card.brand.image,
                price: card.price,
                colors: card.colors,
                sizes: card.sizes
            )
            
            return cell
        }
    }
    
}
