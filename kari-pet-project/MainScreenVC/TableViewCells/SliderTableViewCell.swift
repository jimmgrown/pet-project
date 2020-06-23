import UIKit

#warning("""
        Не нужно просто так выносить папку для ячеек на верхний уровень. Структура должна выглядеть так:

        - SomeVC
            * SomeVC.swift
            - TableViewCells
                - SomeTVCell
                    * SomeTVCell.swift
                    * SomeTVCell.xib
        
        Только в той ситуации, когда ячейка используется на нескольких контроллерах, ее подпапку можно вынести в отдельную папку на верхнем уровне.
        Нейминг зависит от вкуса, главное, чтобы он следовал однородному паттерну по всему проекту.
        Можешь использовать тот, который я тебе дал в примере выше
        """)

#warning("Все, что скроллится горизонтально можно назвать слайдером. Поэтому твой нейминг не является исчерпывающим. Перед продолжением работы для каждого блока баннеров придумай четкое название, которое будет выделять его среди других и согласуй со мной")

#warning("Про модификаторы ты услышал в моем докладе, поэтому сразу начинай их использовать везде")

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

class SliderTableViewCell: UITableViewCell {
    
    #warning("Никогда не используй для reuse ID такие стринги. У тебя есть String(describing: SomeType.self). Это всегда должно выступать в качестве айдишника")
    static let identifier = "sliderTableCell"
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    #warning("Следи за горизонтальными пробелами во всем своем коде, не только тут")
    #warning("Почему эта внутренняя ячейка имеет доступ к блокам, которые вообще никак к ней не относятся? Сюда должен прилететь массив картинок и все")
    var result = Response(blocks: [Block]()){
        didSet{
            print("this is zero")
            self.collectionView.reloadData()
        }
    }
    
    #warning("Если ты ставишь принты, хотя бы не ставь их такими рандомными, они тоже должны печатать что-то понятное постороннему разработчику")
    func setup(response: Response){
        self.result = response
        print("this is one")
        //setTimer()
    }
    
    #warning("Это что-то лишнее, через такие вещи логика не строится")
    var x = 1
    let infiniteSize = 10000000
    
    
    #warning("Чаще всего настройку аутлета лучше всего писать в didSet самого аутлета")
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        #warning("reuse ID опять стрингом")
        collectionView.register(SliderCollectionViewCell.self, forCellWithReuseIdentifier: "sliderCell")
        //self.collectionView.reloadData()
    }
    
    #warning("Пока что занимайся версткой и бизнес-логикой без дополнительного функционала, потому что его так точно нельзя реализовывать, но при этом сейчас не время отвлекаться на подробный разбор")
    func setTimer() {
        let _ = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    @objc func autoScroll() {
        if self.x < infiniteSize {
            let indexPath = IndexPath(item: x, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.x = self.x + 1
        } else {
            self.x = 1
            self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}

extension SliderTableViewCell: UICollectionViewDataSource {
    
    #warning("Зачем здесь такая логика? Тебе нужно count картинок здесь вернуть и все")
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.result.blocks.count > 0 {
            pageControl.numberOfPages = self.result.blocks[1].items.count
            print(self.result.blocks[1].items.count)
            return infiniteSize
        } else {
            print("ZERO")
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        #warning("Пробелы после запятых ставь плз")
        let cell: SliderCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell",for: indexPath) as! SliderCollectionViewCell
        #warning("Лишний код надо полностью стирать, а не комментировать")
        //if self.result.blocks.count > 0 {
        #warning("Также, такой код в одну строку не пишут, нужно выносить в понятные локальные переменные. У тебя их тут не будет, конечно, как только ты отрефакторишь дата сорс этой ячейки, но на будущее знай")
        cell.setup(response: self.result.blocks[1].items[indexPath.row % self.result.blocks[1].items.count] as! ModelBlockIdTwo)
        print(result.blocks[1].items.count,"Items count")
        //}
        return cell
    }
}

#warning("Судя по констреинтам в зибе, твоя ячейка не ресайзнется корректно, нужно, чтобы контент внутри нее растягивал ее края самостоятельно. Подумай, что тебе для этого нужно сделать")
