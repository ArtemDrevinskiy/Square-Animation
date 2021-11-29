//
//  SquareAnimationViewController.swift
//  SquareAnimation
//
//  Created by Dr.Drexa on 29.11.2021.
//

import UIKit

public class SquareAnimationViewController: UIViewController {
    
    
    var rectangles = [Rectangle]()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        createRectangles(dimension: 10, separator: 4)
        paintRectangles(rectangles: self.rectangles)

                
    }
    public override func viewDidAppear(_ animated: Bool) {
       fillRectangleWithColor()
    }
    func fillRectangleWithColor() {
        var i = 0
        let timer = Timer.scheduledTimer(withTimeInterval: 0.04, repeats: true) { (timer) in
            self.view.subviews[i].backgroundColor = #colorLiteral(red: 0, green: 0.2412394232, blue: 1, alpha: 1)
            i += 1
            guard i < self.view.subviews.count else {
                timer.invalidate()
                self.clearRectangleColor()
                return
            }
        }
        RunLoop.current.add(timer, forMode: .common)

    }
    func clearRectangleColor() {
        var i = 0
        let timer = Timer.scheduledTimer(withTimeInterval: 0.04, repeats: true) { (timer) in
            self.view.subviews[i].backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            i += 1
            guard i < self.view.subviews.count else {
                timer.invalidate()
                self.fillRectangleWithColor()
                return
            }
        }
        RunLoop.current.add(timer, forMode: .common)

    }
    
    func createRectangles(dimension: Float, separator: Float) {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let rectWidth = (screenWidth - (CGFloat(separator)  * (CGFloat(dimension) - 1)))/(CGFloat(dimension) + 2)
        let rectHeight = rectWidth
        var xPos = rectWidth
        var yPos = (screenHeight - rectHeight * CGFloat.init(dimension) -  CGFloat.init(separator) * CGFloat.init(dimension - 1))/2
        
        for _ in 1...Int(dimension) {
            for _ in 1...Int(dimension) {
                self.addRectangle(xPosition: xPos, yPosition: yPos, rectWidth: rectWidth, rectHeight: rectHeight)
                xPos += rectWidth + CGFloat.init(separator)
            }
            xPos = rectWidth
            yPos += rectHeight + CGFloat.init(separator)
        }
    }
    
    public func addRectangle(xPosition: CGFloat, yPosition: CGFloat, rectWidth: CGFloat, rectHeight: CGFloat) {
        let newRect = Rectangle.init(xPos: xPosition, yPos: yPosition, rectWidth: rectWidth, rectHeight: rectHeight)
        self.rectangles.append(newRect)
        
    }
    
    func paintRectangles(rectangles: [Rectangle]) {
        for rectangle in rectangles {
            let rectFrame: CGRect = CGRect(x:CGFloat(rectangle.xPos),
                                           y:CGFloat(rectangle.yPos),
                                           width:CGFloat(rectangle.rectWidth),
                                           height:CGFloat(rectangle.rectHeight))
            
            let blueRect = UIView(frame: rectFrame)
            blueRect.backgroundColor = UIColor.white
            
            self.view.addSubview(blueRect)
        }
    }
    
}

struct Rectangle {
    let xPos: CGFloat
    let yPos: CGFloat
    let rectWidth: CGFloat
    let rectHeight: CGFloat
}

