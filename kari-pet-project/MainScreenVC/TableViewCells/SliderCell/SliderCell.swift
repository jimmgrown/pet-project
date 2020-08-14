import UIKit

// MARK: - Declaration

final class SliderCell: UITableViewCell, ReusableCell {
    
    // MARK: Outlets
    
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet{
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(BannerCell.self)
        }
    }
    
    // MARK: Private roperties
    
    private var images: [String] = [] {
        didSet {
            self.collectionView.reloadData()
        } 
    }
//    var x = 1
//    let infiniteSize = 10000000
    
}

// MARK: - Public API

extension SliderCell {
    
    func setup(images: [String]) {
        self.images = images
        //setTimer()
    }
    
}

// MARK: - UICollectionViewDataSource

extension SliderCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        pageControl.numberOfPages = self.images.count
        if images.count > 0 {
            return images.count//infiniteSize //images.count
        } else {
            return 0    
        }
        
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: BannerCell = collectionView.dequeueReusableCell(for: indexPath)
        
        cell.setup(image: self.images[indexPath.row])//% images.count
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
            self.pageControl.currentPage = indexPath.row //% self.images.count
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension SliderCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let heightSize = collectionView.frame.size.height
        let widthSize = collectionView.frame.size.width
        return CGSize(width: widthSize, height: heightSize)
    }
    
}
