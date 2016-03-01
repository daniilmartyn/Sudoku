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
    
    func tap(sender : UITapGestureRecognizer) {
        let location = sender.locationInView(self)
        let boardSquare = getBoardSquare()
        
        if (CGRectContainsPoint(boardSquare, location)) {
            let squareSize = boardSquare.size.width/9
            let col = Int((location.x - boardSquare.origin.x)/squareSize)
            let row = Int((location.y - boardSquare.origin.y)/squareSize)
            if (0 ..< 9) ~= col && (0 ..< 9) ~= row {
                if row != selectedSquare.row || col != selectedSquare.col {
                    selectedSquare.col = col
                    selectedSquare.row = row
                    self.setNeedsDisplay()
                }
            }
        }
        NSLog("tap \(selectedSquare)")

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("tap:"))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("tap:"))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func getBoardSquare() -> CGRect {
        let size = min(self.bounds.width, self.bounds.height) - margin/2
        let center = CGPointMake(self.bounds.width/2, self.bounds.height/2)
        return CGRectMake(center.x - size/2, center.y - size/2, size, size)
    }
    
    let margin : CGFloat = 6
    
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        let boardSquare = getBoardSquare()
        
        CGContextSetLineWidth(context, margin)
        UIColor.blackColor().setStroke()
        
        let bigSquareSize = boardSquare.size.width / 3
        let squareSize = boardSquare.size.width / 9
        
        if (selectedSquare.row >= 0 && selectedSquare.col >= 0) {
            UIColor.yellowColor().setFill()
            let x = boardSquare.origin.x + CGFloat(selectedSquare.col)*squareSize
            let y = boardSquare.origin.y + CGFloat(selectedSquare.row)*squareSize
            CGContextFillRect(context, CGRectMake(x, y, squareSize, squareSize))
        }

        for r in 0 ..< 3 {
            for c in 0 ..< 3 {
                CGContextStrokeRect(context, CGRectMake(boardSquare.origin.x + CGFloat(c) * bigSquareSize,
                    boardSquare.origin.y + CGFloat(r) * bigSquareSize,
                    bigSquareSize,
                    bigSquareSize))
            }
        }
        
        CGContextSetLineWidth(context, margin/2)
        for r in 0 ..< 9 {
            for c in 0 ..< 9{
                CGContextStrokeRect(context, CGRectMake(boardSquare.origin.x + CGFloat(c)*squareSize,
                    boardSquare.origin.y + CGFloat(r)*squareSize,
                    squareSize,
                    squareSize))
            }
        }
        
    }
   

}
