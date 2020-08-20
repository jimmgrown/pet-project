import SDWebImage
import UIKit

protocol GoodsPresenting: class {
    func getBlocksData(blocks: GoodsCardScreenData)
    func showAlert(with error: NetworkingError)
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
    private(set) var blocksCount: Int = 0
    private(set) var blocks: GoodsCardScreenData?
    
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
    
    func getBlocksData(blocks: GoodsCardScreenData) {
        self.blocks = blocks
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
            guard let blocks = self.blocks else { return cell }
            let products = [blocks.recommendedProducts, blocks.relatedProducts]
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
            guard let block = blocks?.goodsCard else { return cell }
            let card = block[indexPath.row]
            
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
