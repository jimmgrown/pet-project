import UIKit

#warning("Опасное дело - сабкласситься от стэк вью. Это очень ограниченный, так называемый convenience, класс, который крут при верстке. Делать его еще более ограниченным, делая ad-hoc сабкласс, может вызвать непредсказуемое поведение. Я имел в виду не совсем такую реализацию. Ты должен был сделать сабкласс UIView, добавив в его зибе UIStackView в качестве subview, и уже потом в него засовывать звезды.")
class RatingStackView: UIStackView {

    var starRating: Int = 0
    
    #warning("В ворнинге я в полной мере не смогу объяснить работу draw, но то, что ты тут делаешь, - абсолютно противопоказано. Почитай про тайминги вызова этого метода, что он делает, какие есть минусы его использования, и как можно оптимизировать данную работу. Подсказка - нужно подключать асинхронную работу с рисованием/добавлением сабвьюх. Ты же тут сделал полностью противоположную работу - метод, который напрямую влияет на fps приложения, ты наделил двумя синхронными циклами. И учти, что эта вьюшка у тебя находится в ячейке коллекции, поэтому все просадки fps умножай во сколько раз, сколько у тебя ячеек на экране.")
    #warning("Странные вертикальные отступы при открытии новых скоупов")
    override func draw(_ rect: CGRect) {
        
        let views = self.subviews.filter { $0 is UIButton }
        var starTag = 1
        
        #warning("""
            Более лаконичный эквивалент цикла ниже. Можно избавиться от лишнего if let
        
            for case let theButton as UIButton in views {
                ...
            }
        """)
        
        for theView in views {
            
            #warning("theButton, theView - очень сомнительный нейминг, никогда так не делай")
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
                #warning("else не переноси на следующую строку после }")
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
