//import UIKit
//import CoreLocation
//
//class Location: UIViewController {
//
//    var locationManager: CLLocationManager!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        locationManager = CLLocationManager()
//        locationManager.delegate = self
//
//        locationManager.requestWhenInUseAuthorization()
//
//    }
//    
////    @IBAction func getLocationPressed(_ sender: UIButton) {
////             locationManager.requestLocation()
////    }
//    
//}
//
//extension Location: CLLocationManagerDelegate {
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        print("didUpdateLocations")
//
//        if let location = locations.last {
//            locationManager.stopUpdatingLocation()
//            let lat = location.coordinate.latitude
//            let lon = location.coordinate.longitude
//            print("got Location: \(lat) \(lon)")
//        }
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Error=\(error)")
//    }
//}
