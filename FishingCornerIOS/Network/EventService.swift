import Alamofire



class EventService{
    
    static let shared: EventService = {
            let instance = EventService()
            return instance
        }()
    
    
    func getEventList(iduser:String,successHandler: @escaping (_ eventList: [Event]) -> (),errorHandler: @escaping () -> ())
    {
        
        let url = Constants.URL + "event/getAllEvent"
        
        let parameters = ["iduser":iduser]
        
        AF.request(url, method: .post,parameters: ((parameters as NSDictionary) as! Parameters)).validate().responseDecodable(of: [Event].self, decoder: JSONDecoder()) { apiResponse in
            
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
    
    
    func addParticipation(participation:Participation,interestDidCreated: @escaping () -> (),onGoingDidCreated: @escaping () -> (),participationDeleted: @escaping () -> (),errorHandler: @escaping () -> ())
    {
        
        let url = Constants.URL + "event/addOrDeleteParticipation"
        
        
        let parameters = ["iduser":participation.user!.iduser!.description,"idevent":participation.event!.idevent!.description,"type":participation.type!]
        
        AF.request(url, method: .post,parameters: ((parameters as NSDictionary) as! Parameters)).validate().response { apiResponse in
            
            guard apiResponse.response != nil else{
                
                errorHandler()
                return
            }
            
            switch apiResponse.response?.statusCode {
                
            case 202:
                    participationDeleted()
           
            case 200:
                interestDidCreated()
            
            case 201:
                onGoingDidCreated()
                
            case 500:
                errorHandler()
       
            default:

                errorHandler()
                
            }
            
        }
        
    }
    
    
    
    
    func deleteEvent(idevent:String,successHandler: @escaping () -> (),errorHandler: @escaping () -> ())
    {
        
        let url = Constants.URL + "event/deleteEvent"
        
        
        let parameters = ["idevent":idevent]
        
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
    
    
    func addEvent(image:UIImage,event:Event?,successHandler: @escaping () -> (),errorHandler: @escaping () -> (),noResponseHandler: @escaping () -> ())
    {
            
        let urlApi = Constants.URL + "event/addEvent"
        
        let headers: HTTPHeaders = [

            "Content-type": "multipart/form-data"
        ]
        
        var parameters = ["":""]
        
        if let e = event
        {
            
            parameters = ["title":e.title!,"description":e.description!,"iduser":e.user!.iduser!.description,"dateEvent":e.dateEvent!]
            
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
