import SDWebImage
import UIKit

#warning("Разберись с вертикальными отступами в этом файле, связанными со скоупами")

// MARK: - Declaration

final class GoodsVC: UIViewController, ReusableVC {
    
    // MARK: Outlets
    
    #warning("private")
    @IBOutlet weak var tableView: UITableView!  {
        didSet {
            tableView.dataSource = self
            
            tableView.register(GoodsCardTableViewCell.self)
        }
    }
    
    #warning("Марка не соответствует написанному под ней")
    // MARK: Public roperties
    
    #warning("Recommended")
    private var recomendedProducts: RecomendedProducts?
    private var uniqueSizesId: [[String]] = [[]] {
        didSet {
            #warning("У тебя нет кода, инициализируюего инстанс RecomendedProducts, а тут ты просто в nil засовываешь какие-то данные. Как это должно работать?")
            recomendedProducts?.uniqueSizeIds = uniqueSizesId[0]
            recomendedProducts?.locationId = API.Main.getBaseLocationId()
            recomendedProducts?.page = 1
            recomendedProducts?.size = 2
            //print(recomendedProducts)
        }
    }
    private let apiClient = APIClient()
    private var goodCards: [GoodsCard] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiClient.send(GetGoodsCard()) { response in
            self.apiClient.handle(response: response) { res, err  in
                if let goodCards = res {
                    self.goodCards = goodCards
                    self.uniqueSizesId = goodCards.map { $0.uniqueSizesIds.map { String($0.value) }}
                }
            }
            let data = try? JSONEncoder().encode(self.recomendedProducts)
            self.apiClient.send(GetRecomendedProducts(httpBody: data)) { response in
                //print(try? JSONSerialization.jsonObject(with: data!, options: []))
                print(response)
            }
        }
        
        
    }
}

// MARK: - UITableViewDataSource

extension GoodsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goodCards.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GoodsCardTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        #warning("Избавься здесь от дупликации кода")
        cell.setup(
            title: goodCards[indexPath.row].title,
            brandImage: goodCards[indexPath.row].brand.image,
            price: goodCards[indexPath.row].price,
            colors: goodCards[indexPath.row].colors,
            sizes: goodCards[indexPath.row].sizes
        )
        return cell
    }
}
