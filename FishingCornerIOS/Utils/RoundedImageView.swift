import UIKit

@IBDesignable

class RoundedImageView:UIImageView {
    
    
    override func layoutSubviews() {
        
        
        layer.cornerRadius = 6
        layer.borderWidth = 2
        layer.borderColor = UIColor(named: "Color 3")?.cgColor


    }
    
}
