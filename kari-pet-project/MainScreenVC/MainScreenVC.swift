import UIKit
import SDWebImage

// MARK: - Base

final class MainScreenVC: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            
            tableView.register(SliderTableViewCell.uiNib, forCellReuseIdentifier: SliderTableViewCell.reuseID)
            tableView.register(CategoryTableViewCell.uiNib, forCellReuseIdentifier: CategoryTableViewCell.reuseID)
            tableView.register(AddInfoTableViewCell.uiNib, forCellReuseIdentifier: AddInfoTableViewCell.reuseID)
            tableView.register(ProductsTableViewCell.uiNib, forCellReuseIdentifier: ProductsTableViewCell.reuseID)
            tableView.register(BrandsTableViewCell.uiNib, forCellReuseIdentifier: BrandsTableViewCell.reuseID)
            tableView.register(FindsTableViewCell.uiNib, forCellReuseIdentifier: FindsTableViewCell.reuseID)
        }
    }
    
    // MARK: Properties
    
    private var blocks: [Block] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        API.loadJSON { result in
            self.blocks = result.blocks.filter { $0.type != nil }.sorted(by: <)
        }
    }
}

// MARK: - Table View Data Source

extension MainScreenVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.blocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch blocks[indexPath.row].type! {
        case .slider:
            let imagesStockBanner: [StockBannerModel] = blocks[indexPath.row].getItemsModel()
            let imagesUrlStockBanner = imagesStockBanner.map { $0.image }
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: SliderTableViewCell.reuseID,
                for: indexPath
            ) as! SliderTableViewCell
            
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
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProductsTableViewCell.reuseID,
                for: indexPath
            ) as! ProductsTableViewCell
            
            cell.setup(
                images: imagesProducts,
                price: priceProducts,
                name: nameProductsBanner,
                color: bgColor,
                title: titleProductBanner,
                brands: brandsProduct,
                fontColor: fontColor,
                ratingCount: ratingCount,
                rating: rating,
                colors: colors
            )
            
            return cell
            
        case .brands:
            let brandsBlock: [BrandModel] = blocks[indexPath.row].getItemsModel()
            let imagesBrands = brandsBlock.map { $0.image }
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: BrandsTableViewCell.reuseID,
                for: indexPath
            ) as! BrandsTableViewCell
            
            cell.setup(images: imagesBrands)
            return cell
            
        case .additionalInfos:
            let addInfoBlock: [StockBannerModel] = blocks[indexPath.row].getItemsModel()
            let imagesAddInfo = addInfoBlock.map { $0.image }
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: AddInfoTableViewCell.reuseID,
                for: indexPath
            ) as! AddInfoTableViewCell
            
            cell.setup(data: imagesAddInfo)
            return cell
            
        case .finds:
            let findsBlock: [StockBannerModel] = blocks[indexPath.row].getItemsModel()
            let imagesFinds = findsBlock.map { $0.image }
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: FindsTableViewCell.reuseID,
                for: indexPath
            ) as! FindsTableViewCell
            
            cell.setup(images: imagesFinds)
            return cell
            
        case .categories:
            var categoryBlockItems: [StockBannerModel] = blocks[indexPath.row].getItemsModel()
            categoryBlockItems.sort(by: {$0.priority < $1.priority})
            let imagesCategory = categoryBlockItems.map { $0.image}
            let labelsCategory = categoryBlockItems.map { $0.name }
            let imagesLabelsCategory = [imagesCategory,labelsCategory]
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CategoryTableViewCell.reuseID,
                for: indexPath
            ) as! CategoryTableViewCell
            
            cell.setup(data: imagesLabelsCategory)
            return cell
        }
    }
}
