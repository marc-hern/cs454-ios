//
//  ViewController.swift
//  ColorMaker
//
//  Created by Marcus Hernandez on 7/1/2016.
//
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redControl: UISwitch!
    @IBOutlet weak var greenControl: UISwitch!
    @IBOutlet weak var blueControl: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set colorView on launch
        changeColorComponent()
    }
    
    @IBAction func changeColorComponent() {
        
        // Make sure the program doesn't crash if the controls aren't connected
        if self.redControl == nil {
            return
        }
        
        let r: CGFloat = self.redControl.on ? 1 : 0
        let g: CGFloat = self.greenControl.on ? 1 : 0
        let b: CGFloat = self.blueControl.on ? 1 : 0
                
        colorView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
    }
}

