import UIKit


class UserController {
    
    
    static let shared: UserController = {
            let instance = UserController()
            return instance
        }()

    
    func addUser(user:User,didCreated: @escaping (_ user:User) -> (),emailAlreadyExist: @escaping () -> (),errorFound: @escaping () -> ())
    {
        
        UserService.shared.addUser(image:UIImage(named: "avatar-anonyme")!, user: user, successHandler: {
            user in
            
            didCreated(user)
            
        }, emailFound: {
            
            emailAlreadyExist()
            
        }, errorHandler: {
            
            errorFound()
            
        })
        
        
        
    }
    
    
    func loginUser(email:String,password:String,userDidFound: @escaping (_ user: User) -> (),wrongCredential: @escaping () -> (),errorHandler: @escaping () -> ())
    {
        
        UserService.shared.getUser(parameter: ["email":email,"password":password], successHandler: { user in
            
            UserProvider.shared.addUser(user: user)
            userDidFound(user)
            
        }, wrongCred: {
            
            wrongCredential()
            
        }, errorHandler: {
            
            errorHandler()
            
        })
        
    }
    
    
    func updateUser(user:User?,image:UIImage,successHandler: @escaping () -> (),errorHandler: @escaping () -> ())
    {
        
        
        if let u = user {
            
            UserService.shared.updateUser(image: image, user: u, successHandler: {
                user in
                
                UserProvider.shared.updateUser(user: user)
                
                successHandler()
                
            }, errorHandler: {
                
                
                errorHandler()
                
            })
            
        }
       
        
        
    }
    
    
}
