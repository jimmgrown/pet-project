import UIKit

// MARK: - Declaration

final class SliderTableViewCell: UITableViewCell, ReusableCell {
    
    // MARK: Outlets
    
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var collectionView: UICollectionView! {
        
        didSet{
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(SliderCollectionViewCell.self)
        }
        
    }
    
    // MARK: Public roperties
    
    var images: [String] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
//    var x = 1
//    let infiniteSize = 10000000
    
}

// MARK: - Public API

extension SliderTableViewCell {
    func setup(images: [String]) {
        self.images = images
        //setTimer()
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

// MARK: - UICollectionViewDataSource

extension SliderTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        pageControl.numberOfPages = self.images.count
        if images.count > 0 {
            return images.count//infiniteSize //images.count
        } else {
            return 0    
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SliderCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        
        cell.setup(image: self.images[indexPath.row])//% images.count
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            self.pageControl.currentPage = indexPath.row //% self.images.count
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SliderTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heightSize = collectionView.frame.size.height
        let widthSize = collectionView.frame.size.width
        return CGSize(width: widthSize, height: heightSize)
    }
}
