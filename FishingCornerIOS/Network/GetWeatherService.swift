import Alamofire


class GetWeatherService{
    
   
    
    static let shared: GetWeatherService = {
            let instance = GetWeatherService()
            return instance
        }()
    
    
    func getCurrentWeather(address:String,successHandler: @escaping (_ weather: Weather) -> (),errorHandler: @escaping () -> ())
    {
        
        let url = "http://api.openweathermap.org/data/2.5/weather?q=" + address + "&appid=2a6082063b20670b537018cecde1ba35&units=metric"
        
        AF.request(url, method: .get).validate().responseDecodable(of: Weather.self, decoder: JSONDecoder()) { apiResponse in
            
            guard apiResponse.response != nil else{
                
                errorHandler()
                return
            }
            
            switch apiResponse.response?.statusCode {
                
                case 200:
                    successHandler(try! apiResponse.result.get())

                    
                case 500:

                    errorHandler()
           
            default:

                errorHandler()
                
            }
            
        }
        
    }
    
    
}
