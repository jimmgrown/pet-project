//
//  AnyTableCellProviding.swift
//  kari-pet-project
//
//  Created by Admin on 12.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

// MARK: - Declaration

final class AnyTableCellProvider {
    
    // MARK: Private properties
    
    private let _getDataSource: () -> Any
    private let _setDataSource: (Any) -> Void
    private let _cellForRowInTableView: (IndexPath, UITableView) -> UITableViewCell
    
    // MARK: Public properties
    
    var dataSource: Any {
        get { return _getDataSource() }
        set { _setDataSource(newValue) }
    }
    
    // MARK: Initialization
    
    init<CDP: TableCellProviding>(_ cdp: CDP) {
        _getDataSource = cdp.getDataSource
        _setDataSource = { cdp.set(dataSource: $0 as! CDP.DataSource) }
        _cellForRowInTableView = cdp.cellForRow(at:in:)
    }
    
}


// MARK: - Public API

extension AnyTableCellProvider {
    
    func getDataSource<DS>() -> DS { return _getDataSource() as! DS }
    func set<DS>(dataSource: DS) { _setDataSource(dataSource) }
    func cellForRow(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell { return _cellForRowInTableView(indexPath, tableView) }
}
