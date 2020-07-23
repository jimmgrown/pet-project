import UIKit

// MARK: - Declaration

enum NetworkingError: Error {
    case lostConnection
    case badDecode
    case badRequest
    case serverError(message: String)
    case badUnwrapping
    
    var presentationValue: String {
        switch self {
        case .lostConnection: return "Проверьте интернет подключение!"
        case .badDecode: return "Что-то пошло не так!"
        case .badRequest: return "Сервер не отвечает!"
        case .serverError(let message): return message
        case .badUnwrapping: return "Bad unwrapping"
        }
    }
}

// MARK: - Public API

extension NetworkingError {
    
    func present(on vc: UIViewController) {
        let error = presentationValue
        let alert = UIAlertController(title: "Ошибка", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ладно", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
}
