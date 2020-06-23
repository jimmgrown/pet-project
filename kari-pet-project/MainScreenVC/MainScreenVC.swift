import UIKit
import SDWebImage

class MainScreenVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            
            //register UINibs
            tableView.register(uiNibStockSlider, forCellReuseIdentifier: SliderTableViewCell.reuseID)
            tableView.register(uiNibCategories, forCellReuseIdentifier: CategoryTableViewCell.reuseID)
            tableView.register(uiNibAddInfo, forCellReuseIdentifier: AddInfoTableViewCell.reuseID)
            tableView.register(uiNibProducts, forCellReuseIdentifier: ProductsTableViewCell.reuseID)
            tableView.register(uiNibBrands, forCellReuseIdentifier: BrandsTableViewCell.reuseID)
            tableView.register(uiNibFinds, forCellReuseIdentifier: FindsTableViewCell.reuseID)
        }
    }
    
    let uiNibStockSlider: UINib = UINib(nibName: String(describing: SliderTableViewCell.self), bundle: nil)
    let uiNibCategories: UINib = UINib(nibName: String(describing: CategoryTableViewCell.self), bundle: nil)
    let uiNibAddInfo: UINib = UINib(nibName: String(describing: AddInfoTableViewCell.self), bundle: nil)
    let uiNibProducts: UINib = UINib(nibName: String(describing: ProductsTableViewCell.self), bundle: nil)
    let uiNibBrands: UINib = UINib(nibName: String(describing: BrandsTableViewCell.self), bundle: nil)
    let uiNibFinds: UINib = UINib(nibName: String(describing: FindsTableViewCell.self), bundle: nil)
    
    var blocks: [Block] = []
    
    let colorsProducts: [UIColor] = [
        UIColor(red: 255/255, green: 61/255, blue: 0/255, alpha: 1),
        UIColor(red: 233/255, green: 27/255, blue: 76/255, alpha: 1),
        UIColor(red: 140/255, green: 33/255, blue: 178/255, alpha: 1),
        UIColor(red: 178/255, green: 56/255, blue: 134/255, alpha: 1)
//        UIColor(hex: "#ff3c00"),
//        UIColor(hex: "#e91b4b"),
//        UIColor(hex: "#8b21b2")
    ]
    
    //Local variables stockBanner
    var imagesStockBanner: [StockBannerModel] = []
    var imagesUrlStockBanner : [String] = []
    
    //Local variables categoryBanner
    var categoryBlockItems: [StockBannerModel] = []
    var imagesCategory: [String] = []
    var labelsCategory: [String] = []
    var imagesLabelsCategory: [[String]] = [[]]
    
    //Local variables addInfoBanner
    var addInfoBlock: [StockBannerModel] = []
    var imagesAddInfo: [String] = []
    
    //Local variables productsBanner
    var productsBlock: [ProductsModel] = []
    var imagesProducts: [String] = []
    var priceProducts: [Price] = []
    var nameProductsBanner: String = ""
    var titleProductBanner: [String] = []
    var brandsProduct: [String] = []
    
    //Local variables brandsBanner
    var brandsBlock: [BrandModel] = []
    var imagesBrands: [String] = []
    
    //Local variables findsBanner
    var findsBlock: [StockBannerModel] = []
    var imagesFinds: [String] = []
    
    var result = Response(blocks: [Block]()) {
        didSet {
            
            self.blocks = result.blocks
            self.blocks = self.blocks.sorted { $0.priority < $1.priority }
            
            //Local variables stockBanner
            self.imagesStockBanner = blocks[0].items as! [StockBannerModel]
            self.imagesUrlStockBanner  = imagesStockBanner.map { $0.image }
            
            //Local variables categoryBanner
            self.categoryBlockItems = blocks[1].items as! [StockBannerModel]
            self.categoryBlockItems.sort(by: {$0.priority < $1.priority})
            self.imagesCategory = categoryBlockItems.map { $0.image}
            self.labelsCategory = categoryBlockItems.map { $0.name }
            self.imagesLabelsCategory = [imagesCategory,labelsCategory]
            
            //Local variables addInfoBanner
            self.addInfoBlock = blocks[2].items as! [StockBannerModel]
            self.imagesAddInfo = addInfoBlock.map { $0.image }
            
            //Local variables brandsBanner
            self.brandsBlock = blocks[7].items as! [BrandModel]
            self.imagesBrands = brandsBlock.map { $0.image }
            
            //Local variables findsBanner
            self.findsBlock = blocks[6].items as! [StockBannerModel]
            self.imagesFinds = findsBlock.map { $0.image }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        API.loadJSON { result in
            self.result=result
        }
    }
}

extension MainScreenVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.blocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            
        case 0:
            let cell: SliderTableViewCell = tableView.dequeueReusableCell(withIdentifier: SliderTableViewCell.reuseID, for: indexPath) as! SliderTableViewCell
            cell.setup(images: self.imagesUrlStockBanner )
            return cell
            
        case 2:
            let cell: AddInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: AddInfoTableViewCell.reuseID, for: indexPath) as! AddInfoTableViewCell
            cell.setup(data: self.imagesAddInfo )
            return cell
            
        case 3, 5, 7, 8:
            var index = indexPath.row
            var color = 0
            
            //switch productsBlocks знаю - костыль, хз как сделать по другому сделать
            switch indexPath.row {
            case 5:
                index = 4
                color = 1
            case 7:
                index = 5
                color = 2
            case 8:
                index = 8
                color = 3
            default:
                index = 3
                color = 0
            }
            
            self.productsBlock = blocks[index].items as! [ProductsModel]
            self.imagesProducts = productsBlock.map { $0.preview }
            self.priceProducts = productsBlock.map { $0.price }
            self.nameProductsBanner = blocks[index].name
            self.titleProductBanner = productsBlock.map { $0.title }
            self.brandsProduct = productsBlock.map { $0.brand.image }
            
            let cell: ProductsTableViewCell = tableView.dequeueReusableCell(withIdentifier: ProductsTableViewCell.reuseID, for: indexPath) as! ProductsTableViewCell
            cell.setup(images: self.imagesProducts, price: self.priceProducts, name: self.nameProductsBanner, color: self.colorsProducts[color], title: self.titleProductBanner, brands: self.brandsProduct)
            
            return cell
            
        case 4:
            let cell: BrandsTableViewCell = tableView.dequeueReusableCell(withIdentifier: BrandsTableViewCell.reuseID, for: indexPath) as! BrandsTableViewCell
            cell.setup(images: self.imagesBrands )
            return cell
            
        case 6:
            let cell: FindsTableViewCell = tableView.dequeueReusableCell(withIdentifier: FindsTableViewCell.reuseID, for: indexPath) as! FindsTableViewCell
            cell.setup(images: self.imagesFinds )
            return cell
            
        default:
            let cell: CategoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.reuseID, for: indexPath) as! CategoryTableViewCell
            cell.setup(data: self.imagesLabelsCategory)
            return cell
            
        }
    }
}
