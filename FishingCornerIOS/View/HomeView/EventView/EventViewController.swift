//
//  EventViewController.swift
//  FishingCornerIOS
//
//  Created by malek belayeb on 18/6/2021.
//

import UIKit

class EventViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    var events:[Event] = []
    
    var user : User? {
        
        return UserProvider.shared.getUser()
    }
    @IBOutlet weak var eventTableView: UITableView!
    lazy var parentNavigationItem : UINavigationItem? = self.tabBarController?.navigationItem

    static func Instanciate() -> EventViewController{
       
        let storyboard = UIStoryboard(name: "EventStoryboard", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "EventViewController") as! EventViewController

        return viewController
    }
    
    
    override func viewWillAppear(_ animated: Bool) {

        setupTopBar()


        EventController.shared.getAllEvent(iduser:self.user!.iduser!.description,successHandler: {
            
            events in
            
            self.events = events
            
            self.eventTableView.reloadData()
            
        }, errorHandler: {
            
            
        })
    
    }
    
    
    func setupTopBar()
    {

        navigationController?.setNavigationBarHidden(false, animated: false)
        
        navigationController?.navigationBar.barTintColor = UIColor(named: "Color 1")
        
        navigationController?.navigationBar.isTranslucent = false
        
        let addIcon = UIImage(systemName: "plus")
            
        let add = UIBarButtonItem(image: addIcon, style: .plain, target: self, action: #selector(onAddTapped))
            
        add.tintColor = UIColor.white
        parentNavigationItem?.rightBarButtonItems = [add]
        
        parentNavigationItem?.setHidesBackButton(true, animated:false)

    }
    @objc func onAddTapped()
    {

        self.navigationController?.pushViewController(AddEventViewController.Instanciate(), animated: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.eventTableView.register(UINib.init(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "EventTableViewCell")
  
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableViewCell",for: indexPath) as! EventTableViewCell
    
        cell.nameLabel.text = self.events[indexPath.row].title
        cell.dateLabel.text = DateManager.getFormatEventDate(date: DateManager.getDateFromMysql(date: self.events[indexPath.row].dateEvent!)!)

        let url = Constants.URL_IMAGE_EVENT+self.events[indexPath.row].imageEvent!
            
        ImageLoader.shared.loadImage(identifier: ImageLoader.EVENT_IMAGE + self.events[indexPath.row].idevent!.description, url: url, completion: {image in
            
            cell.imageEvent.image = image
                        
        })
        
        if self.events[indexPath.row].my_interest! == 1 {
            
            
            cell.interestIconImage.image = UIImage(named: "interested-icon")
            cell.goingIconImage.image = UIImage(named: "going-icon")
            cell.interestIconImage.image = UIImage(named: "interest-delete")
            
        }
        
        if self.events[indexPath.row].my_ongoing! == 1 {
            
            cell.interestIconImage.image = UIImage(named: "interested-icon")
            cell.goingIconImage.image = UIImage(named: "going-icon")
            cell.goingIconImage.image = UIImage(named: "ongoing-delete")
            
        }
        
        
        cell.event = events[indexPath.row]
        cell.user = self.user
        
        let tapGestureGoing = UITapGestureRecognizer(target: cell, action: #selector(cell.onGoingTapped))
        
        let tapGestureInterest = UITapGestureRecognizer(target: cell, action: #selector(cell.onInterestTapped))
            
        cell.interestStack.addGestureRecognizer(tapGestureInterest)
        cell.ongoingStack.addGestureRecognizer(tapGestureGoing)

        
        return cell
    }
    
       
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
            
            let label = UILabel()
            label.frame = CGRect.init(x: 8, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
            
        label.text = "Our Events (" + self.events.count.description + ")"
            label.font = UIFont(name: "Roboto-Bold", size: 18)

            headerView.addSubview(label)
            
            return headerView
        }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 50
        }
    

}
