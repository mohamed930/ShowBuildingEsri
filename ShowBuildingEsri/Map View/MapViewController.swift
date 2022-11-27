//
//  ViewController.swift
//  ShowBuildingEsri
//
//  Created by Mohamed Ali on 22/11/2022.
//

import UIKit
import ArcGIS
import Alamofire

let api_key = "AAPK4e7cff31848045c08118ee9141e02188tPhTR2prd3o3aJcA3Ubbw2Zi2OghuIIw_LXulPMGPRNd1jIbeb-npYAYORM97hyz"
let apiLink = "http://122.0.0.27:3001/building" // "http://122.0.0.27:3001/building" // "http://192.168.1.52:3001/building"

class MapViewController: UIViewController {
    
    // MARK: TODO: intialise new IBOutlets here:-
    @IBOutlet weak var mapView: AGSMapView!
    var esri: Esri!
    
    // MARK: TODO: intialise new variables here:-
    private let graphicsOverlay = AGSGraphicsOverlay()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        esri = Esri(mapView: mapView)
        
        esri.InitialiseMapView(ob: self, .arcGISTopographic)
        GetBuilding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    // MARK: TODO: This Method For Load data from server
    func GetBuilding() {
        // Make request to server.
        AF.request(apiLink, method: .get).response { [weak self] response in
            guard let self = self else {return}
            
            guard let statusCode = response.response?.statusCode else { return }
            
            if statusCode == 200 {
                
                guard let jsonData = response.data else {
                    print("Failed in get")
                    return}
                
                // fetch data and decode it.
                guard let responseObj = try? JSONDecoder().decode(responseModel.self, from: jsonData) else {
                    print("Failed in decoder")
                    return }
                
                self.AddPointsToMap(responseData: responseObj)
            }
        }
    }
    
    // MARK: TODO: This Method For Add points to map.
    private func AddPointsToMap(responseData: responseModel) {
        // Add points in array of AGSGraphic
        var points = Array<AGSGraphic>()
        for i in responseData.building {
            let data = ["id": i.id, "name": i.name ?? "لم يتم التحديد","img-attach": "http://www.google.com/"] as [String : Any]
            points.append(self.esri.addPointToMap(lati: Double(i.location.long)!, long: Double(i.location.lati)!, data: data))
        }
        
        // Add data to graphics Overlay
        self.graphicsOverlay.graphics.addObjects(from: points)
        
        // Add graphics overlay to mapView
        self.mapView.graphicsOverlays.add(self.graphicsOverlay)
        
        // Set viewpoint to the point graphic geometry 32.2841,31.2565
        self.mapView.setViewpointCenter(AGSPoint(x: 32.2841, y: 31.2565, spatialReference: .wgs84()), scale: 70000.0, completion: nil)
    }
}

extension MapViewController: AGSGeoViewTouchDelegate, AGSPopupsViewControllerDelegate {
    func geoView(_ geoView: AGSGeoView, didTapAtScreenPoint screenPoint: CGPoint, mapPoint: AGSPoint) {
        geoView.identify(graphicsOverlay, screenPoint: screenPoint, tolerance: 12, returnPopupsOnly: false) { [weak self] result in
//            print("F: \(String(describing: result.graphics.first?.attributes["name"]))")
            
            guard let self = self else { return }
            
            guard let point = result.graphics.first else { return }
            
            let nextVc = self.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
            
            DetailsViewController.attributes = point.attributes
            
            self.present(nextVc, animated: true)
            
        }
    }
}
