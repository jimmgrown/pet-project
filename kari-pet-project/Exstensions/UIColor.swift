//
//  UIColor.swift
//  kari-pet-project
//
//  Created by Admin on 26.06.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

#warning("В названии файла не отражен его смысл, нужно назвать типа UIColor+Hex.swift")

#warning("Убирай лишние импорты")
import Foundation
import UIKit

#warning("Пробелы после //")
#warning("Эта внешняя марка тут не нужна")
#warning("Следи за спеллингом, можешь случайно кому-нибудь обломать глобальный поиск по проекту")
//MARK: Exstensions

#warning("Не хватает вертикальных отступов")
extension UIColor {
    convenience init(hexString: String?, alpha: CGFloat = 1.0) {
        
        #warning("Марки внутри тела метода/инита вообще очень редко ставятся, эта уж точно здесь не нужна")
        //MARK: Properties
        
        let hexString: String = hexString?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? "#FFFFFF"
        let scanner = Scanner(string: hexString)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        #warning("Никогда не выравнивай код таким образом, это худший подход")
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        #warning("Пробелов не хватает")
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    #warning("Эта марка тоже тут не нужна, в файлах с экстеншнами существующих классах они вообще редко нужны")
    //MARK: Methods
    
    #warning("Чего не хватает в декларации этого метода?")
    #warning("Зачем вообще этот метод?")
    func toHexString() -> String {
        #warning("Пробелов не хватает во всем методе")
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
