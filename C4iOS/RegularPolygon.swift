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

import Foundation
import CoreGraphics
import C4Core

public class RegularPolygon: Shape {
    @IBInspectable
    public var sides: Int = 3 {
        didSet {
            updatePath()
        }
    }
    
    @IBInspectable
    public var phase: Double = 0 {
        didSet {
            updatePath()
        }
    }
    
    internal override func updatePath() {
        let rect = inset(Rect(bounds), lineWidth, lineWidth)
        let rx = rect.size.width / 2.0
        let ry = rect.size.height / 2.0
        if sides == 0 || rx <= 0 || ry <= 0 {
            // Don't try to generate invalid polygons, we'll get undefined behaviour
            return
        }
        
        let center = rect.center
        let delta = 2.0*M_PI / Double(sides)
        let path = Path()
        
        for i in 0..<sides {
            let angle = phase + delta*Double(i)
            let point = Point(center.x + rx*cos(angle), center.y + ry*sin(angle))
            if i == 0 {
                path.moveToPoint(point)
            } else {
                path.addLineToPoint(point)
            }
        }
        path.closeSubpath()
        shapeLayer.path = path.CGPath
    }
}
