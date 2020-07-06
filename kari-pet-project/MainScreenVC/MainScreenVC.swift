import UIKit
import SDWebImage

// MARK: - BaseMainScreenVC

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
    
    #warning("Такие вещи нужно инкапсулировать. Ты должен довести этот код до вида .sorted(by: <). Попытайся сделать это сам, следуя ошибкам, которые тебе будет показывать хкод")
    
    override func viewDidLoad() {
        API.loadJSON { result in
            self.blocks = result.blocks.sorted(by: { $0.priority < $1.priority })
        }
    }
}

// MARK: - UITableViewDataSource

extension MainScreenVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.blocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch blocks[indexPath.row].type {
        case .some(.slider):
            let imagesStockBanner: [StockBannerModel] = blocks[indexPath.row].items as! [StockBannerModel]
            let imagesUrlStockBanner: [String] = imagesStockBanner.map { $0.image }
            let cell = tableView.dequeueReusableCell(
                withIdentifier: SliderTableViewCell.reuseID,
                for: indexPath
                ) as! SliderTableViewCell
            cell.setup(images: imagesUrlStockBanner)
            return cell
            
        case .some(.productsHot), .some(.products):
            let bgColor: UIColor = UIColor(hexString: blocks[indexPath.row].background?.value)
            let fontColor: UIColor = UIColor(hexString: blocks[indexPath.row].fontColor?.value)
            let productsBlock: [ProductsModel] = blocks[indexPath.row].items as! [ProductsModel]
            let imagesProducts: [String] = productsBlock.map { $0.preview }
            let priceProducts: [Price] = productsBlock.map { $0.price }
            let nameProductsBanner: String = blocks[indexPath.row].name
            let titleProductBanner: [String] = productsBlock.map { $0.title }
            let brandsProduct: [String] = productsBlock.map { $0.brand.image }
            let ratingCount: [Int] = productsBlock.map { $0.rate?.numberOfVotes ?? 0 }
            let rating: [Double] = productsBlock.map { $0.rate?.votes ?? 0 }
            let colors: [[Colors]?] = productsBlock.map { $0.colors}
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ProductsTableViewCell.reuseID,
                for: indexPath
                ) as! ProductsTableViewCell
            cell.setup(images: imagesProducts, price: priceProducts,
                       name: nameProductsBanner, color: bgColor,
                       title: titleProductBanner, brands: brandsProduct,
                       fontColor: fontColor, ratingCount: ratingCount,
                       rating: rating, colors: colors)
            
            return cell
            
        case .some(.brands):
            let brandsBlock: [BrandModel] = blocks[indexPath.row].items as! [BrandModel]
            let imagesBrands: [String] = brandsBlock.map { $0.image }
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: BrandsTableViewCell.reuseID,
                for: indexPath
                ) as! BrandsTableViewCell
            cell.setup(images: imagesBrands)
            return cell
            
        case .some(.additionalInfos):
            let addInfoBlock: [StockBannerModel] = blocks[indexPath.row].items as! [StockBannerModel]
            let imagesAddInfo: [String] = addInfoBlock.map { $0.image }
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: AddInfoTableViewCell.reuseID,
                for: indexPath
                ) as! AddInfoTableViewCell
            cell.setup(data: imagesAddInfo)
            return cell
            
        case .some(.finds):
            let findsBlock: [StockBannerModel] = blocks[indexPath.row].items as! [StockBannerModel]
            let imagesFinds: [String] = findsBlock.map { $0.image }
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: FindsTableViewCell.reuseID,
                for: indexPath
                ) as! FindsTableViewCell
            cell.setup(images: imagesFinds)
            return cell
            
        case .some(.categories):
            var categoryBlockItems = blocks[indexPath.row].items as! [StockBannerModel]
            categoryBlockItems.sort(by: {$0.priority < $1.priority})
            let imagesCategory: [String] = categoryBlockItems.map { $0.image}
            let labelsCategory: [String] = categoryBlockItems.map { $0.name }
            let imagesLabelsCategory: [[String]] = [imagesCategory,labelsCategory]
            
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CategoryTableViewCell.reuseID,
                for: indexPath
                ) as! CategoryTableViewCell
            cell.setup(data: imagesLabelsCategory)
            return cell
           
        case .none:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: CategoryTableViewCell.reuseID,
                for: indexPath
                ) as! CategoryTableViewCell
            return cell
        }
    }
}
