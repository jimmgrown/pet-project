//
//  mainScreenViewController.swift
//  kari-pet-project
//
//  Created by Admin on 16.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

#warning("Название файла и объекта с маленькой буквы недопустимо")

import UIKit

class mainScreenViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var result = Response(blocks: [Block]()){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //    var x = 1
    let infiniteSize = 10000000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SliderTableViewCell.self, forCellReuseIdentifier: "sliderTableCell")
        tableView.dataSource = self
        //collectionView.delegate = self
        //categoryCollectionView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        #warning("Зачем тут weak self?")
        API.loadJSON { [weak self] result in
            #warning("Что за рандом с опшналами (? и !) ?")
            self?.result=result
            #warning("Зачем здесь дополнительный reload")
            self!.tableView.reloadData()
        }
    }
}

extension mainScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SliderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "sliderTableCell", for: indexPath) as! SliderTableViewCell
        #warning("Это условие не делает абсолютно ничго")
        if self.result.blocks.count > 0 {
            cell.setup(response: self.result)
        }
        return cell
    }
}

#warning("В сториборде у тебя какие-то странные вещи с размерами контроллеров творятся. Лишнее оттуда можешь удалять, предыдущая реализация точно нигде не понадобится")
