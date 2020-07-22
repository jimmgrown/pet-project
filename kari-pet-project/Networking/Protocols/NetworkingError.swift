import UIKit

// MARK: - Declaration

#warning("Как ты будешь через текущий енам экранировать сообщение об ошибке с сервера, либо разделять логику в зависимости от кода ошибки?")
enum NetworkingError: Error {
    case lostConnection
    case badDecode
    case badRequest
    
    #warning("Что за сокращение Val? Нужно писать целиком, autocompletion в xcode существует именно для того, чтобы ты мог давать полные имена переменным, не печатая их вручную")
    var presentationVal: String {
        switch self {
        case .lostConnection: return "Проверьте интернет подключение!"
        case .badDecode: return "Что-то пошло не так!"
        case .badRequest: return "Сервер не отвечает!"
        }
    }
}

// MARK: - Public API

extension NetworkingError {
    
    func present(on vc: UIViewController) {
        let error = presentationVal
        let alert = UIAlertController(title: "Ошибка", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ладно", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
}
