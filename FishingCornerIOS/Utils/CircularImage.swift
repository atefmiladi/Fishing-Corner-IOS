import UIKit

@IBDesignable class CircularImageView:UIImageView{
    
    
    override func layoutSubviews() {
        self.layoutIfNeeded()
        
        self.layer.borderWidth = 0.5
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
        
    }
    
}
