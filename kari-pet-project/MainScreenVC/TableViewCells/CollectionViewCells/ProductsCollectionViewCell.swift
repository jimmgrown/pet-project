import UIKit

// MARK: - Declaration

#warning("Лишний пробел перед {")
final class ProductsCollectionViewCell: UICollectionViewCell, CellsRegistration  {

    #warning("Пробел после //")
    //MARK: Outlets
    
    #warning("Вертикальные отступы")
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var firstPriceLabel: UILabel!
    @IBOutlet private weak var currentPriceLabel: UILabel!
    @IBOutlet private weak var discountLabel: UILabel!
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var brandIcon: UIImageView!
    @IBOutlet private weak var rateView: RatingView!
    @IBOutlet private weak var ratingCount: UILabel!
    @IBOutlet private weak var colorsCollectionView: UICollectionView! {
        didSet {
            colorsCollectionView.register(ColorsCollectionViewCell.self)
            colorsCollectionView.dataSource = self
            colorsCollectionView.delegate = self
        }
    }
    
    #warning("А почему они тут не приватные?")
    // MARK: Public roperties
    
    var rating: Int = 0
    var image: String = ""
    #warning("Почему этот массив опшнал?")
    var colors: [Colors]? = []

}

// MARK: - Public API

#warning("Вертикальные отступы - недостающие между скоупами и лишние внутри скоупов")
extension ProductsCollectionViewCell {
    #warning("Пробелы после :, ) нужно сместить на таб левее и поставить пробел перед {")
    func setup(
        image:String,
        price:Price,
        title: String,
        brand: String,
        votes: Int,
        rating: Double,
        colors: [Colors]?
        ){
        
        if let url = URL(string: image){
            imageView.sd_setImage(with: url)
        }
        
        if let url = URL(string: brand){
            brandIcon.sd_setImage(with: url)
        }
        self.image = image
        self.colors = colors
        labelTitle.text = title
        ratingCount.text = String(votes)
        self.rating = Int(rating)
        rateView.firstInit(rate: Int(rating),stkView: rateView)
        if price.discount != nil {
            
            #warning("Зачем тут проверка на нил в ифе, а потом форс анрэп, если есть опшнал байндинг?")
            currentPriceLabel.text = "\(String(price.current)) ₽"
            discountLabel.text = "-\(String(describing: price.discount!))%"
            
            #warning("Cлишком длинные строки")
            #warning("Лишний пробел после =; форс анрэп тут плох")
            #warning("Зачем ты используешь интерполяцию вместе с инитом стринга? Интерполяция сама умеет кастить в стринг, она для этого и существует))))")
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "\(String(price.first!)) ₽")
            #warning("Используй тайп инференс")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            firstPriceLabel.attributedText = attributeString
            
            #warning("Форматируй if-elseif-else конструкции верным образом")
        }
        else {
            firstPriceLabel.isHidden = true
            discountLabel.isHidden = true
            #warning("Опять лишний инит стринга")
            currentPriceLabel.text = "\(String(price.current)) ₽"
        }
    }
}

#warning("Пробел после //")
//MARK: - UICollectionViewDataSource

#warning("Вертикальные отступы + лишний код")
extension ProductsCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ColorsCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.setup(colors: colors?[indexPath.row])
        return cell
    }
    
    //MARK: Change preview by colors
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let url = URL(string: colors?[indexPath.row].preview ?? self.image){
//            imageView.sd_setImage(with: url)
//            colorsCollectionView.reloadData()
//        }
//    }
}

#warning("Пробел после //")
//MARK: - UICollectionViewDelegateFlowLayout

#warning("Вертикальные отступы")
extension ProductsCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let side = collectionView.frame.size.height
        return CGSize(width: side, height: side)
    }
}
