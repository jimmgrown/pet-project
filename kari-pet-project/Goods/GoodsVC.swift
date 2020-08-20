import SDWebImage
import UIKit

protocol GoodsPresenting: class {
    func getBlocksData(blocks: [GoodsCard])
    func getRecommendedData(data: [ProductsModel])
    func getRelatedData(data: [ProductsModel])
    func showAlert(with error: NetworkingError)
    func sendBlocksData()
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
    
    var router: GoodsRouter!
    var interactor: GoodsInteracting!
    
    // MARK: Properties
    
    var vendorCode: String = ""
    
    // MARK: Private properties
    
    private(set) var blocksCount: Int = 0
    private(set) var goodsCard: [GoodsCard] = []
    private(set) var recommendedProducts: [ProductsModel] = []
    private(set) var relatedProducts: [ProductsModel] = []
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        GoodsAssembler.configure(with: self)
        interactor.configureView(with: vendorCode)
    }
    
}

// MARK: - Public API

extension GoodsVC: GoodsDisplaying {
    
    func getBlocksCount(blocksCount: Int) {
        self.blocksCount = blocksCount
    }
    
    func getBlocksData(cards: [GoodsCard], recommended: [ProductsModel], related: [ProductsModel]) {
        self.goodsCard = cards
        self.recommendedProducts = recommended
        self.relatedProducts = related
    }
    
    
    func updateTableViewData() {
        tableView.reloadData()
    }
    
}

// MARK: - CatalogCellDelegate

extension GoodsVC: CatalogCellDelegate {
    
    func catalogCell(_ catalogCell: CatalogCell, didReceiveTapOnProductWith vendorCode: String) {
        router.goToGoodsVC(vendorCode: vendorCode)
    }
    
}

// MARK: - UITableViewDataSource

extension GoodsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blocksCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 1, 2:
            var nameProductsBanner: String = ProductsType.alternative.rawValue
            
            if indexPath.row == 2 {
                nameProductsBanner = ProductsType.related.rawValue
            }
            let cell: CatalogCell = tableView.dequeueReusableCell(for: indexPath)
            let products = [recommendedProducts, relatedProducts]
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
            let card = goodsCard[indexPath.row]
            
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
