//
//  CatalogCellProvider.swift
//  kari-pet-project
//
//  Created by Admin on 12.08.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

// MARK: - Delegate

// MARK: - Base

final class CatalogCellProvider: TableCellProviding {
    
    typealias Delegate = CatalogCellDelegate
    typealias DataSource = (
        vendorCode: [String],
        images: [String],
        price: [Price],
        name: String,
        color: UIColor,
        title: [String],
        brands: [String],
        fontColor: UIColor,
        ratingCount: [Int],
        rating: [Double],
        colors: [[Colors]?],
        delegate: CatalogCellDelegate)
    typealias Cell = CatalogCell
    
    
    init(delegate: CatalogCellDelegate) {
        self.delegate = delegate
    }
    
    
    var delegate: CatalogCellDelegate
    var dataSource: DataSource?
    var tableView: UITableView?
    var indexPath: IndexPath!
    
    func cellForRow(at indexPath: IndexPath, in tableView: UITableView) -> UITableViewCell {
        self.indexPath = indexPath
        guard let dataSource = dataSource else { return .init(frame: .zero) }
        
        let cell = tableView.dequeueReusableCell(for: indexPath) as CatalogCell
        cell.setup(
            vendorCode: dataSource.vendorCode,
            images: dataSource.images,
            price: dataSource.price,
            name: dataSource.name,
            color: dataSource.color,
            title: dataSource.title,
            brands: dataSource.brands,
            fontColor: dataSource.fontColor,
            ratingCount: dataSource.ratingCount,
            rating: dataSource.rating,
            colors: dataSource.colors,
            delegate: delegate
        )
        return cell
    }
    
    func getDataSource() -> DataSource? { return dataSource }
    func set(dataSource: DataSource) { self.dataSource = dataSource }
    
}
