//
//  ViewController.swift
//  AppMap
//
//  Created by Virtual Machine on 14/06/22.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    let map = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addMapInView()
        map.delegate = self
        getPressedMarker()
        
    }
    
    func addMapInView(){
        view.addSubview(map)
        map.frame = view.bounds
    }
    
}

// MARK: - Marker in Map
extension ViewController {
    
    func getPressedMarker(){
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(getLocation))
        map.addGestureRecognizer(gestureRecognizer)
        map.isUserInteractionEnabled = true
    }
    
    @objc func getLocation(sender: UITapGestureRecognizer) {
        let locationInView = sender.location(in: map)
        let locationOnMap = map.convert(locationInView, toCoordinateFrom: map)
        alertManager(locationOnMap)
    }
    
    func alertManager(_ coordnate: CLLocationCoordinate2D) {
        
        //Create Alert
        let alert = UIAlertController(title: "Marcador", message: "Por favor insira os dados do marcador", preferredStyle: UIAlertController.Style.alert )
        //Button save and executing
        let save = UIAlertAction(title: "Save", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            let textField2 = alert.textFields![1] as UITextField
            if textField.text != "" && textField2.text != "" {
                
                let title = String(textField.text!)
                let subtitle = String(textField2.text!)
                
                self.addCustomPin(coordnate, title: title, subtitle: subtitle)
                
            } else {
                print("TF 1 is Empty...")
                print("TF 2 is Empty...")
            }
        }
        
        alert.addAction(save)
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.destructive) { (alertAction) in }
        alert.addAction(cancel)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Titulo"
            textField.textColor = .black
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Subtitulo"
            textField.textColor = .black
        }
        
        self.present(alert, animated:true, completion: nil)
    }
    
     private func addCustomPin(_ coordnate: CLLocationCoordinate2D, title: String, subtitle: String) {
        let pin = MKPointAnnotation()
        pin.coordinate = coordnate
        pin.title = title
        pin.subtitle = subtitle
        self.map.addAnnotation(pin)
     }
    
}


