import UIKit

extension UIBezierPath {
    static func arrow(line: Line, config: SpotConfig) -> UIBezierPath {
        let start = line.from
        let end = line.to
        let length = hypot(end.x - start.x, end.y - start.y)
        let tailLength = length - config.length
        
        let points: [CGPoint] = [
            CGPoint(x: tailLength, y: config.height / 2),
            CGPoint(x: length, y: 0),
            CGPoint(x: tailLength, y: -config.height / 2),
        ]
        
        let cosine = (end.x - start.x) / length
        let sine = (end.y - start.y) / length
        let transform = CGAffineTransform(a: cosine, b: sine, c: -sine, d: cosine, tx: start.x, ty: start.y)
        
        let path = CGMutablePath()
        path.addLines(between: points, transform: transform)
        path.closeSubpath()
        
        return self.init(cgPath: path)
    }
}

extension CAShapeLayer {
    class func arrow(line: Line, config: SpotConfig) -> CAShapeLayer {
        let path = UIBezierPath.arrow(line: line, config: config)
        let layer = CAShapeLayer()
        layer.fillColor = config.color.cgColor
        layer.lineWidth = config.lineWidth
        layer.strokeColor = config.lineColor.cgColor
        layer.path = path.cgPath
        return layer
    }
}
