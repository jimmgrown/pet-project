import SDWebImage
import UIKit

// MARK: - Declaration

final class GoodsVC: UIViewController, ReusableVC {
    
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!  {
        didSet {
            tableView.dataSource = self
            
            tableView.register(GoodsCardTableViewCell.self)
        }
    }
    
    // MARK: Public roperties
    
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
                }
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
