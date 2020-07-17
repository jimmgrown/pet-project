import UIKit

#warning("Почему название файла, марка и протокол имеют разные названия?)) + не надо дублировать название протокола в этой марке, оно будет в шапке файла (которую ты удалил). Эта марка должна иметь название Declaration")
// MARK: - Switcher Protocol

#warning("Странный нейминг для протокола, его декларация напрашивает название ReusableVC + тебе нужно ознакомиться с нейминговыми принципами по гайдлайнам эппла")
protocol SwitcherVC: class {
    #warning("Почему этот айдишник назван restoration? Он же совсем не для этого будет использоваться. Надо назвать reuseID/storyboardID")
    static var restorationIdentifier: String { get }
}

extension SwitcherVC where Self: UIViewController  {
    
    static var restorationIdentifier: String {
        return String(describing: self)
    }
    
}

#warning("Пробел после //")
#warning("Название марки вообще же не подходящее")
//MARK: - Public API

#warning("Вертикальные отступы")
extension UIViewController {
    #warning("Чего не хватает в декларации?")
    func switchController<vc: UIViewController>(_: vc.Type) where vc: SwitcherVC {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(withIdentifier: vc.restorationIdentifier)
        
        show(secondVC, sender: self)
    }
}
