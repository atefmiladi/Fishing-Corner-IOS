//
//  MyAnnonceViewController.swift
//  FishingCornerIOS
//
//  Created by malek belayeb on 20/6/2021.
//

import UIKit

class MyAnnonceViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    var user : User? {
        
        return UserProvider.shared.getUser()
    }
    var annonces:[Annonce] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return annonces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyAnnonceTableViewCell",for: indexPath) as! MyAnnonceTableViewCell
   
        
        
        cell.titleAnnonce.text = self.annonces[indexPath.row].title!
        cell.priceAnnonce.text = self.annonces[indexPath.row].price! + " DT"
        cell.adressAnnonce.text = self.annonces[indexPath.row].adress!
        
        
        let url = Constants.URL_IMAGE_ANNONCE+self.annonces[indexPath.row].image!
            
        ImageLoader.shared.loadImage(identifier: ImageLoader.ANNONCE_IMAGE + self.annonces[indexPath.row].idannonce!.description, url: url, completion: {image in
            
            cell.imageAnnonce.image = image
                        
        })

        
        
     return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
     
        AnnonceController.shared.getAllAnnonces(successHandler: {
            
            annonces in
            
            self.annonces = annonces.filter{$0.user!.iduser! == self.user?.iduser!}
            
            self.myAnnonceTableVIew.reloadData()
            
        }, errorHandler: {
            
            
        })
        
    }
    
    
    @IBOutlet weak var myAnnonceTableVIew: UITableView!
    
    
    static func Instanciate() -> MyAnnonceViewController{
       
        let storyboard = UIStoryboard(name: "MyAnnonceStoryboard", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "MyAnnonceViewController") as! MyAnnonceViewController
        
        return viewController
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
            
            let label = UILabel()
            label.frame = CGRect.init(x: 8, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
            
            label.text = "My Offer (" + self.annonces.count.description + ")"
            label.font = UIFont(name: "Roboto-Bold", size: 18)

            headerView.addSubview(label)
            
            return headerView
        }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 50
        }
    
  
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
         
            
            AnnonceController.shared.deleteAnnonce(idannonce: self.annonces[indexPath.row].idannonce!.description, successHandler: {
                
                self.annonces.remove(at: indexPath.row)
                self.myAnnonceTableVIew.deleteRows(at: [indexPath], with: .fade)
                
            }, errorHandler: {
                
                
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.myAnnonceTableVIew.register(UINib.init(nibName: "MyAnnonceTableViewCell", bundle: nil), forCellReuseIdentifier: "MyAnnonceTableViewCell")
        
        
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
