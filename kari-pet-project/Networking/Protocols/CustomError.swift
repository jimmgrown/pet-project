import UIKit

//MARK: Types

enum CustomError: Error {
    case lostConnection
    case badDecode
    case badRequest
}

// MARK: - Public API

extension CustomError {
    
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
    
    func alertError(vc: UIViewController) {
        let error = switchError(error: self)
        let alert = UIAlertController(title: "Ошибка", message: "\(String(describing: error))", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ладно", style: UIAlertAction.Style.default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
}
