#warning("Очисти проект от лишнего мусора")

//import UIKit
//
//class ViewCыontroller: UIViewController {
//
//    
//    @IBOutlet weak var brandCollectionView: UICollectionView!
//    @IBOutlet weak var hotCollectionView: UICollectionView!
//    @IBOutlet weak var infoCollectionView: UICollectionView!
//    @IBOutlet weak var categoryCollectionView: UICollectionView!
//    @IBOutlet weak var sliderCycle: UICollectionView!
//    @IBOutlet weak var pageControlSlide: UIPageControl!
//    
//    func setTimer() {
//        let _ = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
//    }
//    var result = Response(blocks: [Block]()){
//        didSet{
//            DispatchQueue.main.async {
//                self.sliderCycle.reloadData()
//                self.categoryCollectionView.reloadData()
//                self.infoCollectionView.reloadData()
//                self.hotCollectionView.reloadData()
//                self.brandCollectionView.reloadData()
//            }
//            print(self.result.blocks.count)
//        }
//    }
//    var x = 1
//    let infiniteSize = 10000000
//    
//    @objc func autoScroll() {
//        if self.x < infiniteSize {
//            let indexPath = IndexPath(item: x, section: 0)
//            self.sliderCycle.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
//            self.x = self.x + 1
//        } else {
//            self.x = 1
//            self.sliderCycle.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
//        }
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        sliderCycle.dataSource = self
//        categoryCollectionView.dataSource = self
//        infoCollectionView.dataSource = self
//        hotCollectionView.dataSource = self
//        brandCollectionView.dataSource = self
//        
//        sliderCycle.delegate = self
//        //categoryCollectionView.delegate = self
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        API.loadJSON { [weak self] result in
//            self?.result=result
//        }
//        self.sliderCycle.reloadData()
//        self.categoryCollectionView.reloadData()
//        self.infoCollectionView.reloadData()
//        self.hotCollectionView.reloadData()
//        self.brandCollectionView.reloadData()
//        setTimer()
//    }
//}
//
//extension ViewController:UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if self.result.blocks.count > 0 {
//            if collectionView == self.sliderCycle {
//                pageControlSlide.numberOfPages = self.result.blocks[1].items.count
//                return infiniteSize
//            }
//            else if collectionView == self.infoCollectionView {
//                return self.result.blocks[2].items.count
//            }
//            else if collectionView == self.hotCollectionView {
//                return self.result.blocks[3].items.count
//            }
//            else if collectionView == self.brandCollectionView {
//                return self.result.blocks[7].items.count
//            }
//            else {
//                return self.result.blocks[0].items.count
//            }
//        } else {
//            return 0
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if self.result.blocks.count > 0 {
//            if collectionView == self.sliderCycle {
//                let cell: CollectionViewCellSlider = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell",
//                                                                                        for: indexPath) as! CollectionViewCellSlider
//                cell.setup(response: self.result.blocks[1].items[indexPath.row % self.result.blocks[1].items.count] as! ModelBlockIdTwo)
//                return cell
//            }
//            else if collectionView == self.infoCollectionView {
//                let cell: CollectionViewCellInfo = collectionView.dequeueReusableCell(withReuseIdentifier: "infoCell",
//                                                                                          for: indexPath) as! CollectionViewCellInfo
//                cell.setup(response: self.result.blocks[2].items[indexPath.row] as! ModelBlockIdTwo)
//                return cell
//            }
//            else if collectionView == self.hotCollectionView {
//                let cell: CollectionViewCellHot = collectionView.dequeueReusableCell(withReuseIdentifier: "hotCell",
//                                                                                      for: indexPath) as! CollectionViewCellHot
//                cell.setup(response: self.result.blocks[3].items[indexPath.row] as! ModelBlockIdFour)
//                return cell
//            }
//            else if collectionView == self.brandCollectionView {
//                let cell: CollectionViewCellBrand = collectionView.dequeueReusableCell(withReuseIdentifier: "brandCell",
//                                                                                     for: indexPath) as! CollectionViewCellBrand
//                cell.setup(response: self.result.blocks[7].items[indexPath.row] as! ModelBlockIdFive)
//                return cell
//            }
//            else {
//                let cell: CollectionViewCellCategory = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell",
//                                                                                        for: indexPath) as! CollectionViewCellCategory
//                cell.setup(response: self.result.blocks[0].items[indexPath.row] as! ModelBlockIdTwo)
//                return cell
//            }
//        } else {
//            let cell:UICollectionViewCell? = nil
//            return cell!
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if collectionView == self.sliderCycle {
//            self.pageControlSlide.currentPage = indexPath.row % self.result.blocks[1].items.count
//        }
//    }
//}
//
//extension ViewController:UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if collectionView == self.sliderCycle {
//            let widthSize = collectionView.frame.size.width
//            let heightSize = collectionView.frame.size.height
//            return CGSize(width: widthSize, height: heightSize)
//        }
//        else {
//            let widthSize = collectionView.frame.size.width / 4.5
//            return CGSize(width: widthSize, height: widthSize)
//        }
//    }
//}
//
//
