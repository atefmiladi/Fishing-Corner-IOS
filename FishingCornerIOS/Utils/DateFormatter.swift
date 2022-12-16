import Foundation



extension Date{
    
    
    func setDateForMysql()
    {
        
        
    }
    
 
    
    
}


class DateManager{
    
    
    
   static func getDateFromMysql(date:String)->Date?
    {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        let stringDate = date
        
        if let date = dateFormatter.date(from: stringDate) {

            return date
        }
    
        return nil
    }
    
    
    
    
    static func setDateForMysql(date:Date)->String?
     {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return dateFormatter.string(from: date)

    }
    
    static func getFormatEventDate(date:Date)->String?
     {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "EEEE, MMM, yyyy, HH:mm"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        return dateFormatter.string(from: date)

    }
    
    
}
