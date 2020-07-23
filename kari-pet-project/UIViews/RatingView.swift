import UIKit

final class RatingView: UIView {

    // MARK: Outlets
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var stackView: UIStackView!
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

}

// MARK: Private API

extension RatingView {
    
    private func commonInit() {
        Bundle.main.loadNibNamed("RatingView", owner: self, options: nil)
        addSubview(contentView)
        contentView.bounds = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        stackView.changeImages(stkView: self.stackView)
    }
    
}

// MARK: Public API

extension RatingView {
    
    func firstInit(rate: Int, stkView: RatingView) {
        let views = stkView.stackView.subviews.filter { $0 is UIButton }
        
        for case let starButton as UIButton in views {
            if starButton.tag <= rate {
                starButton.setImage(UIImage(named: "starsFilled"), for: .normal)
            }
        }
    }
    
}

// MARK: - UIStackView

extension UIStackView {
    
    func changeImages(stkView: UIStackView) {
        let views = stkView.subviews.filter { $0 is UIButton }
        var starTag = 1
        
        for case let starButton as UIButton in views {
                starButton.addTarget(self, action: #selector(self.pressed(sender:)), for: .touchUpInside)
                starButton.tag = starTag
                starTag += 1

        }
    }
    
    @objc func pressed(sender: UIButton) {
        let views = self.subviews.filter { $0 is UIButton }

        for view in views {
            if let theButton = view as? UIButton {
                if theButton.tag > sender.tag {
                    theButton.setImage(UIImage(named: "stars"), for: .normal)
                } else {
                    theButton.setImage(UIImage(named: "starsFilled"), for: .normal)
                }
            }
        }
    }
    
}
