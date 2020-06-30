//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Atakan Çavuşlu on 29/06/2020.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var characterIndex = 0.0
        let titleText = "⚡️FlashChat"
        titleLabel.text = ""
        
        for letter in titleText {
            
            Timer.scheduledTimer(withTimeInterval: 0.1 * characterIndex, repeats: false) { (timer) in
                self.titleLabel.text?.append(letter)
                
            }
            characterIndex += 1
        
        }
        
    }
    

}
