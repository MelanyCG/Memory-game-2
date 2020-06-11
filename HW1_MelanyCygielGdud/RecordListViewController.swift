import UIKit
import MapKit

class RecordListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
    @IBOutlet weak var record_LST_winners: UITableView!
    @IBOutlet weak var map__MKV: MKMapView!
    
    let cellIdentifier = "record_cell"
    let dataIdentifier = "Key"
    var playerArr:[Player] = [Player]()
    var thePlayer: Player = Player()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTable()
        checkLogicArray()
    }
    
    func initTable() {
        record_LST_winners.delegate = self
        record_LST_winners.dataSource = self
        record_LST_winners.reloadData()
    }
    
    // Mark player location on map
    func markLocationInMap(player: Player) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D.init(latitude: player.playerLocationLat, longitude: player.playerLocationLat)
        map__MKV.addAnnotation(annotation)
        annotation.title = player.playerName
    }
    
    // Read the list of players and write a new player if the array isnt empty
    func checkLogicArray() {
        self.playerArr = readPlayerArray()

        if !thePlayer.playerName.isEmpty {
            self.playerArr.append(thePlayer)
            self.playerArr = sortArray()
            writePlayerToLocalStorage(arrToStore: self.playerArr)
        }
    }
    
    // Sort the players array - top 10 list.
    func sortArray() -> [Player] {
        self.playerArr = self.playerArr.sorted(by: { (player1, player2) -> Bool in
            return player1.playerScore < player2.playerScore
        })
        if self.playerArr.count > 10 {
            self.playerArr.removeLast()
        }
        return self.playerArr
    }
    
    func showPlayersLocationOnMap() {
        for player in self.playerArr {
            markLocationInMap(player: player)
        }
    }
    
    // Read players from data
    func readPlayerArray() -> [Player] {
        if let data = UserDefaults.standard.data(forKey: dataIdentifier){
            do{
                let decoder = JSONDecoder()
                self.playerArr = try decoder.decode([Player].self, from: data)
                return self.playerArr
            }catch{
                print("Error in reading the data")
            }
        }
        return [Player]()
    }
    
    // Write players to data
    func writePlayerToLocalStorage(arrToStore: [Player]) {
        do{
            let encoder = JSONEncoder()
            let data = try encoder.encode(arrToStore)
            UserDefaults.standard.set(data, forKey: dataIdentifier)
            self.playerArr = readPlayerArray()
        }catch{
            print("Error in storage the data")
        }
    }
    
    // Table view count
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerArr.count
    }
    
    // Cell on table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MyCustomCell? = self.record_LST_winners.dequeueReusableCell(withIdentifier: cellIdentifier) as? MyCustomCell
        cell?.nameLabel.text = String(playerArr[indexPath.row].playerName)
        cell?.scoreLabel.text = String(playerArr[indexPath.row].playerScore)
        cell?.locationLabel.text = String(playerArr[indexPath.row].playerDate)
        showPlayersLocationOnMap()
        
        return cell!
    }
    
}





