//
//  Esri.swift
//  ShowBuildingEsri
//
//  Created by Mohamed Ali on 23/11/2022.
//

import Foundation
import ArcGIS

class Esri {
    
    private var mapView: AGSMapView?
    
    init (mapView: AGSMapView) {
        self.mapView = mapView
    }
    
    // MARK: TODO: initialise new map
    func InitialiseMapView(ob: UIViewController,_ baseMap: AGSBasemapStyle) {
        
        let map = AGSMap(basemapStyle: baseMap) // .arcGISTopographic
        
        guard let mapView = mapView else {
            return
        }
        
        mapView.touchDelegate = ob as? AGSGeoViewTouchDelegate
        mapView.map = map
    }
    
    // MARK: TODO: This Method For Add Point to map.
    func addPointToMap (lati: Double, long: Double, data: [String: Any]) -> AGSGraphic {
        
        let point = AGSPoint(x: lati, y: long, spatialReference: .wgs84())
        
        let pointSymbol = AGSSimpleMarkerSymbol(style: .circle, color: .orange, size: 10.0)

        pointSymbol.outline = AGSSimpleLineSymbol(style: .solid, color: .blue, width: 2.0)

        pointSymbol.outline = AGSSimpleLineSymbol(style: .solid, color: .blue, width: 2.0)

        let pointGraphic = AGSGraphic(geometry: point, symbol: pointSymbol, attributes: data)

        return pointGraphic

    }
}
