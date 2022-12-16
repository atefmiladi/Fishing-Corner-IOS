//
//  ProfileViewController.swift
//  FishingCornerIOS
//
//  Created by malek belayeb on 12/6/2021.
//

import UIKit
import AlamofireImage
import Alamofire

class ProfileViewController: UIViewController,UINavigationControllerDelegate ,UIImagePickerControllerDelegate {

    @IBOutlet weak var adressTextFIeld: UITextField!
    
    @IBOutlet weak var firstnameTextfield: UITextField!
    @IBOutlet weak var lastnameTextfield: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var profileImage: CircularImageView!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var userEmail: UILabel!
    
    @IBOutlet weak var userPhone: UILabel!
    
    @IBOutlet weak var userAdress: UILabel!

    lazy var parentNavigationItem : UINavigationItem? = self.tabBarController?.navigationItem
    
    
    var user : User? {
        
        return UserProvider.shared.getUser()
    }
    
    let imageCache = NSCache<NSString,UIImage>()
    let utilityQueue = DispatchQueue.global(qos: .utility)

    static func Instanciate() -> ProfileViewController{
       
        let storyboard = UIStoryboard(name: "ProfileStoryboard", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "ProfileViewController") as! ProfileViewController
        
        return viewController
    }
    
    
    func updateView()
    {
        
        let user = UserProvider.shared.getUser()
        
        self.username.text = user!.firstname! + " " + user!.lastname!
        self.userAdress.text = user?.adress
        self.userEmail.text = user?.email
        self.userPhone.text = user?.phone
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        setupTopBar()
        
        if let img = user!.image
        {
            let url = Constants.URL_IMAGE_USER+img
            utilityQueue.async {
                
                let url = URL(string: url)!
                
                guard let data = try? Data(contentsOf: url) else {return}
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    
                    self.profileImage.image = image
                
                }
                        
            }
            
        }
     
    }
    
    
    func setupTopBar()
    {
                
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        navigationController?.navigationBar.barTintColor = UIColor(named: "Color 1")
        
        navigationController?.navigationBar.isTranslucent = false
        
        let eventIcon = UIImage(systemName: "note.text")
            
        let eventButton = UIBarButtonItem(image: eventIcon, style: .plain, target: self, action: #selector(onEventTapped))
            
        let annonceIcon = UIImage(systemName: "cart")
            
        let annonceButton = UIBarButtonItem(image: annonceIcon, style: .plain, target: self, action: #selector(onAnnonceTapped))
        
        annonceButton.tintColor = UIColor.white
        eventButton.tintColor = UIColor.white

        let label = UILabel()
        
        label.text = "Profile"
        label.font = UIFont(name: "Roboto-Bold", size: 24)
        label.textColor = .white

        navigationItem.rightBarButtonItems = [annonceButton,eventButton]
        
        navigationItem.titleView = label
        
    }
    
    @objc func onAnnonceTapped()
    {
        self.present(MyAnnonceViewController.Instanciate(), animated: true, completion: nil)
    }
    
    @objc func onEventTapped()
    {
        self.present(MyEventViewController.Instanciate(), animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.username.text = user!.firstname! + " " + user!.lastname!
        self.userAdress.text = user?.adress
        self.userEmail.text = user?.email
        self.userPhone.text = user?.phone
        
        self.adressTextFIeld.text = user?.adress
        self.firstnameTextfield.text = user?.firstname
        self.lastnameTextfield .text = user?.lastname
        self.phoneTextField.text = user?.phone
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func changePicTapped(_ sender: Any) {
        
        showActionSheet()
        
    }
    
    @IBAction func updateTapped(_ sender: Any) {
        
        AlertView.showLoading(message: "Loading...", viewController: self)
        
        let user = User()
        user.iduser = self.user?.iduser
        user.adress = adressTextFIeld.text
        user.firstname = firstnameTextfield.text
        user.lastname = lastnameTextfield.text
        user.phone = phoneTextField.text
        
        
    
        UserController.shared.updateUser(user: user, image: self.profileImage.image!, successHandler: {
            
            self.dismiss(animated: true, completion: {
                
                let alert = UIAlertController(title: nil, message: "User did successfully updated !", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
                
                self.present(alert, animated: true, completion: {
                    
                    self.updateView()

                })
                
            })
            
            
        }, errorHandler: {
            
            
            
        })
        
    }
    
    
    
    
      func camera()
      {
          let myPickerControllerCamera = UIImagePickerController()
          myPickerControllerCamera.delegate = self
          myPickerControllerCamera.sourceType = UIImagePickerController.SourceType.camera
          myPickerControllerCamera.allowsEditing = true
          self.present(myPickerControllerCamera, animated: true, completion: nil)

      }

      func gallery()
      {

          let myPickerControllerGallery = UIImagePickerController()
          myPickerControllerGallery.delegate = self
          myPickerControllerGallery.sourceType = UIImagePickerController.SourceType.photoLibrary
          myPickerControllerGallery.allowsEditing = true
          self.present(myPickerControllerGallery, animated: true, completion: nil)

      }
      
      func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          
          guard let selectedImage = info[.originalImage] as? UIImage else {
             
              return
         }
          
          self.profileImage.image = selectedImage
          
          self.dismiss(animated: true, completion: nil)
      }
      
      func showActionSheet(){

          let actionSheetController: UIAlertController = UIAlertController(title: NSLocalizedString("Upload Image", comment: ""), message: nil, preferredStyle: .actionSheet)
          actionSheetController.view.tintColor = UIColor.black
          let cancelActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { action -> Void in
              print("Cancel")
          }
          actionSheetController.addAction(cancelActionButton)

          let saveActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Take Photo", comment: ""), style: .default)
          { action -> Void in
              self.camera()
          }
          actionSheetController.addAction(saveActionButton)

          let deleteActionButton: UIAlertAction = UIAlertAction(title: NSLocalizedString("Choose From Gallery", comment: ""), style: .default)
          { action -> Void in
              self.gallery()
          }
          
          actionSheetController.addAction(deleteActionButton)
          self.present(actionSheetController, animated: true, completion: nil)
      }

      
    
    
    @IBAction func logoutTapped(_ sender: Any) {
        
        
        let alert = UIAlertController(title: nil, message: "Do you want to logout ?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {_ in
        
            UserProvider.shared.clearCoreData()
            
            self.navigationController?.pushViewController(SignInViewController.Instanciate(), animated: false)
        
        }))
        
        self.present(alert, animated: false, completion: nil)
        
    }
    

}
