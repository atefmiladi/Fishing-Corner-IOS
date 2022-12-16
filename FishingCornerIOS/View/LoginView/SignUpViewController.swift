//
//  SignUpViewController.swift
//  FishingCornerIOS
//
//  Created by malek belayeb on 12/6/2021.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var firstnameTextField: UITextField!
    
    @IBOutlet weak var lastnameTextField: UITextField!
    
    
    
    static func Instanciate() -> SignUpViewController{
       
        let storyboard = UIStoryboard(name: "SignUpStoryboard", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        
        return viewController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func confirmDidTapped(_ sender: Any) {
        
        
        let user = User()
        user.email = emailTextField.text
        user.firstname = firstnameTextField.text
        user.lastname = lastnameTextField.text
        user.password = passwordTextField.text
        
        
        AlertView.showLoading(message: "Loading ... ", viewController: self)
        
        
        UserController.shared.addUser(user: user) { user in
            
            
            self.dismiss(animated: true, completion: {
                
                let alert = UIAlertController(title: nil, message: "Welcome to fishing Corener App", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: false, completion: nil)
                
            })
            
            
            
        } emailAlreadyExist: {
            
            self.dismiss(animated: true, completion: {
                
                let alert = UIAlertController(title: nil, message: "Email already exist, please try another !", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                self.present(alert, animated: false, completion: nil)
                
            })
        } errorFound: {
           
            self.dismiss(animated: true, completion: {
                
                let alert = UIAlertController(title: nil, message: "Error did occur, please try later !", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                self.present(alert, animated: false, completion: nil)
                
            })
        }

        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
