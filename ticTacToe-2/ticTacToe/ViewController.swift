//
//  ViewController.swift
//  ticTacToe
//
//  Created by Connor Pan on 7/2/15.
//  Copyright © 2015 Connor Pan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelTopLeft: gridLabel! //0
    @IBOutlet weak var labelTopMid: gridLabel! //1
    @IBOutlet weak var labelTopRight: gridLabel!  //2
    
    @IBOutlet weak var labelMidLeft: gridLabel! //3
    @IBOutlet weak var labelMidMid: gridLabel! //4
    @IBOutlet weak var labelMidRight: gridLabel! //5
    
    @IBOutlet weak var labelBotLeft: gridLabel! //6
    @IBOutlet weak var labelBotMid: gridLabel! //7
    @IBOutlet weak var labelBotRight: gridLabel! //8
    
    var labelsArray :[gridLabel!] = []
    var otherArray = [Int:gridLabel]()
    var turn = 0
    var didIntercept = false
    @IBOutlet weak var playAreaView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelsArray = [labelTopLeft,labelTopMid,labelTopRight,labelMidLeft,labelMidMid,labelMidRight,labelBotLeft,labelBotMid,labelBotRight]
    }
    
    @IBAction func onScreenWasTapped(sender: UITapGestureRecognizer) {
        for label in labelsArray {
            
            if CGRectContainsPoint(label.frame, sender.locationInView(playAreaView)){
                
                if label.text != "X" && label.text != "O" {
                    if turn % 2 == 0 {
                        label.text = "X"
                        //AiMove()
                        checkforWinner()
                        turn++
                    } else {
                        label.text = "O"
                        checkforWinner()
                        turn++
                    }
                }
            }
        }
    }
    func AiMove(){
        
        var pos = Int(arc4random_uniform(UInt32(labelsArray.count-1)))
        
       // checkForTwo(0, count: 1)
        
        if !didIntercept {
        while (labelsArray[pos].text != "") && (turn < 8) {
            pos = Int(arc4random_uniform(UInt32(labelsArray.count-1)))
        }
        
        labelsArray[pos].text = "O"
        }
        turn++
        
    }
    func reset(){
        for i in 0...labelsArray.count-1
        {
            labelsArray[i].text = ""
        }
        turn = -1
    }
    
    func checkforWinner() {
     
        
        var i = 0
        while i <= 6 {
            //ROW 1
            checkText(i, increment: 1, letter: "X")
            checkText(i, increment: 1, letter: "O")
            
            i+=3
        }
        for i in 0...2 {
            checkText(i, increment: 3, letter: "X")
            checkText(i, increment: 3, letter: "O")
        }
     /*
        var j = 0
        while j <= 2 {
            
            checkText(i, increment: 4, letter: "X")
            checkText(i, increment: 4, letter: "O")
            j+=2
        }
        
       */
    }
    
    func checkForTwo(startingPosition:Int, count:Int) {
        if (labelsArray[startingPosition].text == "X" && labelsArray[startingPosition+count].text == "X") {
             labelsArray[startingPosition+(count+count)].text = "O"
        }
        if (labelsArray[startingPosition+count].text == "X" && labelsArray[startingPosition+(count+count)].text == "X") {
            labelsArray[startingPosition].text = "O"
        }
    }
    func checkText(num1: Int, increment: Int, letter: String){
        
        if (labelsArray[num1].text == letter && labelsArray[num1+increment].text == letter && labelsArray[num1+(increment+increment)].text == letter) {
            print("\(letter) wins")
            reset()
        }
    }
}
    


