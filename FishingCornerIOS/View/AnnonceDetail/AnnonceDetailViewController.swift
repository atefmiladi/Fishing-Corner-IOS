import UIKit

class AnnonceDetailViewController: UIViewController {

    
    
    var annonce:Annonce?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.annonceTitle.text = annonce?.title
        self.annonceAddress.text = annonce?.adress
        self.annoncePrice.text = annonce?.price
        self.annonceDescription.text = annonce?.description
        
        usernameLabel.text = annonce!.user!.firstname!.capitalized +  " " + annonce!.user!.lastname!.capitalized
        phoneNumberUser.text = annonce?.user?.phone
    
        let url = Constants.URL_IMAGE_ANNONCE+self.annonce!.image!
            
        ImageLoader.shared.loadImage(identifier: ImageLoader.ANNONCE_IMAGE + self.annonce!.idannonce!.description, url: url, completion: {image in
            
            self.annonceImage.image = image
                        
        })
    }

    @IBOutlet weak var annonceImage: RoundedImageView!
    
    @IBOutlet weak var annonceTitle: UILabel!
    
    @IBOutlet weak var annonceAddress: UILabel!
    
    @IBOutlet weak var annoncePrice: UILabel!
    
    @IBOutlet weak var annonceDescription: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var phoneNumberUser: UILabel!
    
    
    
    
    static func Instanciate(annonce:Annonce) -> AnnonceDetailViewController{
       
        let storyboard = UIStoryboard(name: "AnnonceDetailStoryboard", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "AnnonceDetailViewController") as! AnnonceDetailViewController

        viewController.annonce = annonce
        
        return viewController
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
