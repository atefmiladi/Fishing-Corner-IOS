import UIKit

class EventController{
    
    
    static let shared: EventController = {
            let instance = EventController()
            return instance
        }()

    
    func getAllEvent(iduser:String,successHandler: @escaping (_ eventList: [Event]) -> (),errorHandler: @escaping () -> ())
    {
        
        EventService.shared.getEventList(iduser: iduser,successHandler: {
            
            events in
            
            successHandler(events)
        
        }, errorHandler: {
            
            
        })
    }
    
    func addEvent(event:Event?,image:UIImage,successHandler: @escaping () -> (),errorHandler: @escaping () -> ())
    {
        
        EventService.shared.addEvent(image: image, event: event, successHandler: {
            
            successHandler()
            
        }, errorHandler: {
            
            errorHandler()
            
        }, noResponseHandler: {
            
            errorHandler()
            
        })
        
    }
    
    
    func addParticipation(participation:Participation,interestDidCreated: @escaping () -> (),onGoingDidCreated: @escaping () -> (),participationDeleted: @escaping () -> (),errorHandler: @escaping () -> ())
    {
        
        EventService.shared.addParticipation(participation: participation, interestDidCreated: {
            
            interestDidCreated()
            
        }, onGoingDidCreated: {
            
            onGoingDidCreated()
            
        }, participationDeleted: {
            
            participationDeleted()
            
        }, errorHandler: {
            
            errorHandler()
            
        })
    }
    
    
    
    func deleteEvent(idevent:String,successHandler: @escaping () -> (),errorHandler: @escaping () -> ())
    {
        
        EventService.shared.deleteEvent(idevent: idevent, successHandler: {
          
            successHandler()
            
        }, errorHandler: {
            
            errorHandler()
            
        })
        
        
    }
    
    
}
