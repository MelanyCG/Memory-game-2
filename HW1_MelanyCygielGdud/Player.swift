import Foundation

class Player: Codable {
    
    var playerName = ""
    var playerScore = ""
    var playerDate = ""
    var playerLocationLng: Double = 0.0
    var playerLocationLat: Double = 0.0
    
    init(){}
    
    init(playerName: String , playerScore: String, playerDate: String, playerLocationLng: Double, playerLocationLat: Double){
        self.playerName = playerName
        self.playerScore = playerScore
        self.playerDate = playerDate
        self.playerLocationLat = playerLocationLat
        self.playerLocationLng = playerLocationLng
    }
}
