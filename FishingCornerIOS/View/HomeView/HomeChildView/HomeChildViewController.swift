//
//  HomeChildViewController.swift
//  FishingCornerIOS
//
//  Created by malek belayeb on 18/6/2021.
//

import UIKit

class HomeChildViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
 
    
    var annonces :[Annonce] = []
    
    @IBOutlet weak var annoneTableView: UITableView!
    
    lazy var parentNavigationItem : UINavigationItem? = self.tabBarController?.navigationItem
    
    static func Instanciate() -> HomeChildViewController{
       
        let storyboard = UIStoryboard(name: "HomeChildStoryboard", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "HomeChildViewController") as! HomeChildViewController

        return viewController
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    override func viewWillAppear(_ animated: Bool) {

        setupTopBar()
        
        
        AnnonceController.shared.getAllAnnonces(successHandler: {
            
            annoncesList in

            self.annonces = annoncesList
            self.annoneTableView.reloadData()
            
            
        }, errorHandler: {
            
            
        })

    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
            
            let label = UILabel()
            label.frame = CGRect.init(x: 8, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
            
            label.text = "Our Fishing Equipment (" + self.annonces.count.description + ")"
            label.font = UIFont(name: "Roboto-Bold", size: 18)

            headerView.addSubview(label)
            
            return headerView
        }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 50
        }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let annonce = self.annonces[indexPath.row]
        
        self.present(AnnonceDetailViewController.Instanciate(annonce: annonce), animated: true, completion: nil)
        
    }
    
    func setupTopBar()
    {
                
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        navigationController?.navigationBar.barTintColor = UIColor(named: "Color 1")
        
        navigationController?.navigationBar.isTranslucent = false
        
        let addIcon = UIImage(systemName: "plus")
            
        let add = UIBarButtonItem(image: addIcon, style: .plain, target: self, action: #selector(onAddTapped))
            
        let compteIcon = UIImage(systemName: "person.fill")
            
        let compte = UIBarButtonItem(image: compteIcon, style: .plain, target: self, action: #selector(onProfileTapped))
        
        compte.tintColor = UIColor.white
        add.tintColor = UIColor.white

        
        let label = UILabel()
        
        label.text = "Fishing Corner"
        label.font = UIFont(name: "Roboto-Bold", size: 24)
        label.textColor = .white

        parentNavigationItem?.rightBarButtonItems = [add,compte]
        
        parentNavigationItem?.titleView = label
        
        parentNavigationItem?.setHidesBackButton(true, animated:false)

    }
        
    
    @objc func onAddTapped()
    {

        self.navigationController?.pushViewController(AddAnnonceViewController.Instanciate(), animated: true)

    }
    
    @objc func onProfileTapped()
    {

        self.navigationController?.pushViewController(ProfileViewController.Instanciate(), animated: true)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.annonces.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnnonceTableViewCell",for: indexPath) as! AnnonceTableViewCell
        
        cell.annonceTitle.text = self.annonces[indexPath.row].title!
        cell.annoncePrice.text = self.annonces[indexPath.row].price! + " DT"
        cell.annoncePhoneNumber.text = self.annonces[indexPath.row].user?.phone
        cell.annonceAdress.text = self.annonces[indexPath.row].adress!
        
        
        let url = Constants.URL_IMAGE_ANNONCE+self.annonces[indexPath.row].image!
            
        ImageLoader.shared.loadImage(identifier: ImageLoader.ANNONCE_IMAGE + self.annonces[indexPath.row].idannonce!.description, url: url, completion: {image in
            
            cell.annonceImage.image = image
                        
        })
        
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.annoneTableView.register(UINib.init(nibName: "AnnonceTableViewCell", bundle: nil), forCellReuseIdentifier: "AnnonceTableViewCell")
        
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

}
