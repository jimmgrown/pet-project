import UIKit
import SDWebImage

// MARK: - Base

final class MainScreenVC: UIViewController {
    
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
    
    // MARK: Private properties
    
    private let apiClient = APIClient()
    private var blocks: [Block] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: Life cycle
    
        override func viewDidLoad() {
            apiClient.send(GetMainScreenData()) { response in
                self.apiClient.handle(response: response) { res, err in
                    if let result = res {
                        self.blocks = result.filter { $0.type != nil }.sorted(by: <)
                    } else if let error = err {
                        error.present(on: self)
                    }
                }
            }
        }
}

extension MainScreenVC: CatalogCellDelegate {
    func catalogCell(_ catalogCell: CatalogCell, didReceiveTapOnProductWith vendoreCode: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let secondVC = storyboard.instantiateViewController(withIdentifier: GoodsVC.reuseID) as? GoodsVC else { return }
        secondVC.vendoreCode = vendoreCode
        show(secondVC, sender: self)
    }
}

// MARK: - Table View Data Source

extension MainScreenVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch blocks[indexPath.row].type! {
        case .slider:
            let imagesStockBanner: [StockBannerModel] = blocks[indexPath.row].getItemsModel()
            let imagesUrlStockBanner = imagesStockBanner.map { $0.image }
            let cell: SliderCell = tableView.dequeueReusableCell(for: indexPath)
            
            cell.setup(images: imagesUrlStockBanner)
            return cell
            
        case .productsHot, .products:
            let bgColor = UIColor(hexString: blocks[indexPath.row].background?.value)
            let fontColor = UIColor(hexString: blocks[indexPath.row].fontColor?.value)
            let productsBlock: [ProductsModel] = blocks[indexPath.row].getItemsModel()
            let imagesProducts = productsBlock.map { $0.preview }
            let priceProducts = productsBlock.map { $0.price }
            let nameProductsBanner = blocks[indexPath.row].name
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
            
        case .brands:
            let brandsBlock: [BrandModel] = blocks[indexPath.row].getItemsModel()
            let imagesBrands = brandsBlock.map { $0.image }
            
            let cell: BrandsCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setup(images: imagesBrands)
            return cell
            
        case .additionalInfos:
            let addInfoBlock: [StockBannerModel] = blocks[indexPath.row].getItemsModel()
            let imagesAddInfo = addInfoBlock.map { $0.image }
            
            let cell: InformationCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setup(data: imagesAddInfo)
            return cell
            
        case .finds:
            let findsBlock: [StockBannerModel] = blocks[indexPath.row].getItemsModel()
            let imagesFinds = findsBlock.map { $0.image }
            
            let cell: FindsCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setup(images: imagesFinds)
            return cell
            
        case .categories:
            var categoryBlockItems: [StockBannerModel] = blocks[indexPath.row].getItemsModel()
            categoryBlockItems.sort(by: <)
            let imagesCategory = categoryBlockItems.map { $0.image }
            let labelsCategory = categoryBlockItems.map { $0.name }
            let imagesLabelsCategory = [imagesCategory, labelsCategory]
            
            let cell: CategoriesCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setup(data: imagesLabelsCategory)
            return cell
        }
    }
    
}
