import UIKit

final class ProductsTableViewCell: UITableViewCell, ReusableView, NibLoadableView {

    #warning("После // и перед MARK нужен пробел, проставь это везде")
    //MARK: Outlets

    #warning("Пофикси вертикальные отступы во всем этом файле")
    #warning("Сокращения не приветствуются в нейминге")
    @IBOutlet private weak var bgView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(ProductsCollectionViewCell.self)
        }
    }

    #warning("Разберись с приватностью пропертей ниже")
    #warning("Нейминг неподходящий, нужно назвать nameLabel, а еще лучше titleLabel")
    @IBOutlet weak var labelName: UILabel!
    
    //MARK: Properties

    #warning("Почему здесь инитится какой-то рандомный инстанс контроллера?")
    #warning("Прочитай про ARC в свифте и сам найди здесь очень грубую ошибку")
    var vc = MainScreenVC()
    var ratingCount: [Int] = []
    var title: [String] = []
    var price: [Price] = []
    var brands: [String] = []
    var rating: [Double] = []
    var colors: [[Colors]?] = [[]]
    var images: [String] = [] {
        didSet {
            #warning("Избавляйся от лишних использований self")
            self.collectionView.reloadData()
        }
    }
    
    //MARK: Methods

    #warning("""
    Если переносишь что-то, переносить нужно по одному элементу на 1 строке, при это первый элемент списка должен быть уже на новой строке.
    И скоуп в таком случае тоже с новой строки будет открываться:

    func setup(
        images: [String],
        price: [Price],
        name: String,
        color: UIColor,
        title: [String],
        brands: [String],
        fontColor: UIColor,
        ratingCount: [Int],
        rating: [Double],
        colors: [[Colors]?],
        vc: MainScreenVC
    ) {
        ...
    }
    """)
    #warning("Что интернал метод делает в декларации класса?")
    func setup(images: [String], price: [Price], name: String, color: UIColor,
        title: [String], brands: [String], fontColor: UIColor, ratingCount: [Int],
        rating: [Double], colors: [[Colors]?], vc: MainScreenVC) {
        self.colors = colors
        self.images = images
        self.price = price
        self.title = title
        self.brands = brands
        self.ratingCount = ratingCount
        self.rating = rating
        self.vc = vc
        
        labelName.text = name
        labelName.textColor = fontColor
        collectionView.backgroundColor = color
        bgView.backgroundColor = color
    }

    #warning("Не оставляй лишние методы")
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

//MARK: - UICollectionViewDataSource

extension ProductsTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

        #warning("Сделай корректные переносы на новую строку")
        cell.setup(image: images[indexPath.row], price: price[indexPath.row], title: title[indexPath.row], brand: brands[indexPath.row], votes: ratingCount[indexPath.row], rating: rating[indexPath.row], colors: colors[indexPath.row])
        return cell
        
    }

    #warning("Этот метод не принадлежит этому экстеншну")
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        #warning("Лишний горизонтальный отступ")
        #warning("Почему ты передаешь литералом айдишник + потенциально даешь ячейке возможность пушить на родительский контроллер все, что она захочет? Пересмотри направление зависимостей и инкапсуляцию функциональности, пока что флоу очень странный. И айдишник контролллера/сегвея должен соответствовать названию класса (так же, как сейчас у ячеек)")
            vc.switchToViewController(identifier: "goods")
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ProductsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 1.85
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
}
