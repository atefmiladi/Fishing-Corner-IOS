import Alamofire

class UserService{
    
    
    static let shared: UserService = {
            let instance = UserService()
            return instance
        }()

    func addUser(image:UIImage,user:User,successHandler: @escaping (_ user: User) -> (),emailFound: @escaping () -> (),errorHandler: @escaping () -> ())
    {
    
        let urlApi = Constants.URL + "user/signup"
        
        let headers: HTTPHeaders = [

            "Content-type": "multipart/form-data"
        ]
        
        let parameters = ["email":user.email,"password":user.password,"firstname":user.firstname,"lastname":user.lastname]
     
        
    AF.upload(
            
        multipartFormData: { multipartFormData in
            
            multipartFormData.append(image.jpegData(compressionQuality: 0.5)!, withName: "file" , fileName: "file.jpeg", mimeType: "image/jpeg")
           
            for (key, value) in parameters {

                multipartFormData.append((value?.data(using: .utf8))!, withName: key)

            }
        
        },to: urlApi, method: .post , headers: headers).responseDecodable(of: User.self, decoder: JSONDecoder()) { apiResponse in
            
            
            guard apiResponse.response != nil else{
                
                errorHandler()
                return
            }
            
            switch apiResponse.response?.statusCode {
                
                case 200:
                    
                    successHandler(try! apiResponse.result.get())
                    
                case 203:
                    
                    emailFound()
                    
                case 500:
                    
                    errorHandler()
           
            default:
            
                errorHandler()
                
            }
        }
    
    }
    
    
    func getUser(parameter:[String:String],successHandler: @escaping (_ user: User) -> (),wrongCred: @escaping () -> (),errorHandler: @escaping () -> ())
    {
        
        let url = Constants.URL + "user/signin"
      
        AF.request(url, method: .post, parameters: ((parameter as NSDictionary) as! Parameters)).validate().responseDecodable(of: User.self, decoder: JSONDecoder()) { apiResponse in
            
            
            guard apiResponse.response != nil else{
                
                errorHandler()
                return
            }
            
            switch apiResponse.response?.statusCode {
                
                case 200:
                    
                    successHandler(try! apiResponse.result.get())
                    
                case 201:
                    
                    wrongCred()
                    
                case 500:
                    
                    errorHandler()
           
            default:
            
                errorHandler()
                
            }
            
        }
        
    }
    
    
    func updateUser(image:UIImage,user:User,successHandler: @escaping (_ user: User) -> (),errorHandler: @escaping () -> ())
    {
    
        let urlApi = Constants.URL + "user/updateUser"
        
        let headers: HTTPHeaders = [

            "Content-type": "multipart/form-data"
        ]

        
        let parameters = ["iduser":user.iduser!.description,"firstname":user.firstname,"lastname":user.lastname,"phone":user.phone!,"adress":user.adress!]
     
        
    AF.upload(
            
        multipartFormData: { multipartFormData in
            
            multipartFormData.append(image.jpegData(compressionQuality: 0.5)!, withName: "file" , fileName: "file.jpeg", mimeType: "image/jpeg")
           
            for (key, value) in parameters {

                multipartFormData.append((value?.data(using: .utf8))!, withName: key)

            }
        
        },to: urlApi, method: .post , headers: headers).responseDecodable(of: User.self, decoder: JSONDecoder()) { apiResponse in
            
            
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
