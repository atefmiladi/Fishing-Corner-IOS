import UIKit

class EventTableViewCell: UITableViewCell {
    @IBOutlet weak var interestStack: UIStackView!
    
    @IBOutlet weak var imageEvent: UIImageView!
    @IBOutlet weak var ongoingStack: UIStackView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var interestIconImage: UIImageView!
    
    @IBOutlet weak var goingIconImage: UIImageView!
    
    var user:User?
    var event:Event?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func onGoingTapped()
    {
        let participation = Participation()
        participation.event = self.event
        participation.user = self.user
        participation.type = "ONGOING"
       
        EventController.shared.addParticipation(participation: participation, interestDidCreated: {
            
            self.interestIconImage.image = UIImage(named: "interested-icon")
            self.goingIconImage.image = UIImage(named: "going-icon")
            self.interestIconImage.image = UIImage(named: "interest-delete")
            
        }, onGoingDidCreated: {
            
            self.interestIconImage.image = UIImage(named: "interested-icon")
            self.goingIconImage.image = UIImage(named: "going-icon")
            self.goingIconImage.image = UIImage(named: "ongoing-delete")

            
        }, participationDeleted: {
            
            self.interestIconImage.image = UIImage(named: "interested-icon")
            self.goingIconImage.image = UIImage(named: "going-icon")
            
        }, errorHandler: {
            
            
        })
        
    }
    
    @objc func onInterestTapped()
    {
        let participation = Participation()
        participation.event = self.event
        participation.user = self.user
        participation.type = "INTEREST"
        
        
        EventController.shared.addParticipation(participation: participation, interestDidCreated: {
            
            self.interestIconImage.image = UIImage(named: "interested-icon")
            self.goingIconImage.image = UIImage(named: "going-icon")
            self.interestIconImage.image = UIImage(named: "interest-delete")
            
        }, onGoingDidCreated: {
            
            self.interestIconImage.image = UIImage(named: "interested-icon")
            self.goingIconImage.image = UIImage(named: "going-icon")
            self.goingIconImage.image = UIImage(named: "ongoing-delete")

            
        }, participationDeleted: {
            
            self.interestIconImage.image = UIImage(named: "interested-icon")
            self.goingIconImage.image = UIImage(named: "going-icon")
            
        }, errorHandler: {
            
            
        })
    }
    
}
