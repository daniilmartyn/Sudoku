//
//  ViewController.swift
//  Sudoku
//
//  Created by Daniil Sergeyevich Martyn on 2/29/16.
//  Copyright © 2016 Daniil Sergeyevich Martyn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
    }
    @IBAction func eraseButtonTapped(sender: AnyObject) {
        
        NSLog("Erase Button Tapped")
    }
    
    
    var pencilEnabeled : Bool = false   // controller property
    @IBAction func pencilButtonPressed(sender: UIButton) {
        pencilEnabeled = !pencilEnabeled    // toggle
        sender.selected = pencilEnabeled
    }

    @IBAction func menuButtonPressed(sender: AnyObject) {
        // let _ = UIApplication.sharedApplication().delegate as! AppDelegate
        // let puzzle = appDelegate.sudoku        /// XXXXXXXX
        //      
        //
        //
        //
        
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
            handler: nil))  ///////////////////////////////////change this to correct set up later
        alertController.addAction(UIAlertAction(
            title: "New Hard Game",
            style: .Default,
            handler: nil))  ///////////////////////////////////change this to correct set up later
        alertController.addAction(UIAlertAction(
            title: "Clear Conflicting Cells",
            style: .Default,
            handler: nil))  ///////////////////////////////////change this to correct set up later
        alertController.addAction(UIAlertAction(
            title: "Clear All Cells",
            style: .Default,
            handler: nil))  ///////////////////////////////////change this to correct set up later

        
//        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
//            let popoverPresenter = alertController.popoverPresentationController
//            let menuButtonTag = 12
//            let menuButton = buttonsView.viewWithTag(menuButtonTag)
//            popoverPresenter?.sourceView = menuButton
//            popoverPresenter?.sourceRect = (menuButton?.bounds)!
//        }
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}

