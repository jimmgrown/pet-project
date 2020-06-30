import UIKit

#warning("""
Также, привыкай использовать четкую структуру файла:

// MARK: - Auxiliary (опциональный блок, его может и не быть)

extension SomeClass {

// MARK: Types

private (может быть и internal) enum/struct SomeEnumOrStruct {
...
}

// MARK: Constants

private let someConstant: Int (например) = 1000

}

// MARK: - Declaration

(final) class SomeClass: SomeParent {

// MARK: Outlets (если есть. Не забывай их всегда делать приватными и хотя бы себе ответь на вопрос, почему это нужно)

@IBOutlet private weak var someLabel: UILabel!
@IBOutlet private weak var someView: UIView!

// Если ты углубляешь скоуп (т.е ставишь очередные фигурные скобки, то до и после них должен всегда быть вертикальный отступ для читабельности. То же самое относится и ко внутренностям методов и тд)
@IBOutlet private weak var someButton: UIButton! {
didSet {
...
}
}

// MARK: Public properties (если есть. Если работаешь без модульной структуры, то в эту секцию просто помещай internal проперти. В подобные секции декларации класса помещаются ТОЛЬКО stored проперти, до computed дойдем позже)

// Обязательно у пропертей объекта нужно указывать явный тип. Опять же ответ на "почему?" в моем докладе
var someProperty: Int = 10

// MARK: Private properties (если есть)

...

// MARK: Initialization (если есть)

...

// MARK: Life cycle (если есть)

...

// MARK: Overridden API (если есть. Сюда не включается лайф сайкл контроллера, к примеру)

...

// MARK: Should/Must/May-be-overridden API (Эти 3 опциональных секции нужны для методов и пропертей, с которыми могут/должны происходить какие-то модификации в сабклассах)

...

// MARK: Deinitialization (если есть)

...

}

// MARK: - Actions (если есть IBAction'ы. Сюда же помещаются хендлеры для gesture рекогнайзеров, добавленных программно, например. Не забывай это все тоже делать приватным)

extension SomeClass {
...
}

// MARK: - Some Protocol (обязательно для каждого протокола должен быть отдельный extension. Исключением может быть случай, когда протокол выражает весь смысл класса и без него, например, декларация класса будет просто с пустыми скобками {})

extension SomeClass: SomeProtocol {
...
}

// MARK: - Private API (приватные методы и computed проперти)

extension SomeClass {
...
}

// MARK: - Public API (публичные/internal методы и computed проперти)

extension SomeClass {
...
}

Такая структура, естественно, может подвергаться различным модификациям в зависимости от ситуации + она основана на моих предпочтениях и облегчении читаемости кода. Главное, чтобы та структура, которую ты используешь была однородна и резонна. Смотря на мой ппример обращай внимание на все вертикальные и горизонтальные отступы, на марки, дефисы в них, написание с большой буквы и тд. В проекте очень удобно использовать minimap для ориентации в коде, эти марки именно в таком виде обеспечивают хорошую структуру при просмотре)
""")

final class SliderTableViewCell: UITableViewCell {
    
    //MARK: Constants
    
    static let uiNib: UINib = UINib(nibName: String(describing: SliderTableViewCell.self), bundle: nil)
    static let reuseID: String = .init(describing: SliderTableViewCell.self)
    
    //MARK: Outlets
    
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var collectionView: UICollectionView! {
        
        didSet{
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(uiNib, forCellWithReuseIdentifier: SliderCollectionViewCell.reuseID)
        }
        
    }
    
    //MARK: Propities
    
    let uiNib: UINib = UINib(nibName: String(describing: SliderCollectionViewCell.self), bundle: nil)
    var images: [String] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    //MARK: Methods
    
    func setup(images: [String]) {
        self.images = images
        //setTimer()
    }
    
//    var x = 1
//    let infiniteSize = 10000000
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    func setTimer() {
//        let _ = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
//    }
    
//    @objc func autoScroll() {
//        if self.x < infiniteSize {
//            let indexPath = IndexPath(item: x, section: 0)
//            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//            self.x = self.x + 1
//        } else {
//            self.x = 1
//            self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
//        }
//    }
}

//MARK: Extensions

extension SliderTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        pageControl.numberOfPages = self.images.count
        if images.count > 0 {
            return images.count//infiniteSize //images.count
        } else {
            return 0    
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: SliderCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderCollectionViewCell.reuseID,for: indexPath) as! SliderCollectionViewCell
        cell.setup(image: self.images[indexPath.row])//% images.count
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heightSize = collectionView.frame.size.height
        let widthSize = collectionView.frame.size.width
        return CGSize(width: widthSize, height: heightSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            self.pageControl.currentPage = indexPath.row //% self.images.count
    }
}
