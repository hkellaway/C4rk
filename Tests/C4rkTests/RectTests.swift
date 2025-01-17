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

class RectTests: XCTestCase {
    func testIntersects() {
        let a = Rect(0, 0, 100, 100)
        let b = Rect(50, 50, 100, 100)
        let c = Rect(100, 100, 100, 100)
        XCTAssertTrue(a.intersects(b), "a and b intersect")
        XCTAssertFalse(a.intersects(c), "a and c do not intersect")
    }

    func testCenter() {
        for _ in 1...10 {
            let val = Double(random(below: 100))
            let rect = Rect(0, 0, val, val)
            XCTAssertEqual(rect.center, Point(val/2.0, val/2.0), "Center point should be half the width and height of the Rect")
        }
    }

    func testMax() {
        for _ in 1...10 {
            let x = Double(random(below: 100))
            let y = Double(random(below: 100))
            let rect = Rect(x, y, 100, 100)
            XCTAssertEqual(rect.max, Point(x + 100, y + 100), "Max point should equal the origin plus the size of the Rect")
        }
    }

    func testIsZero() {
        XCTAssertTrue(Point().isZero(), "A point created with no arguments should be {0,0}")
    }

    func testContainsRect() {
        let a = Rect(0, 0, 100, 100)
        let b = Rect(50, 50, 50, 50)
        let c = Rect(50, 50, 100, 100)
        XCTAssertTrue(a.contains(b), "A should contain B")
        XCTAssertTrue(c.contains(b), "C should contain B")
        XCTAssertFalse(a.contains(c), "A should not contain C")
    }

    func testContainsPoint() {
        let a = Rect(0, 0, 100, 100)
        let b = Rect(25, 25, 50, 50)
        let c = Rect(50, 50, 100, 100)
        XCTAssertTrue(a.contains(b.center), "A should contain the center of B")
        XCTAssertTrue(b.contains(c.origin), "B should contain the origin of C")
        XCTAssertFalse(c.contains(b.origin), "C should not contain the center of A")
    }

    func testEquals() {
        let a = Rect(10, 10, 10, 10)
        var b = Rect(0, 0, 10, 10)
        b.center = Point(15, 15)
        XCTAssertEqual(a, b, "A should be equal to B")
    }

    func testIntersection() {
        func r() -> Double {
            return Double(random(below: 90) + 10)
        }

        let a = Rect(0, 0, r(), r())
        let b = Rect(10, 10, r(), r())
        let c = intersection(a, rect2: b)
        let x = (b.max.x - a.max.x < 0) ? b.max.x : a.max.x
        let y = (b.max.y - a.max.y < 0) ? b.max.y : a.max.y
        let d = Rect(b.origin.x, b.origin.y, x - b.origin.x, y - b.origin.y)
        XCTAssertEqual(c, d, "C should be equal to D")
    }

    func testUnion() {
        func r() -> Double {
            return Double(random(below: 100))
        }

        let a = Rect(r(), r(), r() + 1, r() + 1)
        let b = Rect(r(), r(), r() + 1, r() + 1)
        let c = union(a, rect2: b)
        let o = Point(min(a.origin.x, b.origin.x), min(a.origin.y, b.origin.y))
        let s = LegacySize(max(a.max.x, b.max.x) - o.x, max(a.max.y, b.max.y) - o.y)
        let d = Rect(o, s)
        XCTAssertEqual(c, d, "C should be equal to D")
    }

    func testIntegral() {
        XCTAssertEqual(integral(Rect(0.1, 0.9, 9.9, 9.1)), Rect(0, 0, 10, 10))
    }

    func testStandardize() {
        XCTAssertEqual(standardize(Rect(0, 0, -10, -10)), Rect(-10, -10, 10, 10))
    }

    func testInset() {
        func r() -> Double {
            return Double(random(below: 100))
        }
        let a = Rect(r(), r(), r() + 1, r() + 1)
        let x = r()
        let y = r()
        _ = inset(a, dx: x, dy: y)
        _ = Rect(a.origin, LegacySize(a.size.width - x, a.size.height - y))
    }
}
