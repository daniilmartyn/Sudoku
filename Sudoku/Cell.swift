//
//  Cell.swift
//  Sudoku
//
//  Created by Daniil Sergeyevich Martyn on 3/4/16.
//  Copyright © 2016 Daniil Sergeyevich Martyn. All rights reserved.
//

import Foundation

class Cell {
    var number : Int
    var fixed : Bool
    var pencils : [Bool]
    
    init(fromPuzzle num : Int = 0, fix : Bool = false){
        number = num
        fixed = fix
        pencils = [false,false,false,
                    false,false,false,
                    false,false,false]
    }
}