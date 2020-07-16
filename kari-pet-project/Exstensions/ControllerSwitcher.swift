import UIKit

// MARK: - Switcher Protocol

protocol SwitcherVC: class {
    static var restorationIdentifier: String { get }
}

extension SwitcherVC where Self: UIViewController  {
    
    static var restorationIdentifier: String {
        return String(describing: self)
    }
    
}

//MARK: - Public API

extension UIViewController {
    func switchController<vc: UIViewController>(_: vc.Type) where vc: SwitcherVC {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: vc.restorationIdentifier)
        
        show(secondVC, sender: self)
    }
}
