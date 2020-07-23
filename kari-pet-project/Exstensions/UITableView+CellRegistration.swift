//
//  ReusableView.swift
//  kari-pet-project
//
//  Created by Admin on 07.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

// MARK: - Auxiliary

typealias ReusableCell = ReusableView & NibLoadableView

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
    static var bundle: Bundle { get }
    static var nib: UINib { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
    static var bundle: Bundle {
        return Bundle(for: Self.self)
    }
    static var nib: UINib {
        return UINib(nibName: Self.nibName, bundle: bundle)
    }
}

// MARK: - UICollectionView

extension UICollectionView {
    
    final func register<Cell: UICollectionViewCell>(_: Cell.Type) where Cell: ReusableCell {
        register(Cell.nib, forCellWithReuseIdentifier: Cell.reuseID)
    }
    
    final func dequeueReusableCell<Cell: UICollectionViewCell>(
        for indexPath: IndexPath
    ) -> Cell where Cell: ReusableView {
        return dequeueReusableCell(withReuseIdentifier: Cell.reuseID, for: indexPath) as! Cell
    }
    
}

// MARK: - UITableView

extension UITableView {
    
    final func register<Cell: UITableViewCell>(_: Cell.Type) where Cell: ReusableCell {
        register(Cell.nib, forCellReuseIdentifier: Cell.reuseID)
    }
        
    final func dequeueReusableCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell where Cell: ReusableView {
        return dequeueReusableCell(withIdentifier: Cell.reuseID, for: indexPath) as! Cell
    }

}
