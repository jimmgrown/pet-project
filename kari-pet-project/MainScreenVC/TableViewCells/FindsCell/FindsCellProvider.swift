//
//  FindsCellProvider.swift
//  kari-pet-project
//
//  Created by Admin on 12.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

// MARK: - Delegate

protocol FindsCellDelegate: class {}

extension FindsCellDelegate where Self: MainScreenVC {}

// MARK: - Base

final class FindsCellProvider: TableCellProviding {
    
    
    typealias Delegate = FindsCellDelegate
    typealias DataSource = [String]
    typealias Cell = FindsCell
    
    
    init(delegate: FindsCellDelegate) {
        self.delegate = delegate
    }
    
    
    var delegate: FindsCellDelegate
    var dataSource: DataSource?
    var tableView: UITableView?
    var indexPath: IndexPath!
    
    func cellForRow(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        self.indexPath = indexPath
        guard let dataSource = dataSource else { return .init(frame: .zero) }
        
        let cell = tableView.dequeueReusableCell(for: indexPath) as FindsCell
        cell.setup(images: dataSource)
        return cell
    }
    
    func getDataSource() -> DataSource? { return dataSource }
    func set(dataSource: DataSource) { self.dataSource = dataSource }
    
}
