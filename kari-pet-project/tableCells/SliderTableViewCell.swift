import UIKit

class SliderTableViewCell: UITableViewCell {
    
    static let identifier = "sliderTableCell"
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var result = Response(blocks: [Block]()){
        didSet{
            print("this is zero")
            self.collectionView.reloadData()
        }
    }
    
    func setup(response: Response){
        self.result = response
        print("this is one")
        //setTimer()
    }
    
    var x = 1
    let infiniteSize = 10000000
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.register(SliderCollectionViewCell.self, forCellWithReuseIdentifier: "sliderCell")
        //self.collectionView.reloadData()
    }
    
    
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
        let cell: SliderCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCell",for: indexPath) as! SliderCollectionViewCell
        //if self.result.blocks.count > 0 {
        cell.setup(response: self.result.blocks[1].items[indexPath.row % self.result.blocks[1].items.count] as! ModelBlockIdTwo)
        print(result.blocks[1].items.count,"Items count")
        //}
        return cell
    }
}


