import UIKit



class AnnonceController {

    
    static let shared: AnnonceController = {
            let instance = AnnonceController()
            return instance
        }()
    
    func getAllAnnonces(successHandler: @escaping (_ anomalyList: [Annonce]) -> (),errorHandler: @escaping () -> ())
    {
        
        AnnonceService.shared.getAnnonceList(successHandler: {
            
            annonces in
            
            successHandler(annonces)
        
        }, errorHandler: {
            
            
        })
    }
    
    
    func addAnnonce(annonce:Annonce?,image:UIImage,successHandler: @escaping () -> (),errorHandler: @escaping () -> ())
    {
        
        AnnonceService.shared.addAnnonce(image: image, annonce: annonce, successHandler: {
                        
            successHandler()
            
        }, errorHandler: {
            
            errorHandler()
            
        }, noResponseHandler: {
            
            errorHandler()

        })
        
        
    }
    
    
    func deleteAnnonce(idannonce:String,successHandler: @escaping () -> (),errorHandler: @escaping () -> ())
    {
        
        AnnonceService.shared.deleteAnnonce(idannonce: idannonce, successHandler: {
          
            
            successHandler()
            
            
        }, errorHandler: {
            
            errorHandler()
            
        })
        
        
    }
    
    
    
}
