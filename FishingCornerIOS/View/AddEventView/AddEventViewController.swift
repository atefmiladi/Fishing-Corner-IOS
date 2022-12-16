import UIKit

class AddEventViewController: UIViewController,UINavigationControllerDelegate ,UIImagePickerControllerDelegate {

    @IBOutlet weak var imageEvent: UIImageView! 
    @IBOutlet weak var dateEventPicker: UIDatePicker!
    @IBOutlet weak var titleEventTextfield: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    var selectedDate :String?
    
    var user : User? {
        
        return UserProvider.shared.getUser()
    }
    
    static func Instanciate() -> AddEventViewController{
       
        let storyboard = UIStoryboard(name: "AddEventStoryboard", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "AddEventViewController") as! AddEventViewController
        
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dateEventPicker.minimumDate = Date()
        
        let label = UILabel()
        label.text = "Fishing Corner"
        label.font = UIFont(name: "Roboto-Bold", size: 24)
        label.textColor = .white
        
        navigationItem.titleView = label
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func dateDidChanged(_ sender: Any) {
        
        self.selectedDate = DateManager.setDateForMysql(date: self.dateEventPicker.date)

    }
    
    @IBAction func selectImage(_ sender: Any) {
        
        showActionSheet()
        
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        AlertView.showLoading(message: "Loading", viewController: self)
        
        if (titleEventTextfield.text!.isEmpty || descriptionTextField.text!.isEmpty || selectedDate == nil || imageEvent.image == nil ) {
            
            self.dismiss(animated: true, completion: {
                
                let alert = UIAlertController(title: nil, message: "All fields are required !", preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                self.present(alert, animated: false, completion: nil)
                
            })

            
        }else{
            
            let event = Event()
            
            event.title = titleEventTextfield.text
            event.description = descriptionTextField.text
            event.dateEvent = self.selectedDate
            event.user = self.user
            EventController.shared.addEvent(event: event, image: self.imageEvent.image!, successHandler: {
                
                self.dismiss(animated: true, completion: {
                    
                    let alert = UIAlertController(title: nil, message: "Event did successfully created !", preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    
                    self.present(alert, animated: false, completion: nil)
                    
                })
                
                
            }, errorHandler: {
                
                
                self.dismiss(animated: true, completion: {
                    
                    let alert = UIAlertController(title: nil, message: "Something wrong did happen !", preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    
                    self.present(alert, animated: false, completion: nil)
                    
                })
                
                
            })
            
            
            
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
          
          self.imageEvent.image = selectedImage
          
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
