import CoreData
import UIKit

class UserProvider{
    
    var context: NSManagedObjectContext{
       let appDelegate = UIApplication.shared.delegate as! AppDelegate
       return appDelegate.persistentContainer.viewContext
    }
    
    static let shared: UserProvider = {
            let instance = UserProvider()
            return instance
        }()
    
    func addUser(user:User)
    {
        
        let entity = NSEntityDescription.entity(forEntityName: "UserSession", in : context)
        
        let record = NSManagedObject(entity: entity!, insertInto: context)
        
        record.setValue(Int32(user.iduser!), forKey: "iduser")
        
        record.setValue(user.email ?? "", forKey: "email")
        
        record.setValue(user.firstname ?? "", forKey: "firstname")
        
        record.setValue(user.lastname ?? "", forKey: "lastname")
        record.setValue(user.adress ?? "", forKey: "adress")
        record.setValue(user.phone ?? "", forKey: "phone")
        record.setValue(user.image ?? "", forKey: "image")

        
        do{
            try context.save()
            
        }catch let err as NSError {
            print("Could not save. \(err)")

        }
        
    }
    
    func getUser() -> User?
    {
        var user:User?
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserSession")
        
        var result = [NSManagedObject]()
        
        do {
            
              let records = try context.fetch(fetchRequest)

              if let result = records as? [NSManagedObject] {
                if result.count > 0 {
                   
                    user = User()
                    
                    user?.iduser = result.first?.primitiveValue(forKey: "iduser") as? Int
                    user?.firstname = result.first?.primitiveValue(forKey: "firstName") as? String
                    user?.lastname = result.first?.primitiveValue(forKey: "lastName") as? String
                 
                    user?.email = result.first?.primitiveValue(forKey: "email") as? String

                    user?.phone = result.first?.primitiveValue(forKey: "phone") as? String
                    user?.image = result.first?.primitiveValue(forKey: "image") as? String
                    user?.adress = result.first?.primitiveValue(forKey: "adress") as? String
                    
                    
                }
              }

          } catch {
              print("Unable to fetch.")
          }
        
        guard user != nil else{
            return nil
        }
        
        return user!
    }
    
    
    
    
    
    func updateUser(user:User)
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserSession")
        fetchRequest.predicate = NSPredicate(format: "iduser == %@",String(user.iduser!))
        
        do{
            
            let test = try context.fetch(fetchRequest)
            let objectUpdate = test[0] as! NSManagedObject
            
            objectUpdate.setValue(user.firstname!, forKey: "firstname")
            objectUpdate.setValue(user.lastname!, forKey:  "lastname")

            objectUpdate.setValue(user.phone!, forKey: "phone")
            objectUpdate.setValue(user.adress!, forKey: "adress")
            objectUpdate.setValue(user.image!, forKey: "image")

            do{
                    
                try context.save()
                
            }catch {
                print(error)
            }
            
        }catch {
            
            print(error)
            
        }
    
        
    }
    
    func deleteUser()
    {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserSession")

        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(batchDeleteRequest)

        } catch let err as NSError {
            print("Could not delete. \(err)")

        }
        
    }
    
    
    
    func clearCoreData()
    {
    
        deleteUser()
        
    }
    
}
