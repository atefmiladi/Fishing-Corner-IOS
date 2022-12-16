//
//  MyEventViewController.swift
//  FishingCornerIOS
//
//  Created by malek belayeb on 20/6/2021.
//

import UIKit

class MyEventViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var events:[Event] = []
   
    var user : User? {
        
        return UserProvider.shared.getUser()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        events.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        EventController.shared.getAllEvent(iduser: user!.iduser!.description, successHandler: { [self]
            
            events in
            
            self.events = Array(events.filter{$0.user!.iduser! == user!.iduser!})
            self.myEventTableVIew.reloadData()
            
            
        }, errorHandler: {
        
            
        })
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
         
            EventController.shared.deleteEvent(idevent: self.events[indexPath.row].idevent!.description, successHandler: {
                
                self.events.remove(at: indexPath.row)
                self.myEventTableVIew.deleteRows(at: [indexPath], with: .fade)
             
                
            }, errorHandler: {
                
                
            })
        
        }
    }
    
 
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
            
            let label = UILabel()
            label.frame = CGRect.init(x: 8, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
            
            label.text = "My Events (" + self.events.count.description + ")"
            label.font = UIFont(name: "Roboto-Bold", size: 18)

            headerView.addSubview(label)
            
            return headerView
        }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 50
        }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyEventTableViewCell",for: indexPath) as! MyEventTableViewCell
        
        cell.titleEvent.text = self.events[indexPath.row].title
        cell.addressEvent.text = "Tunis, Tunisia"
        
        cell.dateEvent.text = DateManager.getFormatEventDate(date: DateManager.getDateFromMysql(date: self.events[indexPath.row].dateEvent!)!)


        
        let url = Constants.URL_IMAGE_EVENT+self.events[indexPath.row].imageEvent!
            
        ImageLoader.shared.loadImage(identifier: ImageLoader.EVENT_IMAGE + self.events[indexPath.row].idevent!.description, url: url, completion: {image in
            
            cell.imageEvent.image = image
                        
        })
        
        return cell
    }
    

    
    @IBOutlet weak var myEventTableVIew: UITableView!
    
    static func Instanciate() -> MyEventViewController{
       
        let storyboard = UIStoryboard(name: "MyEventStoryboard", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "MyEventViewController") as! MyEventViewController
        
        return viewController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        self.myEventTableVIew.register(UINib.init(nibName: "MyEventTableViewCell", bundle: nil), forCellReuseIdentifier: "MyEventTableViewCell")
        
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
