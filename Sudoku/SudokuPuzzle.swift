//
//  SudokuPuzzle.swift
//  Sudoku
//
//  Created by Daniil Sergeyevich Martyn on 3/2/16.
//  Copyright © 2016 Daniil Sergeyevich Martyn. All rights reserved.
//

import Foundation

func getPuzzles(name : String) -> [String] {
    let path = NSBundle.mainBundle().pathForResource(name, ofType: "plist")
    let array = NSArray(contentsOfFile: path!)
    return array as! [String]
}

class SudokuPuzzle {
    
    var puzzle = [[Cell]]()
    
    init(){
        
        for _ in 0 ..< 9 {
            var subArray = [Cell]()
            for _ in 0 ..< 9{
                subArray.append(Cell())
            }
            puzzle.append(subArray)
        }
    }
    
    
    func savedState() -> NSArray{
    
        var archive : [[String : [Int]]] = []
        
        var cell : [String : [Int]] = [:]

        
        for i in 0 ..< 9{
            for j in 0 ..< 9{
                cell["number"] = [puzzle[i][j].number]
                
                if(puzzle[i][j].fixed){
                    cell["fixed"] = [1]
                }else{
                    cell["fixed"] = [0]
                }
                
                var pencils : [Int] = []
                
                for k in 0 ..< 9 {
                    
                    if puzzle[i][j].pencils[k] {
                        pencils.append(1)
                    }else {
                        pencils.append(0)
                    }
                    
                }
                
                cell["pencils"] = pencils
                
                archive.append(cell)
            }
        }
        
        
        
        return archive
    }
    
    func setState(puzzleArray : NSArray) {
    
        var cell : [String : [Int]] = [:]
        
        var count : Int = 0
        
        for i in 0 ..< 9 {
            for j in 0 ..< 9{
                
                cell = puzzleArray[count] as! [String : [Int]]
                puzzle[i][j].number = cell["number"]![0]
                
                if(cell["fixed"]![0] == 1){
                    puzzle[i][j].fixed = true
                }else{
                    puzzle[i][j].fixed = false
                }
                
                
                for k in 0 ..< 9 {
                    if (cell["pencils"]![k] == 1){
                        puzzle[i][j].pencils[k] = true
                    }else{
                        puzzle[i][j].pencils[k] = false
                    }
                }
                
                count++
            }
        }
        
        
    }
    
    func loadPuzzle(puzzleString: String) {
        
        var arrayOfInts = [Int]()
        
        for ch in puzzleString.characters {
            if ch == "." {
                arrayOfInts.append(0)
            }else{
                let s = String(ch)
                let d = Int(s)
                arrayOfInts.append(d!)
            }
        }
        
        var i = 0
        for row in 0 ..< 9 {
            for col in 0 ..< 9 {
                if arrayOfInts[i] == 0{
                    puzzle[row][col].number = arrayOfInts[i]
                    puzzle[row][col].fixed = false
                    i++
                }else{
                    puzzle[row][col].number = arrayOfInts[i]
                    puzzle[row][col].fixed = true
                    i++
                }
            }
        }
        
    }
    
    func numberAtRow(row: Int, column: Int) -> Int {
        return puzzle[row][column].number
    }
    
    func setNumber(number: Int, row: Int, column: Int){
        puzzle[row][column].number = number
    }
    
    func numberIsFixed(row: Int, column: Int) -> Bool {
        return puzzle[row][column].fixed
    }
    
    func isConflictingEntryAtRow(row: Int, column: Int) -> Bool {
        
        let num = puzzle[row][column].number
        
        for i in 0 ..< 9 {          // check for conflicting number in row
            if puzzle[row][i].number == num {
                if (i == column){
                    continue
                }else{
                    return true
                }
            }
        }
        
        for i in 0 ..< 9 {          // check for conflicting number in column
            if puzzle[i][column].number == num {
                if (i == row){
                    continue
                }else{
                    return true
                }
            }
        }
        
        let blockR = row/3 * 3
        let blockC = column/3 * 3
        
        for i in blockR ..< (blockR + 3){
            for j in blockC ..< (blockC + 3){
                if (puzzle[i][j].number == num){
                    if i == row && j == column {
                        continue
                    }else {
                        return true
                    }
                }
            }
        }
        
        return false
    }
    
    func anyPencilSetAtRow(row: Int, column: Int) -> Bool {
        for i in 0 ..< 9 {
            if (puzzle[row][column].pencils[i]) {
                return true
            }
        }
        return false
    }
    
    func numberOfPencilsSetAtRow(row: Int, column: Int) -> Int {
        var numSetPencils = 0
        
        for i in 0 ..< 9 {
            if (puzzle[row][column].pencils[i]) {
                numSetPencils++
            }
        }
        
        return numSetPencils
    }
    
    func isSetPencil(n: Int, row: Int, column: Int) -> Bool {
        return puzzle[row][column].pencils[n]
    }
    
    func setPencil(n: Int, row: Int, column: Int) {
        puzzle[row][column].pencils[n] = true
    }
    
    func clearPencil(n: Int, row: Int, column: Int){
        puzzle[row][column].pencils[n] = false
    }
    
    func clearAllPencils(row: Int, column: Int) {
        for i in 0 ..< 9 {
            puzzle[row][column].pencils[i] = false
        }
    }
    
    func clearAllCells(){
        for i in 0 ..< 9 {
            for j in 0 ..< 9{
                if !puzzle[i][j].fixed {
                    puzzle[i][j].number = 0
                    
                    for k in 0 ..< 9 {
                        puzzle[i][j].pencils[k] = false
                    }
                }
            }
        }
    }
    
    func clearConflictingCells(){
        for i in 0 ..< 9 {
            for j in 0 ..< 9{
                if !puzzle[i][j].fixed && self.isConflictingEntryAtRow(i, column: j){
                    puzzle[i][j].number = 0
                }
            }
        }
    }
    
    func isSolved() -> Bool{
        for i in 0 ..< 9 {
            for j in 0 ..< 9{
                if puzzle[i][j].number == 0{
                    return false
                }
            }
        }
        
        for i in 0 ..< 9 {
            for j in 0 ..< 9{
                if self.isConflictingEntryAtRow(i, column: j){
                    return false
                }
            }
        }
        
        return true
    }
}



