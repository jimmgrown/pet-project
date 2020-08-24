//
//  CategoriesCellProvider.swift
//  kari-pet-project
//
//  Created by Admin on 12.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

// MARK: - Delegate

protocol CategoriesCellDelegate: class {}

extension CategoriesCellDelegate where Self: MainScreenVC {}

// MARK: - Base

final class CategoriesCellProvider: TableCellProviding {
    
    
    typealias Delegate = CategoriesCellDelegate
    typealias DataSource = [[String]]
    typealias Cell = CategoriesCell
    
    
    init(delegate: CategoriesCellDelegate) {
        self.delegate = delegate
    }
    
    
    var delegate: CategoriesCellDelegate
    var dataSource: DataSource?
    var tableView: UITableView?
    var indexPath: IndexPath!
    
    func cellForRow(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        self.indexPath = indexPath
        guard let dataSource = dataSource else { return .init(frame: .zero) }
        
        let cell = tableView.dequeueReusableCell(for: indexPath) as CategoriesCell
        cell.setup(data: dataSource)
        return cell
    }
    
    func getDataSource() -> DataSource? { return dataSource }
    func set(dataSource: DataSource) { self.dataSource = dataSource }
    
}
