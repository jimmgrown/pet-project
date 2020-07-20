import UIKit

// MARK: - Declaration

protocol ReusableVC: class {
    static var reuseID: String { get }
}

extension ReusableVC where Self: UIViewController  {
    
    static var reuseID: String {
        return String(describing: self)
    }
    
}
