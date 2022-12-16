import Alamofire



class AnnonceService{
    
    static let shared: AnnonceService = {
            let instance = AnnonceService()
            return instance
        }()
    
    func getAnnonceList(successHandler: @escaping (_ anomalyList: [Annonce]) -> (),errorHandler: @escaping () -> ())
    {
        
        let url = Constants.URL + "annonce/getAllAnnonce"
        
        AF.request(url, method: .get).validate().responseDecodable(of: [Annonce].self, decoder: JSONDecoder()) { apiResponse in
            
            guard apiResponse.response != nil else{
                
                errorHandler()
                return
            }
            
            switch apiResponse.response?.statusCode {
                
                case 200:
                    successHandler(try! apiResponse.result.get())

                    
                case 500:
                    print(apiResponse.response?.statusCode)

                    errorHandler()
           
            default:
                print(apiResponse.response?.statusCode)

                errorHandler()
                
            }
            
        }
        
    }
    
    
    
    func deleteAnnonce(idannonce:String,successHandler: @escaping () -> (),errorHandler: @escaping () -> ())
    {
        
        let url = Constants.URL + "annonce/deleteAnnonce"
        
        let parameters = ["idannonce":idannonce]
        
        AF.request(url, method: .post,parameters: ((parameters as NSDictionary) as! Parameters)).validate().response { apiResponse in
            
            guard apiResponse.response != nil else{
                
                errorHandler()
                return
            }
            
            switch apiResponse.response?.statusCode {
                
            case 200:
                successHandler()
                
            case 500:
                errorHandler()
       
            default:

                errorHandler()
                
            }
            
        }
        
    }
    
    func addAnnonce(image:UIImage,annonce:Annonce?,successHandler: @escaping () -> (),errorHandler: @escaping () -> (),noResponseHandler: @escaping () -> ())
    {
            
        let urlApi = Constants.URL + "annonce/addAnnonce"
        
        let headers: HTTPHeaders = [

            "Content-type": "multipart/form-data"
        ]
        
        var parameters = ["":""]
        
        if let a = annonce
        {
            
            parameters = ["title":a.title!,"description":a.description!,"iduser":a.user!.iduser!.description,"price":a.price!,"adress":a.adress!]
            
        }
            
        AF.upload(
                
            multipartFormData: { multipartFormData in
                
                multipartFormData.append(image.jpegData(compressionQuality: 0.5)!, withName: "file" , fileName: "file.jpeg", mimeType: "image/jpeg")
               
                for (key, value) in parameters {

                    multipartFormData.append((value.data(using: .utf8))!, withName: key)

                }
            
            },to: urlApi, method: .post , headers: headers).response{ apiResponse in
                    
                        
                guard apiResponse.response != nil else{
                    
                    noResponseHandler()
                    return
                }
                    
                switch apiResponse.response?.statusCode {
                    
                    case 200:
                                            
                        successHandler()
        
                    case 500:
                        
                        errorHandler()
               
                default:
                
                    print("error")
                    errorHandler()
                    
                }
                    
        }
        
    }
    
    
}
