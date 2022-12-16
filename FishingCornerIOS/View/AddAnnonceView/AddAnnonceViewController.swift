import UIKit

class AddAnnonceViewController: UIViewController,UINavigationControllerDelegate ,UIImagePickerControllerDelegate {

    @IBOutlet weak var annonceImage: RoundedImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var descriptionTextFIeld: UITextField!
    
    @IBOutlet weak var priceTextField: UITextField!
    
    var user : User? {
        
        return UserProvider.shared.getUser()
    }
    
    static func Instanciate() -> AddAnnonceViewController{
       
        let storyboard = UIStoryboard(name: "AddAnnonceStoryboard", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "AddAnnonceViewController") as! AddAnnonceViewController
        
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.text = "Fishing Corner"
        label.font = UIFont(name: "Roboto-Bold", size: 24)
        label.textColor = .white
        
        navigationItem.titleView = label
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    @IBAction func addTapped(_ sender: Any) {
        
        AlertView.showLoading(message: "Loading", viewController: self)
        
        if (titleTextField.text!.isEmpty || priceTextField.text!.isEmpty || descriptionTextFIeld.text!.isEmpty || annonceImage.image == nil ) {
            
            self.dismiss(animated: true, completion: {
                
                let alert = UIAlertController(title: nil, message: "All fields are required !", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                self.present(alert, animated: false, completion: nil)
                
            })

            
        }else{
            let price = Double(priceTextField.text!)
            
            if( price == nil )
            {
                self.dismiss(animated: true, completion: {
                    
                    let alert = UIAlertController(title: nil, message: "Please provide a correct price !", preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    
                    self.present(alert, animated: false, completion: nil)
                    
                })
            }else{
                
                
                let annonce = Annonce()
                annonce.user = self.user
                annonce.title = self.titleTextField.text
                annonce.adress = "Tunis,Tunisia"
                annonce.price = priceTextField.text
                annonce.description = descriptionTextFIeld.text
                
                
                AnnonceController.shared.addAnnonce(annonce: annonce, image: self.annonceImage.image!, successHandler: {
                    
                    self.titleTextField.text = ""
                    self.descriptionTextFIeld.text = ""
                    self.priceTextField.text = ""
                    
                    self.dismiss(animated: true, completion: {
                        
                        let alert = UIAlertController(title: nil, message: "Your annonce did successfully created !", preferredStyle: .alert)

                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        
                        self.present(alert, animated: true, completion: nil)
                        
                    })
                    
                }, errorHandler: {
                    
                    self.dismiss(animated: true, completion: {
                        
                        let alert = UIAlertController(title: nil, message: "Something wrong did happen !", preferredStyle: .alert)

                        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                        
                        self.present(alert, animated: true, completion: nil)
                        
                    })
                    
                    
                })
         
                
            }
            
            
        }
        
        
        
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
        
        self.annonceImage.image = selectedImage
        
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

    
    
    @IBAction func selectImageAnnonce(_ sender: Any) {
        
        showActionSheet()

        
    }
    
    
    
}
