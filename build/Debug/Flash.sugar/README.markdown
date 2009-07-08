# ActionScript 3 Sugar 0.6.0
> Updated 4/27/2009

## Description

An Espresso Sugar for ActionScript 3 development:

* Syntax Highlighting, Code Completion for many of the classes and reserved words
* Includes classes from the packages: flash, fl, adobe and air
* Compilation using Flex 3 SDK, Flash CS3/CS4
* Support for Flash and Flex stynaxes

## NEW!

* Documentation window added. Actions -> AS3 -> Documentation or cmd + shift + d
* Fixed compilation support. Actions -> AS3 -> Build or cmd + enter
* Now You can choose the compiler you want to use after the compiler window launches.

## Instructions

### Installing Sugar

* From Source
** Download source, compile with XCode, start Espresso.
* RCompiled Version
** Download, double click, start Espresso.

### Configuring Compilers

* Extract Flex 3 SDK to /Developer/SDKs/ as flex_sdk_3
* Support for CS3 and CS4 built in VIA flashcommand by Mike Chambers (Modified to work with CS4)

## Useage

* While editing an *.as hit cmd + enter or Action -> AS3 -> Build from the menu to build the file.
* If you have Flash CS3 / CS4 installed and you have a *.fla file with the same name as the .*as file, it will instead be compiled with Flash SCS4
** (i.e.) Main.as + Main.fla = Flash CS3 / CS4 compile with build command. Main.as alone = MXMLC compile.

## Bugs / Issues!!

* Still buggy so use at your own risk!
* Itemizers get confused when multiple curly-brackets are used, usually when creating objects.

## Other Info

* Grabbed a lot of parts from the PHP sugar included with Espresso. Thanks.

## License

ActionScript3 Sugar is licensed under the MIT License Below

FlashCommand and this the <ActionScript 3 Sugar> is under MIT License:

The MIT License

Copyright (c) 2009 Mike Murray

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

Using FamFamFam Silk Icons: http://www.famfamfam.com/lab/icons/silk/
