import UIKit
import SDWebImage

#warning("В этой марке должно стоять слово Base + это внешняя марка, ее нужно оформлять через дефис: // MARK: - ...")
// MARK: Main screen

final class MainScreenVC: UIViewController {
    
    #warning("После // до MARK должен быть пробел")
    //MARK: Outlets
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            
            #warning("Не нужны комменты на самодостаточном коде")
            //register UINibs
            tableView.register(SliderTableViewCell.uiNib, forCellReuseIdentifier: SliderTableViewCell.reuseID)
            tableView.register(CategoryTableViewCell.uiNib, forCellReuseIdentifier: CategoryTableViewCell.reuseID)
            tableView.register(AddInfoTableViewCell.uiNib, forCellReuseIdentifier: AddInfoTableViewCell.reuseID)
            tableView.register(ProductsTableViewCell.uiNib, forCellReuseIdentifier: ProductsTableViewCell.reuseID)
            tableView.register(BrandsTableViewCell.uiNib, forCellReuseIdentifier: BrandsTableViewCell.reuseID)
            tableView.register(FindsTableViewCell.uiNib, forCellReuseIdentifier: FindsTableViewCell.reuseID)
        }
    }

    #warning("Следи за правильным написанием. Тут должно быть Properties")
    //MARK: Propities
    
    #warning("Эти проперти должны быть инкапсулированы, добавь private")
    var blocks: [Block] = []
    
    #warning("Проперти, в котором нет никакого смысла, его нужно убрать")
    var result = Response(blocks: [Block]()) {
        didSet {
            #warning("Две строки кода ниже отсюда нужно перенести в completion блок API.loadJSON, убрать оттуда лишнеее присваивание")
            
            #warning("Дважды подряд присваивать разные вещи в одно и то же поле класса - плохая практика. Можно обойтись либо локальной переменной, либо в данной ситуации просто сразу прописать result.blocks.sorted...")
            blocks = result.blocks
            #warning("Такие вещи нужно инкапсулировать. Ты должен довести этот код до вида .sorted(by: <). Попытайся сделать это сам, следуя ошибкам, которые тебе будет показывать хкод")
            blocks = blocks.sorted { $0.priority < $1.priority }
            
            #warning("Это нужно перенести в didSet blocks, убрать ненужное прописание self")
            self.tableView.reloadData()
            
        }
    }
    
    #warning("Почему это не начать выполнять как можно раньше? Во viewDidLoad, к примеру")
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        API.loadJSON { result in
            #warning("Горизонтальные отступы")
            self.result=result
        }
    }
}

#warning("Неправильность написания + отсутствие дефиса у внешней марки + ни о чем не говорящее название марки, нужно экстеншны делить по протоколам (1 протокол = 1 экстеншн) и марку называть по протоколу, который используется в этом экстеншне. Пример я тебе в самом первом код ревью привел")
// MARK: Exstensions

