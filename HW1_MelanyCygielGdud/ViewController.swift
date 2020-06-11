import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var movesCounter_Label: UILabel!
    @IBOutlet weak var clock_Label: UILabel!
        
    // Variables
    var fruitsArray = [#imageLiteral(resourceName: "food"), #imageLiteral(resourceName: "cherry"), #imageLiteral(resourceName: "grapes"), #imageLiteral(resourceName: "apple"), #imageLiteral(resourceName: "banana"), #imageLiteral(resourceName: "pineapple"), #imageLiteral(resourceName: "orange"), #imageLiteral(resourceName: "strawerry"), #imageLiteral(resourceName: "food"), #imageLiteral(resourceName: "cherry"), #imageLiteral(resourceName: "grapes"), #imageLiteral(resourceName: "apple"), #imageLiteral(resourceName: "banana"), #imageLiteral(resourceName: "pineapple"), #imageLiteral(resourceName: "orange"), #imageLiteral(resourceName: "strawerry")]
    var firstCardClicked, secondCardClicked: UIButton?
    var firstImage, secondImage: UIImage!
    var tagNumberOfCard: Int = 0
    var counterTotalMoves: Int = 1
    var timer: Timer?
    var time: Int = 0
    var counterFinish: Int = 0
    var playerArray:[Player] = [Player]()
    var player = Player()
    var locationManager: CLLocationManager!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locatioManagerInit()
        randomCardsForGame()
        startTimer()
    }
    
    // Mix the cards on the board
    func randomCardsForGame() {
        fruitsArray.shuffle()
    }
    
    // Location
    func locatioManagerInit() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "goBackToOpenView", sender: nil)
    }
    
    // Click card function
    @IBAction func cardClicked(_ sender: UIButton) {
        //show the number of moves in screen
        movesCounter_Label.text = String("Moves: \(counterTotalMoves)")
        
        if (firstCardClicked == nil) {
            firstCardClicked = sender
            firstImage =  showImageForCard(buttonClicked: sender)
        } else if (secondCardClicked == nil && sender.tag != firstCardClicked?.tag){
            secondCardClicked = sender
            secondImage = showImageForCard(buttonClicked: sender)
            twoCardsShownInBoard(card1: firstCardClicked!, card2: secondCardClicked!, name1: firstImage, name2: secondImage)
        }
    }
    
    // Display the image on the board by using the image tag and return the image
    func showImageForCard(buttonClicked: UIButton) -> UIImage {
        var currentCard: UIImage!
        tagNumberOfCard = buttonClicked.tag
        buttonClicked.setBackgroundImage(nil, for: .normal)
        buttonClicked.setImage( fruitsArray[tagNumberOfCard], for: .normal)
        flipCardAnimation(buttonToFlip: buttonClicked)
        currentCard = buttonClicked.imageView!.image
        return currentCard
    }
    
    // Make an animation to turn on a card
    func flipCardAnimation(buttonToFlip: UIButton) {
        UIView.transition(with: buttonToFlip, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
     
    // Performs the appropriate action acording to the match
    func twoCardsShownInBoard(card1: UIButton, card2: UIButton, name1: UIImage, name2: UIImage) {
        let ifMatch : Bool = checkMatchBetweenTwoCards(image1: name1, image2: name2)
        if(ifMatch == true){
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.removeCards(card1: card1, card2: card2)
                self.resetVariables()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.turnOverCards(card1: card1, card2: card2)
                self.resetVariables()
            }
        }
        counterTotalMoves += 1
    }
    
    func resetVariables(){
        firstCardClicked = nil
        secondCardClicked = nil
    }

    // Check if the cards have the same image
    func checkMatchBetweenTwoCards(image1 : UIImage , image2 : UIImage)->Bool{
        if(image1 == image2) {
            return true
        } else {
            return false
        }
    }
    
    // Delete cards from board
    func removeCards(card1 : UIButton , card2 : UIButton){
        card1.alpha = 0.0
        card2.alpha = 0.0
        // check if the game is over
        counterFinish += 2
        if(counterFinish == fruitsArray.count) {
            finishGame()
        }
    }
    
    // Turn back the cards
    func turnOverCards(card1 : UIButton , card2 : UIButton){
        card1.setImage(nil, for: .normal)
        card2.setImage(nil, for: .normal)
        card1.setBackgroundImage(#imageLiteral(resourceName: "vegetarian"), for: .normal)
        card2.setBackgroundImage(#imageLiteral(resourceName: "vegetarian"), for: .normal)
        flipCardAnimation(buttonToFlip: card1)
        flipCardAnimation(buttonToFlip: card2)
    }
    
    // Initialize timer
    private func startTimer() {
        self.time = 0
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    // Promots the timer
    @objc func updateTimer() {
        self.clock_Label.text = ("Timer: \(self.timeFormatted(self.time))") // will show timer
        if time >= 0 {
            time += 1
        } else {
            if let timer = self.timer {
                timer.invalidate()
                self.timer = nil
            }
        }
    }
    
    // Time Format
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // Alert message for finishing the game
    func finishGame() {
        timer?.invalidate()
        let alert = UIAlertController(title: "Game Over! ", message: "Enter your name: ", preferredStyle: .alert)
        alert.addTextField {
            (textField) in
            textField.text = ""
        }
    
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            self.player.playerName = String(Optional(alert?.textFields![0].text! ?? "")!)
            if self.player.playerName.isEmpty{
                self.player.playerName = "unknown"
            }
            self.player.playerScore = self.timeFormatted(self.time-1)
            self.player.playerDate = self.getCurrentDate()
            self.performSegue(withIdentifier: "passFinalData", sender: self)
            }))

        self.present(alert, animated: true, completion: nil)
    }
    
    // Date format
    func getCurrentDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let current_date = dateFormatter.string(from: date)
        return current_date
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "passFinalData"){
            let passPlayer = segue.destination as! RecordListViewController
            passPlayer.thePlayer = player
        }
    }
}

extension ViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            self.player.playerLocationLat = lat
            self.player.playerLocationLng = lon
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error in location: \(error)")
    }
}


