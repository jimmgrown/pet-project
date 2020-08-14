import UIKit
import SDWebImage

typealias CellsProviders = CategoriesCellDelegate & SliderCellDelegate &
    InformationCellDelegate & FindsCellDelegate & BrandsCellDelegate

// MARK: - Base

final class MainScreenVC: UIViewController, VCDelegate, CellsProviders  {
    
    // MARK: Outlets
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            
            tableView.register(SliderCell.self)
            tableView.register(CategoriesCell.self)
            tableView.register(InformationCell.self)
            tableView.register(CatalogCell.self)
            tableView.register(BrandsCell.self)
            tableView.register(FindsCell.self)
        }
    }
    
    // MARK: Properties
    
        var presenter: MainVCPresenter!
        var interactor: MainInteractor!
        let configurator: MainConfiguratorProtocol = MainConfigurator()

    // MARK: Life cycle
    
        override func viewDidLoad() {
            configurator.configure(with: self)
            interactor.configureView()
        }
    
}

// MARK: - CatalogCellDelegate

extension MainScreenVC: CatalogCellDelegate {
    
    func catalogCell(_ catalogCell: CatalogCell, didReceiveTapOnProductWith vendorCode: String) {
        interactor.prepare(with: vendorCode)
    }
    
}

// MARK: - Table View Data Source

extension MainScreenVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.blocksCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return prepareData(for: indexPath, block: presenter.blocks[indexPath.row])
    }
    
}

// MARK: - Public API

extension MainScreenVC {
    
    func updateData() {
        tableView.reloadData()
    }
    
    func getResponse(with error: NetworkingError) {
        error.present(on: self)
    }
    
    func prepare() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let secondVC = storyboard.instantiateViewController(
            withIdentifier: GoodsVC.reuseID
            ) as? GoodsVC else { return }
        secondVC.vendorCode = presenter.vendorCode
        show(secondVC, sender: self)
    }
    
    func prepareData(for indexPath: IndexPath, block: Block) -> UITableViewCell {
        switch block.type! {
        case .categories:
            var categoryBlockItems: [StockBannerModel] = block.getItemsModel()
            categoryBlockItems.sort(by: <)
            let imagesCategory = categoryBlockItems.map { $0.image }
            let labelsCategory = categoryBlockItems.map { $0.name }
            let imagesLabelsCategory = [imagesCategory, labelsCategory]
            let dataProvider = AnyTableCellProvider(CategoriesCellProvider(delegate: self))
            dataProvider.dataSource = imagesLabelsCategory
            return dataProvider.cellForRow(at: indexPath, in: tableView)
            
        case .slider:
            let imagesStockBanner: [StockBannerModel] = block.getItemsModel()
            let imagesUrlStockBanner = imagesStockBanner.map { $0.image }
            let dataProvider = AnyTableCellProvider(SliderCellProvider(delegate: self))
            dataProvider.dataSource = imagesUrlStockBanner
            return dataProvider.cellForRow(at: indexPath, in: tableView)
            
        case .additionalInfos:
            let addInfoBlock: [StockBannerModel] = block.getItemsModel()
            let imagesAddInfo = addInfoBlock.map { $0.image }
            let dataProvider = AnyTableCellProvider(InformationCellProvider(delegate: self))
            dataProvider.dataSource = imagesAddInfo
            return dataProvider.cellForRow(at: indexPath, in: tableView)
            
        case .finds:
            let findsBlock: [StockBannerModel] = block.getItemsModel()
            let imagesFinds = findsBlock.map { $0.image }
            let dataProvider = AnyTableCellProvider(FindsCellProvider(delegate: self))
            dataProvider.dataSource = imagesFinds
            return dataProvider.cellForRow(at: indexPath, in: tableView)
            
        case .brands:
            let brandsBlock: [BrandModel] = block.getItemsModel()
            let imagesBrands = brandsBlock.map { $0.image }
            let dataProvider = AnyTableCellProvider(BrandsCellProvider(delegate: self))
            dataProvider.dataSource = imagesBrands
            return dataProvider.cellForRow(at: indexPath, in: tableView)
            
        case .products, .productsHot:
            let bgColor = UIColor(hexString: block.background?.value)
            let fontColor = UIColor(hexString: block.fontColor?.value)
            let productsBlock: [ProductsModel] = block.getItemsModel()
            let imagesProducts = productsBlock.map { $0.preview }
            let priceProducts = productsBlock.map { $0.price }
            let nameProductsBanner = block.name
            let titleProductBanner = productsBlock.map { $0.title }
            let brandsProduct = productsBlock.map { $0.brand.image }
            let ratingCount = productsBlock.map { $0.rate?.numberOfVotes ?? 0 }
            let rating = productsBlock.map { $0.rate?.votes ?? 0 }
            let colors = productsBlock.map { $0.colors }
            let vendorCode = productsBlock.map { $0.articul }
            let dataProvider = AnyTableCellProvider(CatalogCellProvider(delegate: self))
            dataProvider.dataSource = (
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
            return dataProvider.cellForRow(at: indexPath, in: tableView)
        }
    }
    
}
