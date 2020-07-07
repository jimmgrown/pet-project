//
//  ReusableView.swift
//  kari-pet-project
//
//  Created by Admin on 07.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Protocols

protocol ReusableView: class {
    static var reuseID: String { get }
}

protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension ReusableView where Self: UIView {

    static var reuseID: String {
        return String(describing: self)
    }

}   

extension NibLoadableView where Self: UIView {

    static var nibName: String {
        return String(describing: self)
    }

}

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
        
    func register<Cell: UITableViewCell>(_: Cell.Type) where Cell: ReusableView & NibLoadableView {
        let bundle = Bundle(for: Cell.self)
        let nib = UINib(nibName: Cell.nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: Cell.reuseID)
    }
        
    func dequeueReusableCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell where Cell: ReusableView {
        return dequeueReusableCell(withIdentifier: Cell.reuseID, for: indexPath) as! Cell
    }

}
