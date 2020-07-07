//
//  ReusableView.swift
//  kari-pet-project
//
//  Created by Admin on 07.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

#warning("Название и содержимое файла не соответствуют друг другу + лучше всего не лепить все в одно место. Если файл называется ReusableView, то здесь должен находиться ТОЛЬКО его протокол с его экстеншнами (НЕ экстеншнами посторонних типов). Правильно назвать файл с экстеншном существующего типа можно следующим образом: UITableView+ТоЧтоТыДобавляешь, в твоем случае UITableView+CellRegistration (процесс регистрации и декьюинга можно объединить одним понятием - регистрация ячеек)")

#warning("Следи за импортами, лишних быть не должно. По дефолту из файла всегда убирай все импорты, пока не понадобится какой-то конкретный. В данном случае нужно убрать Foundation")
import Foundation
import UIKit

// MARK: - Protocols

protocol ReusableView: class {
    static var reuseID: String { get }
}

extension ReusableView where Self: UIView {

    static var reuseID: String {
        return String(describing: self)
    }

}

protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {

    static var nibName: String {
        return String(describing: self)
    }

}

// MARK: - Extensions

#warning("Вспомни мой доклад и найди здесь ошибку, она у тебя в каждом методе ниже повторяется")
extension UICollectionView {
    
    func register<Cell: UICollectionViewCell>(_: Cell.Type) where Cell: ReusableView & NibLoadableView {
        #warning("В чем смысл NibLoadableView, если ты не вынес в него код для создания ниба? В текущем виде у тебя оба протокола делают одну и ту же работу")
        let bundle = Bundle(for: Cell.self)
        let nib = UINib(nibName: Cell.nibName, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: Cell.reuseID)
    }
        
    func dequeueReusableCell<Cell: UICollectionViewCell>(for indexPath: IndexPath) -> Cell where Cell: ReusableView {
        return dequeueReusableCell(withReuseIdentifier: Cell.reuseID, for: indexPath) as! Cell
    }

}

extension UITableView {
        
    #warning("То, как ты писал констреинты через запятую, - не очень. Можно через такую protocol composition прямо на месте делать ограничение, либо эту же композицию через typealias определить в отдельный псевдотип")
    func register<Cell: UITableViewCell>(_: Cell.Type) where Cell: ReusableView & NibLoadableView {
        let bundle = Bundle(for: Cell.self)
        let nib = UINib(nibName: Cell.nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: Cell.reuseID)
    }
        
    func dequeueReusableCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell where Cell: ReusableView {
        return dequeueReusableCell(withIdentifier: Cell.reuseID, for: indexPath) as! Cell
    }

}
