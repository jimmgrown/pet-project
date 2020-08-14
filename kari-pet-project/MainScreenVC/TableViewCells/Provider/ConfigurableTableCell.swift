//
//  ConfigurableTableCell.swift
//  kari-pet-project
//
//  Created by Admin on 12.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

protocol ConfigurableTableCell: ReusableCell {
    associatedtype DataSource
    associatedtype Delegate: AnyObject
    
    var dataSource: DataSource! { get set }
    var delegate: Delegate! { get set }
    
    func configureWith(dataSource: DataSource, delegate: Delegate)
}
