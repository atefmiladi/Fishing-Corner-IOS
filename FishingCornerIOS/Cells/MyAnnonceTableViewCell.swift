import UIKit

class MyAnnonceTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleAnnonce: UILabel!
    
    @IBOutlet weak var priceAnnonce: UILabel!
    
    @IBOutlet weak var adressAnnonce: UILabel!
    
    @IBOutlet weak var imageAnnonce: UIImageView!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
