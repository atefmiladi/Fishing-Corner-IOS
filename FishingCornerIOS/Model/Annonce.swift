import Foundation



class Annonce:Codable {
    
    var idannonce:Int?
    var title:String?
    var price:String?
    var adress: String?
    var image:String?
    var description:String?
    var created_at:String?
    var user:User?
}
