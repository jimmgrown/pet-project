import SDWebImage
import UIKit

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
    
    var vendoreCode: String = ""
    
    // MARK: Private roperties
    
    private var relatedProducts: [ProductsModel] = [] {
        
        didSet {
            tableView.reloadData()
        }
        
    }
    private var recommendedProducts: [ProductsModel] = [] {
        
        didSet {
            tableView.reloadData()
        }
        
    }
    private var uniqueSizesId: [[String]] = [[]]
    private let apiClient = APIClient()
    private var goodCards: [GoodsCard] = [] {
        
        didSet {
            tableView.reloadData()
        }
        
    }
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiClient.send(GetGoodsCard(url: API.Main.goodsCardURL(for: vendoreCode))) { response in
            self.apiClient.handle(response: response) { result, error in
                if let goodCards = result {
                    self.goodCards = goodCards
                    self.uniqueSizesId = goodCards.map { $0.uniqueSizesIDs.map { String($0.value) }}
                }
            }
            
            let productsGroup = DispatchGroup()
            
            DispatchQueue.global().async(group: productsGroup) {
                self.apiClient.send(GetRecomendedProducts(locationId: API.baseLocationId, size: 5, page: 1, uniqueSizesIds: self.uniqueSizesId[0])) { response in
                    self.apiClient.handle(response: response) { result, error in
                        if let products = result {
                            self.recommendedProducts = products.data.products
                        }
                    }
                    //print(try? JSONSerialization.jsonObject(with: data!, options: []))
                }
            }
            
            DispatchQueue.global(qos: .userInitiated).async(group: productsGroup) {
                self.apiClient.send(GetRelatedProducts(locationId: API.baseLocationId, size: 5, page: 1, uniqueSizesIds: self.uniqueSizesId[0])) { response in
                    self.apiClient.handle(response: response) { result, error in
                        if let products = result {
                            self.relatedProducts = products.data.products
                        }
                    }
                    //print(try? JSONSerialization.jsonObject(with: data!, options: []))
                }
            }
            
            productsGroup.notify(queue: DispatchQueue.main) {
                self.tableView.reloadData()
            }
        }
        
    }
    
}

extension GoodsVC: CatalogCellDelegate {
    
    func catalogCell(_ catalogCell: CatalogCell, didReceiveTapOnProductWith vendoreCode: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let secondVC = storyboard.instantiateViewController(withIdentifier: GoodsVC.reuseID) as? GoodsVC else { return }
        secondVC.vendoreCode = vendoreCode
        show(secondVC, sender: self)
    }
    
}

// MARK: - UITableViewDataSource

extension GoodsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var blocksCounter: Int = 0
        blocksCounter = relatedProducts.count > 0 ? blocksCounter + 1 : blocksCounter
        blocksCounter = recommendedProducts.count > 0 ? blocksCounter + 1 : blocksCounter
        blocksCounter = goodCards.count > 0 ? blocksCounter + 1 : blocksCounter
        return blocksCounter
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 1, 2:
            var nameProductsBanner: String = ProductsType.alternative
            if indexPath.row == 2 {
                nameProductsBanner = ProductsType.related
            }
            let products: [[ProductsModel]] = [recommendedProducts, relatedProducts]
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
            let card = goodCards[indexPath.row]
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
