import UIKit

#warning("Пробел после //, Types - неподходящее название, не хватает дефиса")
//MARK: Types

#warning("Нейминг абстрактный, ни о чем не говорящий. Это енам для ошибок нетворкинга, это нужно отразить в названии")
#warning("Как ты будешь через текущий енам экранировать сообщение об ошибке с сервера, либо разделять логику в зависимости от кода ошибки?")
enum CustomError: Error {
    case lostConnection
    case badDecode
    case badRequest
}

// MARK: - Public API

extension CustomError {
    
    #warning("Зачем сюда передавать ошибку, если вместо этого можно сделать компьютед проперти и работать с self?")
    #warning("Плохой нейминг, абсолютно не отражает того, что делает метод. Нужно обозначить то, что ты из него получишь, назвав его, например, presentationValue")
    func switchError(error: CustomError) -> String {
        switch error {
        case .lostConnection:
            return "Проверьте интернет подключение!"
        case .badDecode:
            return "Что-то пошло не так!"
        case .badRequest:
            return "Сервер не отвечает!"
        }
    }
    
    #warning("""
    Работай над неймингом, если сомневаешься, как назвать, сразу спрашивай у меня. В данном случае нужно назвать примерно так:
    func present(on vc: UIViewController)
    """)
    func alertError(vc: UIViewController) {
        let error = switchError(error: self)
        #warning("Слишком длинная строка")
        #warning("Используй type inference там, где это поможет сделать код более лаконичным. Инит алерта уже ожидает какой-то кейс енама UIAlertController.Style в параметре preferredStyle, поэтому нет необходимости писать это явным образом еще раз, можно просто указать .alert")
        #warning("Во-первых, String(describing: ...) - это инит, очевидно, строки, поэтому зачем тут используется string interpolation? Во-вторых, error - это уже строка, зачем ее помещать в инит другой строки?))))")
        let alert = UIAlertController(title: "Ошибка", message: "\(String(describing: error))", preferredStyle: UIAlertController.Style.alert)
        #warning("См. предыдущий ворнинг про type inference")
        alert.addAction(UIAlertAction(title: "Ладно", style: UIAlertAction.Style.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
}
