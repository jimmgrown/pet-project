//
//  SliderCellProvider.swift
//  kari-pet-project
//
//  Created by Admin on 12.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

// MARK: - Delegate

protocol SliderCellDelegate: class {}

extension SliderCellDelegate where Self: MainScreenVC {}

// MARK: - Base

final class SliderCellProvider: TableCellProviding {
    
    
    typealias Delegate = SliderCellDelegate
    typealias DataSource = [String]
    typealias Cell = CategoriesCell
    
    
    init(delegate: SliderCellDelegate) {
        self.delegate = delegate
    }
    
    
    var delegate: SliderCellDelegate
    var dataSource: DataSource?
    var tableView: UITableView?
    var indexPath: IndexPath!
    
    func cellForRow(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        self.indexPath = indexPath
        guard let dataSource = dataSource else { return .init(frame: .zero) }
        
        let cell = tableView.dequeueReusableCell(for: indexPath) as SliderCell
        cell.setup(images: dataSource)
        return cell
    }
    
    func getDataSource() -> DataSource? { return dataSource }
    func set(dataSource: DataSource) { self.dataSource = dataSource }
    
    
}
