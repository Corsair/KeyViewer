//
//  ViewController.swift
//  KeyViewer
//
//  Created by Darksair Sun on 10/20/14.
//  Copyright (c) 2014 Darksair. All rights reserved.
//

import Cocoa
import AppKit

class ViewController: NSViewController {
    
    @IBOutlet var KeyViewer: MWKeyViewer!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var NewKey = KeyboardKey(keyCode: 12, modifiers: NSEventModifierFlags.CommandKeyMask)
        KeyViewer.setKey(NewKey)
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}