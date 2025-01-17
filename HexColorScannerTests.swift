//
//
//  HexColorScannerTests.swift
//  C4rk
//
// Copyright (c) 2021 Harlan Kellaway
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
//

import C4rk
import XCTest

class HexColorScannerTests: XCTestCase {
    
    var sut: HexColorScanner!
    
    override func setUp() {
        super.setUp()
        
        sut = Scanner()
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
    }
    
    func test_validHexString_withHashMark_returnsRGBA() {
        let string = "#C4ABCD"
        XCTAssert(rgbEqual(lhs: try! sut.rgba(fromHex: string).get(),
                           rhs: (196, 171, 205, 1)))
    }
    
    func test_validHexString_withoutHashMark_returnsRGBA() {
        let string = "C4ABCD"
        XCTAssert(rgbEqual(lhs: try! sut.rgba(fromHex: string).get(),
                           rhs: (196, 171, 205, 1)))
    }
    
    func test_validHexString_withAlpha_returnsRGBA() {
        let string = "C4ABCD"
        let alpha: CGFloat = 0.12345
        XCTAssert(rgbEqual(lhs: try! sut.rgba(fromHex: string, alpha: alpha).get(),
                           rhs: (196, 171, 205, alpha)))
    }
    
    func test_invalidHexString_isFailure() {
        let invalidString = "-1"
        XCTAssert(sut.rgba(fromHex: invalidString).isFailure)
    }
    
}
