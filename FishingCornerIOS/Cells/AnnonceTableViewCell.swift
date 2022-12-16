import UIKit

class AnnonceTableViewCell: UITableViewCell {

    @IBOutlet weak var annonceImage: UIImageView!
    
    @IBOutlet weak var annonceTitle: UILabel!
    
    
    @IBOutlet weak var annonceAdress: UILabel!
    
    @IBOutlet weak var annoncePrice: UILabel!
    
    
    
    @IBOutlet weak var annoncePhoneNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
