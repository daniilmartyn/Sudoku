//
//  PuzzleView.swift
//  Sudoku
//
//  Created by Daniil Sergeyevich Martyn on 2/29/16.
//  Copyright © 2016 Daniil Sergeyevich Martyn. All rights reserved.
//

import UIKit

class PuzzleView: UIView {

    var selectedSquare = (row : -1, col : -1)
    
    

    
    func getBoardSquare() -> CGRect {
        let size = min(self.bounds.width, self.bounds.height) - margin/2
        let center = CGPointMake(self.bounds.width/2, self.bounds.height/2)
        return CGRectMake(center.x - size/2, center.y - size/2, size, size)
    }
    
    let margin : CGFloat = 10
    
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        let boardSquare = getBoardSquare()
        
        CGContextSetLineWidth(context, margin)
        UIColor.blackColor().setStroke()
        CGContextStrokeRect(context, boardSquare)
        
        UIColor.yellowColor().setFill()
        let squareSize = boardSquare.size.width / 9
        for r in 0 ..< 9 {
            for c in 0 ..< 9{
                CGContextFillRect(context, CGRectMake(boardSquare.origin.x + CGFloat(c)*squareSize, boardSquare.origin.y + CGFloat(r)*squareSize,
                    squareSize, squareSize))
            }
        }
        
    }
   

}
