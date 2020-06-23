import UIKit

class RatingStackView: UIStackView {

    var starRating: Int = 0
    
    override func draw(_ rect: CGRect) {
        
        let views = self.subviews.filter { $0 is UIButton }
        var starTag = 1
        
        for theView in views {
            
            if let theButton = theView as? UIButton {
                
                theButton.setImage(UIImage(named: "stars"), for: .normal)
                theButton.addTarget(self, action: #selector(self.pressed(sender:)), for: .touchUpInside)
                theButton.tag = starTag
                starTag += 1
                
            }
            
        }
    }
    
    @objc func pressed(sender: UIButton) {
        starRating = sender.tag
        
        let views = self.subviews.filter { $0 is UIButton }
        
        for theView in views {
            if let theButton = theView as? UIButton {
                
                if theButton.tag > sender.tag {
                    theButton.setImage(UIImage(named: "stars"), for: .normal)
                }
                else {
                    theButton.setImage(UIImage(named: "starsFilled"), for: .normal)
                }
                
            }
        }
    }

}
