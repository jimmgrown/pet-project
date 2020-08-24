import SDWebImage
import UIKit

// MARK: - GoodsInteracting

protocol GoodsInteracting: GoodsDataStore {
    var uniqueSizesId: [[String]] { get }
    func configureView(_ request: Goods.GetBlocksDataAction.Request.Card)
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
    
    var router: Goods.Routing!
    var interactor: GoodsInteracting!
    
    // MARK: Properties
    
    var vendorCode: String = ""
    
    // MARK: Private properties
    
    private(set) var viewModel = Goods.GetBlocksDataAction.ViewModel(
        card: [],
        recommended: [],
        related: [],
        blocksCount: 0
    )
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        GoodsConfigurator.configure(with: self)
        interactor.configureView(Goods.GetBlocksDataAction.Request.Card(url: API.Main.goodsCardURL(for: vendorCode)))
    }
    
}

// MARK: - Public API

extension GoodsVC: GoodsDisplaying {
    
    func updateUI(viewModel: Goods.GetBlocksDataAction.ViewModel) {
        self.viewModel = viewModel
    }
    
    func updateTableViewData() {
        tableView.reloadData()
    }
    
}

// MARK: - CatalogCellDelegate

extension GoodsVC: CatalogCellDelegate {
    
    func catalogCell(_ catalogCell: CatalogCell, didReceiveTapOnProductWith vendorCode: String) {
        interactor.setDataStore(with: vendorCode)
        router.goToGoodsVC()
    }
    
}

// MARK: - UITableViewDataSource

extension GoodsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.blocksCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 1, 2:
            var nameProductsBanner: String = ProductsType.alternative.rawValue
            
            if indexPath.row == 2 {
                nameProductsBanner = ProductsType.related.rawValue
            }
            let cell: CatalogCell = tableView.dequeueReusableCell(for: indexPath)
            let products = [viewModel.recommended, viewModel.related]
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
            let card = viewModel.card[indexPath.row]
            
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
