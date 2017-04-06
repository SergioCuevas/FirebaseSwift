//
//  MapViewController.swift
//  MapsFirebase
//
//  Created by DAM on 28/3/17.
//  Copyright © 2017 Stucom. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps
import GooglePlaces


class MapViewController: UIViewController, UISearchBarDelegate , LocateOnTheMap , GMSAutocompleteFetcherDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var TITULO: UINavigationBar!
    
    let locationManager = CLLocationManager()
    let stdZoom: Float = 12
    var didFindMyLocation = false
    var searchResultController: SearchResultsController!
    var resultsArray = [String]()
    var gmsFetcher: GMSAutocompleteFetcher!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        GMSServices.provideAPIKey("AIzaSyBe5jVDQMu0P_e2b6vTyReiqDKukFWPjec")
        
        locationManager.requestWhenInUseAuthorization()
        self.mapView.isMyLocationEnabled = true
        self.mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
     
    }
    override func viewDidAppear(_ animated: Bool) {
        
      
        self.view.addSubview(self.mapView)
        searchResultController = SearchResultsController()
        searchResultController.delegate = self
        gmsFetcher = GMSAutocompleteFetcher()
        gmsFetcher.delegate = self


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buscador(_ sender: Any) {
        
        let searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchBar.delegate = self
        
        
        
        self.present(searchController, animated:true, completion: nil)

        
    }

    func locateWithLongitude(_ lon: Double, andLatitude lat: Double, andTitle title: String) {
        
        
        
        DispatchQueue.main.async { () -> Void in
            
            let position = CLLocationCoordinate2DMake(lat, lon)
            let marker = GMSMarker(position: position)
            
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 10)
            self.mapView.camera = camera
            
            marker.title = "Address : \(title)"
            
            marker.map = self.mapView

        }
    }
    public func didFailAutocompleteWithError(_ error: Error) {

    }
    public func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        
        for prediction in predictions {
            
            if let prediction = prediction as GMSAutocompletePrediction!{
                self.resultsArray.append(prediction.attributedFullText.string)
            }
        }
        self.searchResultController.reloadDataWithArray(self.resultsArray)

        print(resultsArray)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.resultsArray.removeAll()
        gmsFetcher?.sourceTextHasChanged(searchText)
        
        
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {

            locationManager.startUpdatingLocation()

            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
            mapView.settings.indoorPicker = true
        }
    }
    
    // 6
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            

            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            

            locationManager.stopUpdatingLocation()
        }
        
    }

    
    

}
