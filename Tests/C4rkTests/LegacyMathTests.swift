// Copyright © 2014 C4
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions: The above copyright
// notice and this permission notice shall be included in all copies or
// substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.

import C4rk
import XCTest

class LegacyMathTests: XCTestCase {

    func testLerp() {
        XCTAssert(lerp(0.0, 10.0, at: 0.2) == 2.0, "Value should be interpolated")
    }

    func testClampLess() {
        let testValue = clamp(-1, range: 10...20)
        let correctValue = 10
        XCTAssertEqual(testValue, correctValue, "Value should be clamped to lower bound")
    }

    func testClampNoOp() {
        let testValue = clamp(11, range: 10...20)
        let correctValue = 11
        XCTAssertEqual(testValue, correctValue, "Value should not be clamped")
    }

    func testClampGreater() {
        let testValue = clamp(21, range: 10...20)
        let correctValue = 20
        XCTAssertEqual(testValue, correctValue, "Value should be clamped to upper bound")
    }

    func testMapOpen() {
        let testValue = linearMap(5, from: 0..<10, to: 0..<20)
        let correctValue = 10.0
        XCTAssertEqual(testValue, correctValue, "Value should be mapped to the target range")
    }

    func testMapClosed() {
        let testValue = linearMap(5, from: 0...10, to: 0...20)
        let correctValue = 10.0
        XCTAssertEqual(testValue, correctValue, "Value should be mapped to the target range")
    }

    func testLerpDouble() {
        let testValue = linearMap(5.0, from: 0.0..<10.0, to: 0.0..<20.0)
        let correctValue = 10.0
        XCTAssertEqual(testValue, correctValue, "Double value should be mapped to the target range")
    }

    func testLerpInt() {
        let testValue = linearMap(6, from: 0..<10, to: 0..<20)
        let correctValue = 12.0
        XCTAssertEqual(testValue, correctValue, "Double value should be mapped to the target range")
    }

    func testRandom() {
        let testValue = random(below: 100)
        XCTAssertLessThan(testValue, 100, "Returned value for random is not below provided value")
    }

    func testRandomBelow() {
        let upperBound = 10
        let samples = 1000
        var min = Int.max
        var max = Int.min
        for _ in 0..<samples {
            let value = random(below: upperBound)
            if value < min { min = value }
            if value > max { max = value }
        }

        XCTAssertGreaterThanOrEqual(min, 0, "Random values should be >= 0")
        XCTAssertLessThan(max, upperBound, "Random values should be < \(upperBound)")
    }

    func testRandomBetween() {
        let lowerBound = 10
        let upperBound = 20
        let samples = 1000
        var min = Int.max
        var max = Int.min
        for _ in 0..<samples {
            let value = random(in: lowerBound..<upperBound)
            if value < min { min = value }
            if value > max { max = value }
        }

        XCTAssertGreaterThanOrEqual(min, 0, "Random values should be >= \(lowerBound)")
        XCTAssertLessThan(max, upperBound, "Random values should be < \(upperBound)")
    }

    func testRandom01() {
        let samples = 1000
        var min = 1.0
        var max = 0.0
        for _ in 0..<samples {
            let value = random(in: 0.0..<1.0)
            if value < min { min = value }
            if value > max { max = value }
        }

        XCTAssertGreaterThanOrEqual(min, 0.0, "Random values should be >= 0")
        XCTAssertLessThan(max, 1.0, "Random values should be < 1")
    }

    func testRadToDeg() {
        let testValue = radToDeg(Double.pi / 2.0)
        XCTAssert(testValue == 90.0, "Retured value for radToDeg is invalid, should be 90.0")
    }

    func testDegToRad() {
        let testValue = degToRad(90.0)
        XCTAssert(testValue == Double.pi / 2.0, "Retured value for degToRag is invalid, should be Double.pi / 2.0")
    }
}
