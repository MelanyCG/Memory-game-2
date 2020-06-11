import UIKit

class OpenViewController: UIViewController {
    var game4X4 = ViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startGame4X4ButtunClick(_ sender: Any) {
        self.performSegue(withIdentifier: "goToGame4X4Controller", sender: nil)
    }
    

    @IBAction func recordListButtunClick(_ sender: Any) {
        self.performSegue(withIdentifier: "goToRecordListController", sender: nil)
    }
    
    
    @IBAction func startGame4X6ButtonClick(_ sender: Any) {
        self.performSegue(withIdentifier: "goTo4X6GameController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToGame4X4Controller"){
        }
        
        if(segue.identifier == "goTo4X6GameController"){
            let theArray = segue.destination as! ViewController
            theArray.fruitsArray = [#imageLiteral(resourceName: "food"), #imageLiteral(resourceName: "cherry"), #imageLiteral(resourceName: "grapes"), #imageLiteral(resourceName: "apple"), #imageLiteral(resourceName: "banana"), #imageLiteral(resourceName: "pineapple"), #imageLiteral(resourceName: "orange"), #imageLiteral(resourceName: "strawerry"), #imageLiteral(resourceName: "pear-1"), #imageLiteral(resourceName: "granade"), #imageLiteral(resourceName: "redApple"), #imageLiteral(resourceName: "lemon"), #imageLiteral(resourceName: "food"), #imageLiteral(resourceName: "cherry"), #imageLiteral(resourceName: "grapes"), #imageLiteral(resourceName: "apple"), #imageLiteral(resourceName: "banana"), #imageLiteral(resourceName: "pineapple"), #imageLiteral(resourceName: "orange"), #imageLiteral(resourceName: "strawerry"), #imageLiteral(resourceName: "pear-1"), #imageLiteral(resourceName: "granade"), #imageLiteral(resourceName: "redApple"), #imageLiteral(resourceName: "lemon")]
        }
        
    }

    
}

