//
//  SignInViewController.swift
//  FishingCornerIOS
//
//  Created by malek belayeb on 12/6/2021.
//

import UIKit

class SignInViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return true

    }

    static func Instanciate() -> SignInViewController{
       
        let storyboard = UIStoryboard(name: "SignInStoryboard", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "SignInViewController") as! SignInViewController
        
        return viewController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
    }
    
    
    
    @IBAction func signInTapped(_ sender: Any) {
        
        
        AlertView.showLoading(message: "Loading ... ", viewController: self)

        UserController.shared.loginUser(email: emailTextField.text!, password: passwordTextField.text!, userDidFound: {
            
            user in
            
            self.dismiss(animated: true, completion: {
      
                
                self.navigationController?.pushViewController(HomeViewController.Instanciate(user: user), animated: true)
                
            })
            
            
            
        }, wrongCredential: {
            
            self.dismiss(animated: true, completion: {
                
                let alert = UIAlertController(title: nil, message: "Please verify your credential !", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: false, completion: nil)
                
            })
            
            
        }, errorHandler: {
            
            self.dismiss(animated: true, completion: {
                
                let alert = UIAlertController(title: nil, message: "Something went wrong, please try later !", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                self.present(alert, animated: false, completion: nil)
                
            })
            
            
        })
        
        
    }
    
    
    @IBAction func signUpNav(_ sender: Any) {
        
        self.navigationController?.pushViewController(
            SignUpViewController.Instanciate(), animated: true)
        
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