extension MainScreenVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.blocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            #warning("Лишний вертикальный отступ, после начала декларации метода он никогда не делается. При этом между кейсами свитча можно делать отступы, если нужно разделить массивные функциональные блоки, так что в этом плане ты все ок сделал")
            #warning("Лишняя горизонтальная табуляция, это вообще недопустимо")
            #warning("Опять ненужное написание self")

            switch self.blocks[indexPath.row].type {
                
            case "slider":
                let imagesStockBanner: [StockBannerModel] = blocks[indexPath.row].items as! [StockBannerModel]
                #warning("Лишний пробел перед =")
                let imagesUrlStockBanner: [String]  = imagesStockBanner.map { $0.image }
                
                #warning(#"Зачем писать explicit тип у локальной константы, если ты в конце пишешь "as! SliderTableViewCell"?"#)
                #warning("""
                    Такие длинные строки нужно переносить. В данном случае:
                
                    let cell = tableView.dequeueReusableCell(
                        withIdentifier: SliderTableViewCell.reuseID,
                        for: indexPath
                    ) as! SliderTableViewCell

                """)
                let cell: SliderTableViewCell = tableView.dequeueReusableCell(withIdentifier: SliderTableViewCell.reuseID, for: indexPath) as! SliderTableViewCell
                #warning("Лишний пробел перед ). Следи за этим, пожалуйста")
                cell.setup(images: imagesUrlStockBanner )
                return cell
                
            case "products_hot", "products":
                #warning("После строки с case не нужен вертикальный отступ")
                
                #warning("Explicit типы у локальных констант не нужны в большинстве случаев, читать очень неудобно. Относится ко всем подобным строкам в этом файле")
                #warning("Вместо использования nil-coalescing оператора в таком случае нужно сделать так, чтобы hexString умел принимать optional String, потому что писать вне функции литерал белого (да и любого) хекса - недопустимо")
                let bgColor: UIColor = UIColor(hexString: blocks[indexPath.row].background?.value ?? "#ffffff")
                let fontColor: UIColor = UIColor(hexString: blocks[indexPath.row].fontColor?.value ?? "#ffffff")
                let productsBlock: [ProductsModel] = blocks[indexPath.row].items as! [ProductsModel]
                let imagesProducts: [String] = productsBlock.map { $0.preview }
                let priceProducts: [Price] = productsBlock.map { $0.price }
                let nameProductsBanner: String = blocks[indexPath.row].name
                let titleProductBanner: [String] = productsBlock.map { $0.title }
                let brandsProduct: [String] = productsBlock.map { $0.brand.image }
                let ratingCount: [Int] = productsBlock.map { $0.rate?.numberOfVotes ?? 0 }
                let rating: [Double] = productsBlock.map { $0.rate?.votes ?? 0 }
                let colors: [[Colors]?] = productsBlock.map { $0.colors}
                
                #warning("Переноси такие длинные строки (относится ко всем подобным ниже)")
                let cell: ProductsTableViewCell = tableView.dequeueReusableCell(withIdentifier: ProductsTableViewCell.reuseID, for: indexPath) as! ProductsTableViewCell
                cell.setup(images: imagesProducts, price: priceProducts, name: nameProductsBanner, color: bgColor, title: titleProductBanner, brands: brandsProduct, fontColor: fontColor, ratingCount: ratingCount, rating: rating, colors: colors)
                
                return cell
                
            case "brands":
                let brandsBlock: [BrandModel] = blocks[indexPath.row].items as! [BrandModel]
                let imagesBrands: [String] = brandsBlock.map { $0.image }
                
                let cell: BrandsTableViewCell = tableView.dequeueReusableCell(withIdentifier: BrandsTableViewCell.reuseID, for: indexPath) as! BrandsTableViewCell
                #warning("Лишний пробел (относится ко всем подобным строкам ниже)")
                cell.setup(images: imagesBrands )
                return cell
                
            case "additional_infos":
                let addInfoBlock: [StockBannerModel] = blocks[indexPath.row].items as! [StockBannerModel]
                let imagesAddInfo: [String] = addInfoBlock.map { $0.image }
                
                let cell: AddInfoTableViewCell = tableView.dequeueReusableCell(withIdentifier: AddInfoTableViewCell.reuseID, for: indexPath) as! AddInfoTableViewCell
                cell.setup(data: imagesAddInfo )
                return cell
                
            case "finds":
                let findsBlock: [StockBannerModel] = blocks[indexPath.row].items as! [StockBannerModel]
                let imagesFinds: [String] = findsBlock.map { $0.image }
                
                let cell: FindsTableViewCell = tableView.dequeueReusableCell(withIdentifier: FindsTableViewCell.reuseID, for: indexPath) as! FindsTableViewCell
                cell.setup(images: imagesFinds )
                return cell
                
            #warning("Бизнес-логика приложения не подразумевает возможность появления неопознанного блока. Поэтому тебе нужно избавиться от default кейса, переделав реализацию свитча со строк на enum")
            default:
                var categoryBlockItems = blocks[indexPath.row].items as! [StockBannerModel]
                categoryBlockItems.sort(by: {$0.priority < $1.priority})
                let imagesCategory: [String] = categoryBlockItems.map { $0.image}
                let labelsCategory: [String] = categoryBlockItems.map { $0.name }
                let imagesLabelsCategory: [[String]] = [imagesCategory,labelsCategory]
                
                let cell: CategoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.reuseID, for: indexPath) as! CategoryTableViewCell
                cell.setup(data: imagesLabelsCategory)
                return cell
                
            }
    }
}
