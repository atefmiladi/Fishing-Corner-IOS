import UIKit

class HomeViewController: UITabBarController {

    
    var user:User?
    
    static func Instanciate(user:User) -> HomeViewController{
       
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        viewController.user = user
        return viewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
        
        setupBottomBar()

    }
    
    func setupBottomBar()
    {
      
        tabBar.unselectedItemTintColor = .white

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
}
