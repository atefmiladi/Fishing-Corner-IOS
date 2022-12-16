import UIKit


@IBDesignable class CardViewDesign : UIView
{
    
    @IBInspectable var cornerradius : CGFloat = 5
    
    @IBInspectable var shadowOffsetWidth : CGFloat = 0
    
    @IBInspectable var shadowOffsetHeight : CGFloat = 3

    @IBInspectable var shadowColor : UIColor = UIColor.black

    @IBInspectable var shadowOpacity : CGFloat = 0.5
    
    
    override func layoutSubviews() {
    
        self.layoutIfNeeded()
        layer.cornerRadius = self.cornerradius
            
        layer.shadowColor = self.shadowColor.cgColor
        
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: self.cornerradius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity =   Float(self.shadowOpacity)

    
    }
    
}
