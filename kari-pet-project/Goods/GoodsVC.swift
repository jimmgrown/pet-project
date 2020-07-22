import SDWebImage
import UIKit

#warning("Разберись с вертикальными отступами в этом файле, связанными со скоупами")

// MARK: - Declaration

final class GoodsVC: UIViewController, ReusableVC {
    
    // MARK: Outlets
    
    @IBOutlet private weak var tableView: UITableView!  {
        
        didSet {
            tableView.dataSource = self
            tableView.register(GoodsCardTableViewCell.self)
        }
        
    }
    
    // MARK: Private roperties
    
    private var recommendedProducts: RecomendedProducts?
    private var uniqueSizesId: [[String]] = [[]] {
        
        didSet {
            #warning("У тебя нет кода, инициализируюего инстанс RecomendedProducts, а тут ты просто в nil засовываешь какие-то данные. Как это должно работать?")
            recommendedProducts?.uniqueSizesIds = uniqueSizesId[0]
            recommendedProducts?.locationId = API.Main.getBaseLocationId()
            recommendedProducts?.page = 1
            recommendedProducts?.size = 2
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
            
            self.apiClient.send(RecomendedProducts(locationId: "7400000100000", size: 2, page: 1, uniqueSizesIds: ["329317"])) { response in
                
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
        let card = goodCards[indexPath.row]
        #warning("Избавься здесь от дупликации кода")
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
