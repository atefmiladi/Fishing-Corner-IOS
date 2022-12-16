import Foundation


class Weather :Codable{
    
    
    var main:main?
    var wind:wind?
    
    struct main:Codable {
       var temp: Float?
       var feels_like: Float?
        var temp_min: Float?
        var temp_max: Float?
        var pressure: Float?
        var humidity : Float?
        var sea_level: Float?
        var grnd_level: Float?
    }
    
    struct wind:Codable {
        
       var speed: Float?
       var deg : Float?
       var gust: Float?
        
    }
   
    
}
