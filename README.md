# KeyViewer

![Screenshot](https://github.com/Corsair/KeyViewer/raw/master/screenshot.png)

A simple control to simply store and display a simple keyboard
shortcut.

Years ago I’ve had the need to have a control to display a keyboard
shortcut that I pressed.  There are a bunch of such controls exist on
the web, most of which (if not all) are not updated.  And for some
reason all of them are quite complicated, despite the simple task they
achieve; all of them provide APIs to bind global shortcuts, which is
useful, but I already have code to do.  Some of them also
over-engineer it to provide fancy APIs, so fancy that my eyeballs
explode.

To protect my eyes, I’ve written this simple `NSTextField` subclass.
The Swift file is less than 300 lines, of which 100 are for keycode
definitions.

## How to use

The Xcode project is for an example app.  You need only
`MWKeyViewer.swift` for your own project.  Copy the file to your
project directory, add a `NSTextField` to your storyboard, and change
its class to `MWKeyViewer`, make appropriate `IBoutlet` connections,
and you are done.

The `MWKeyViewer` class provides 2 methods...

  - `clear()`: Clear the textfield, and the stored shortcut.
  - `setKey()`: Set the stored shortcut to the argument, and update the
    textfield.

... and a variable `Key` which stores the shortcut, and is supposedly
read-only.

The shortcut is stored in `KeyboardKey` struct, which provides 2
variables:

  - `Modifiers: NSEventModifierFlags`: Stores the modifiers of the
    shortcut
  - `KeyCode: UInt16`: Stores the virtual keycode.

Definitions of these variables coincide with those in
[`NSEvent`](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/ApplicationKit/Classes/NSEvent_Class/).

...
...
...

Actually just read the code.  It should be self-explanatory.
