//
//  TableCellProviding.swift
//  kari-pet-project
//
//  Created by Admin on 12.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol TableCellProviding: class {
    associatedtype DataSource
    associatedtype Delegate
    
    var delegate: Delegate { get set }
    var indexPath: IndexPath! { get set }
    var dataSource: DataSource? { get set }
    
    init(delegate: Delegate)
    
    func getDataSource() -> DataSource?
    func set(dataSource: DataSource)
    func cellForRow(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell
}
