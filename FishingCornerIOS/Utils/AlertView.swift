import UIKit


class AlertView {
    
    
    
    
    static func showLoading(message:String,viewController:UIViewController)
    {
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))

        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating()
        
        alert.view.addSubview(loadingIndicator)
        
        viewController.present(alert, animated: true, completion: nil)
        
    }
    
    
    
}
