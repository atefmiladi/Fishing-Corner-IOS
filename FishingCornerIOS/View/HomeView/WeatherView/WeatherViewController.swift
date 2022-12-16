import UIKit
import CoreLocation

class WeatherViewController: UIViewController ,CLLocationManagerDelegate{

    var locationManager: CLLocationManager?

    static func Instanciate() -> WeatherViewController{
       
        let storyboard = UIStoryboard(name: "WeatherStoryboard", bundle: .main)
        let viewController = storyboard.instantiateViewController(identifier: "WeatherViewController") as! WeatherViewController

        return viewController
    }
    
    @IBOutlet weak var tempMin: UILabel!
    @IBOutlet weak var humidity: UILabel!
    
    
    
    @IBOutlet weak var windGust: UILabel!
    @IBOutlet weak var windDeg: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var seaLevel: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var tempMax: UILabel!
    @IBOutlet weak var temp: UILabel!
    
    lazy var parentNavigationItem : UINavigationItem? = self.tabBarController?.navigationItem
    
    
    override func viewWillAppear(_ animated: Bool) {

        setupTopBar()
        
    /*
        
locationManager = CLLocationManager()

locationManager?.delegate = self

locationManager!.requestWhenInUseAuthorization()
locationManager!.requestAlwaysAuthorization()


let currLocation = getCurrentLocation()*/
        
    /*
if(currLocation != nil)
{
    let lat = currLocation?.coordinate.latitude.description
    let lon = currLocation?.coordinate.longitude.description



}*/

        
        
    }
    
    func setupTopBar()
    {

        navigationController?.setNavigationBarHidden(false, animated: false)
        
        navigationController?.navigationBar.barTintColor = UIColor(named: "Color 1")
        
        navigationController?.navigationBar.isTranslucent = false
        
        parentNavigationItem?.setHidesBackButton(true, animated:false)
        parentNavigationItem?.rightBarButtonItems = []
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    
    }
    
    
  /*  func getCurrentLocation()-> CLLocation?
    {
        
        if(self.locationManager?.authorizationStatus == .authorizedWhenInUse ||
            self.locationManager?.authorizationStatus == .authorizedAlways) {


            return locationManager?.location
            
        }else{
            
            return nil
        
        }
        
    }*/
    
    @IBOutlet weak var cityWeather: UITextField!
    
    @IBAction func getWeatherTapped(_ sender: Any) {
        
        if !cityWeather.text!.isEmpty
        {
            
            AlertView.showLoading(message:"Loading...", viewController: self)
            
            GetWeatherService.shared.getCurrentWeather(address:cityWeather.text!, successHandler: {
                
                weather in
                
                self.dismiss(animated: true, completion: {
                    
                    self.temp.text = weather.main?.temp?.description
                    self.tempMax.text = weather.main?.temp_max?.description
                    self.pressure.text = weather.main?.pressure?.description
                    self.seaLevel.text = weather.main?.sea_level?.description
                    self.windSpeed.text = weather.wind?.speed?.description
                    self.windDeg.text = weather.wind?.deg?.description
                    self.windGust.text = weather.wind?.gust?.description
                    self.humidity.text = weather.main?.humidity?.description
                    self.tempMin.text = weather.main?.temp_min?.description
                    
                })
                
            }, errorHandler: {
                
                
                self.dismiss(animated: true, completion: {
                    
                    let alert = UIAlertController(title: nil, message: "An error did occur, please contact your administrator !", preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                    
                    self.present(alert, animated: false, completion: nil)
                    
                })
                
                
            })
            
            
        }else{
            
            
            let alert = UIAlertController(title: nil, message: "All field are required !", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(alert, animated: false, completion: nil)
            
            
        }
        
        
        
        
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
