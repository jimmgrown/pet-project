import SDWebImage
import UIKit

protocol GoodsPresenting: class {
    var goodCards: [GoodsCard] { get }
    var blocksCount: Int { get }
    var relatedProducts: [ProductsModel] { get }
    var recommendedProducts: [ProductsModel] { get }
    var uniqueSizesId: [[String]] { get }
    func configureView(with vendorCode: String)
    func goToGoodsVC(with vendorCode: String)
    func showAlert(with error: NetworkingError)
    func updateTableViewData()
    func getGoodsCardData(goodCards: GetGoodsCard.Response, uniqueSizesId: [[String]])
    func getProductsBlocksData(productsBlocks: (recommended: [ProductsModel], related: [ProductsModel]))
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
    
    // MARK: Properties
    
    var vendorCode: String = ""
    var presenter: GoodsPresenting!
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GoodsAssembler.configure(with: self)
        presenter.configureView(with: vendorCode)
    }
    
}

// MARK: - GoodsDisplaying

extension GoodsVC: GoodsDisplaying {
    
    func updateTableViewData() {
        tableView.reloadData()
    }
    
}

// MARK: - CatalogCellDelegate

extension GoodsVC: CatalogCellDelegate {
    
    func catalogCell(_ catalogCell: CatalogCell, didReceiveTapOnProductWith vendorCode: String) {
        presenter.goToGoodsVC(with: vendorCode)
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
