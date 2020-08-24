//
//  InfprmationCellProvider.swift
//  kari-pet-project
//
//  Created by Admin on 12.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

// MARK: - Delegate

protocol InformationCellDelegate: class {}

extension InformationCellDelegate where Self: MainScreenVC {}

// MARK: - Base

final class InformationCellProvider: TableCellProviding {
    
    
    typealias Delegate = InformationCellDelegate
    typealias DataSource = [String]
    typealias Cell = InformationCell
    
    
    init(delegate: InformationCellDelegate) {
        self.delegate = delegate
    }
    
    
    var delegate: InformationCellDelegate
    var dataSource: DataSource?
    var tableView: UITableView?
    var indexPath: IndexPath!
    
    func cellForRow(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        self.indexPath = indexPath
        guard let dataSource = dataSource else { return .init(frame: .zero) }
        
        let cell = tableView.dequeueReusableCell(for: indexPath) as InformationCell
        cell.setup(data: dataSource)
        return cell
    }
    
    func getDataSource() -> DataSource? { return dataSource }
    func set(dataSource: DataSource) { self.dataSource = dataSource }
    
}
