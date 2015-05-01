//
//  MWKeyViewer.swift
//  KeyViewer
//
//  Created by MetroWind on 10/20/14.
//  Copyright (c) 2014 MetroWind.
//
//  This work is free. You can redistribute it and/or modify it under the
//  terms of the Do What The Fuck You Want To Public License, Version 2,
//  as published by Sam Hocevar. See the COPYING file for more details.

import Cocoa
import AppKit

let KeyCodes: [UInt16: String] = [
    0x00: "a",
    0x01: "s",
    0x02: "d",
    0x03: "f",
    0x04: "h",
    0x05: "g",
    0x06: "z",
    0x07: "x",
    0x08: "c",
    0x09: "v",
    0x0B: "b",
    0x0C: "q",
    0x0D: "w",
    0x0E: "e",
    0x0F: "r",
    0x10: "y",
    0x11: "t",
    0x12: "1",
    0x13: "2",
    0x14: "3",
    0x15: "4",
    0x16: "6",
    0x17: "5",
    0x18: "=",
    0x19: "9",
    0x1A: "7",
    0x1B: "-",
    0x1C: "8",
    0x1D: "0",
    0x1E: "]",
    0x1F: "o",
    0x20: "u",
    0x21: "[",
    0x22: "i",
    0x23: "p",
    0x25: "l",
    0x26: "j",
    0x27: "'",
    0x28: "k",
    0x29: ";",
    0x2A: "\\",
    0x2B: ",",
    0x2C: "/",
    0x2D: "n",
    0x2E: "m",
    0x2F: ".",
    0x32: "`",
    0x41: "Numpad.",
    0x43: "Numpad*",
    0x45: "Numpad+",
    0x47: "NumpadClear",
    0x4B: "Numpad/",
    0x4C: "Numpad↵",
    0x4E: "Numpad-",
    0x51: "Numpad=",
    0x52: "Numpad0",
    0x53: "Numpad1",
    0x54: "Numpad2",
    0x55: "Numpad3",
    0x56: "Numpad4",
    0x57: "Numpad5",
    0x58: "Numpad6",
    0x59: "Numpad7",
    0x5B: "Numpad8",
    0x5C: "Numpad9",
    0x24: "↵",
    0x30: "⇥",
    0x31: "␣",
    0x33: "⌫",
    0x35: "⎋",
    0x37: "⌘",
    0x38: "⇧",
    0x39: "⇪",
    0x3A: "⌥",
    0x3B: "⌃",
    0x3C: "Right⇧",
    0x3D: "Right⌥",
    0x3E: "Right⌃",
    0x3F: "Fn",
    0x40: "F17",
    0x48: "🔊",
    0x49: "🔉",
    0x4A: "🔇",
    0x4F: "F18",
    0x50: "F19",
    0x5A: "F20",
    0x60: "F5",
    0x61: "F6",
    0x62: "F7",
    0x63: "F3",
    0x64: "F8",
    0x65: "F9",
    0x67: "F11",
    0x69: "F13",
    0x6A: "F16",
    0x6B: "F14",
    0x6D: "F10",
    0x6F: "F12",
    0x71: "F15",
    0x72: "Help",
    0x73: "↖",
    0x74: "⇞",
    0x75: "⌦",
    0x76: "F4",
    0x77: "↘",
    0x78: "F2",
    0x79: "⇟",
    0x7A: "F1",
    0x7B: "←",
    0x7C: "→",
    0x7D: "↓",
    0x7E: "↑",
]

struct KeyboardKey: Printable
{
    var Modifiers: NSEventModifierFlags = NSEventModifierFlags(0)
    var KeyCode: UInt16 = 0

    init(){}
    init(keyCode key_code: UInt16, modifiers mods: NSEventModifierFlags)
    {
        Modifiers = mods
        KeyCode = key_code
    }
    
    func toString() -> String
    {
        var StrMod: String = ""
        if (Modifiers & NSEventModifierFlags.CommandKeyMask).rawValue > 0
        {
            StrMod += "⌘"
        }
        if (Modifiers & NSEventModifierFlags.ControlKeyMask).rawValue > 0
        {
            StrMod += "⌃"
        }
        if (Modifiers & NSEventModifierFlags.AlternateKeyMask).rawValue > 0
        {
            StrMod += "⌥"
        }
        if (Modifiers & NSEventModifierFlags.ShiftKeyMask).rawValue > 0
        {
            StrMod += "⇧"
        }
        
        let StrKey: String = KeyCodes[KeyCode]!
        return StrMod + StrKey
    }
    
    var description: String {
        return toString()
    }
}

class MWKeyViewer: NSTextField, NSTextFieldDelegate
{
    // ========== User stuff ================================================>
    // This is read-only!! Use setKey().
    var Key: KeyboardKey = KeyboardKey()
    
    func clear()
    {
        Key = KeyboardKey()
        stringValue = ""
    }
    
    func setKey(key: KeyboardKey)
    {
        Key = key
        stringValue = Key.toString()
    }

    // ======================================================================>
    var Monitor: AnyObject? = nil
    
    override init(frame frameRect: NSRect)
    {
        super.init(frame: frameRect)
        self.initialize()
    }

    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        self.initialize()
    }
    
    func initialize()
    {
        delegate = self
        allowsEditingTextAttributes = false
        alignment = .CenterTextAlignment
    }
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }

    func onKeyPress(event: NSEvent)
    {
        println(event.keyCode)

        Key.KeyCode = event.keyCode
        Key.Modifiers = event.modifierFlags
        
        println("Key: \(Key), code: \(Key.KeyCode)")

        stringValue = Key.toString()
    }
    
    override func performKeyEquivalent(theEvent: NSEvent) -> Bool
    {
        return (Monitor != nil)
    }
    
    override func becomeFirstResponder() -> Bool
    {
        let CanI = super.becomeFirstResponder()
        if CanI
        {
            Monitor = NSEvent.addLocalMonitorForEventsMatchingMask(NSEventMask.KeyUpMask, handler: { (event: NSEvent!) -> NSEvent! in
                self.onKeyPress(event)
                return nil
            })
        }
        return CanI
    }

// For some reason this is not called when losing focus.
//    override func resignFirstResponder() -> Bool
//    {
//        println("About to loose it.")
//        let CanI = super.resignFirstResponder()
//        if (CanI && Monitor != nil)
//        {
//            println("Lost it...")
//            NSEvent.removeMonitor(Monitor!)
//            Monitor = nil
//        }
//        return CanI
//    }
    
    override func controlTextDidEndEditing(obj: NSNotification)
    {
        if Monitor != nil
        {
            NSEvent.removeMonitor(Monitor!)
            Monitor = nil
        }
    }
    
    // Usually pressing return will end editing for a text field.  This prevents that.
    func control(control: NSControl, textView: NSTextView, doCommandBySelector commandSelector: Selector) -> Bool
    {
        if commandSelector == "insertNewline:"
        {
            return true
        }
        return false
    }
}
