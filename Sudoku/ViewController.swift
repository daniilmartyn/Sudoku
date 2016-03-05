//
//  ViewController.swift
//  Sudoku
//
//  Created by Daniil Sergeyevich Martyn on 2/29/16.
//  Copyright © 2016 Daniil Sergeyevich Martyn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var puzzleView: PuzzleView!
    @IBOutlet weak var buttonsView: ButtonsView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func numberButtonTapped(sender: UIButton) {
        NSLog("Button \(sender.tag) pressed")
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let puzzle = appDelegate.sudoku
        
        if(pencilEnabeled){
            if(puzzle!.numberAtRow(puzzleView.selectedSquare.row, column: puzzleView.selectedSquare.col) == 0){
            if(puzzle!.isSetPencil(sender.tag - 1 , row: puzzleView.selectedSquare.row, column: puzzleView.selectedSquare.col)){
                puzzle!.clearPencil(sender.tag - 1, row: puzzleView.selectedSquare.row, column: puzzleView.selectedSquare.col)
            }else{
                puzzle!.setPencil(sender.tag - 1, row: puzzleView.selectedSquare.row, column: puzzleView.selectedSquare.col)
            }
            }
            self.puzzleView.setNeedsDisplay()
        }else {
            if(!puzzle!.anyPencilSetAtRow(puzzleView.selectedSquare.row, column: puzzleView.selectedSquare.col)){
                puzzle?.setNumber(sender.tag, row: puzzleView.selectedSquare.row, column: puzzleView.selectedSquare.col)
                self.puzzleView.setNeedsDisplay()
            }
        }
        
        if (puzzle!.isSolved()) {
            let alert = UIAlertController(title: "YOU WON!", message: "Yes, you really did.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    @IBAction func eraseButtonTapped(sender: AnyObject) {
        
        NSLog("Erase Button Tapped")
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let puzzle = appDelegate.sudoku
        
        if(pencilEnabeled){
            puzzle!.clearAllPencils(puzzleView.selectedSquare.row, column: puzzleView.selectedSquare.col)
            self.puzzleView.setNeedsDisplay()
        }else{
            if(!puzzle!.anyPencilSetAtRow(puzzleView.selectedSquare.row, column: puzzleView.selectedSquare.col)){
                puzzle?.setNumber(0, row: puzzleView.selectedSquare.row, column: puzzleView.selectedSquare.col)
                self.puzzleView.setNeedsDisplay()
            }
        }
    }
    
    
    var pencilEnabeled : Bool = false   // controller property
    @IBAction func pencilButtonPressed(sender: UIButton) {
        pencilEnabeled = !pencilEnabeled    // toggle
        sender.selected = pencilEnabeled
        NSLog("is pencil selected? \(pencilEnabeled)")
        if pencilEnabeled {
            sender.backgroundColor = UIColor(red: 255.0, green: 255.0, blue: 0.0, alpha: 1.0)
        }else{
            sender.backgroundColor = UIColor(red: 237/255.0, green: 218/255.0, blue: 167/255.0, alpha: 1.0)
        }
    }

    @IBAction func menuButtonPressed(sender: AnyObject) {
         let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
         let puzzle = appDelegate.sudoku
        
        
        let alertController = UIAlertController(
            title: "Main Menu",
            message: nil,
            preferredStyle: .ActionSheet)
        
        alertController.addAction(UIAlertAction(
            title: "Cancel",
            style: .Cancel,
            handler: nil))
        alertController.addAction(UIAlertAction(
            title: "New Easy Game",
            style: .Default,
            handler: {(UIAlertAction) -> Void in
                let puzzleStr = self.randomPuzzle(appDelegate.simplePuzzles)
                puzzle!.loadPuzzle(puzzleStr)
                self.puzzleView.setNeedsDisplay()}))
        alertController.addAction(UIAlertAction(
            title: "New Hard Game",
            style: .Default,
            handler: {(UIAlertAction) -> Void in
                let puzzleStr = self.randomPuzzle(appDelegate.hardPuzzles)
                puzzle!.loadPuzzle(puzzleStr)
                self.puzzleView.setNeedsDisplay()}))
        alertController.addAction(UIAlertAction(
            title: "Clear Conflicting Cells",
            style: .Default,
            handler: {(UIAlertAction) -> Void in
                puzzle!.clearConflictingCells()
                self.puzzleView.setNeedsDisplay()}))
        alertController.addAction(UIAlertAction(
            title: "Clear All Cells",
            style: .Default,
            handler: {(UIAlertAction) -> Void in
                puzzle!.clearAllCells()
                self.puzzleView.setNeedsDisplay()}))

        
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
            let popoverPresenter = alertController.popoverPresentationController
            let menuButtonTag = 12
            let menuButton = buttonsView.viewWithTag(menuButtonTag)
            popoverPresenter?.sourceView = menuButton
            popoverPresenter?.sourceRect = (menuButton?.bounds)!
        }
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func randomPuzzle(list : [String]) -> String {
        return list[Int(arc4random_uniform(UInt32(list.count)))]
    }
}

