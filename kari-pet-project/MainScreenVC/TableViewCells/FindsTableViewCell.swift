import UIKit

final class FindsTableViewCell: UITableViewCell {

    //MARK: Constants
    
    static let uiNib: UINib = UINib(nibName: String(describing: FindsTableViewCell.self), bundle: nil)
    static let reuseID: String = .init(describing: FindsTableViewCell.self)
    let uiNib: UINib = UINib(nibName: String(describing: FindsCollectionViewCell.self), bundle: nil)
    
    //MARK: Outlets
    
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(uiNib, forCellWithReuseIdentifier: FindsCollectionViewCell.reuseID)
        }
    }
    
    //MARK: Propities
    
    var images: [String] = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    //MARK: Methods
    
    func setup(images: [String]) {
        self.images = images
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

//MARK: Extensions

extension FindsTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: FindsCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: FindsCollectionViewCell.reuseID,for: indexPath) as! FindsCollectionViewCell
        cell.setup(image: images[indexPath.row])
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 1.25
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
}
