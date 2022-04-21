//
//  ImageSetter.swift
//  Projet9
//
//  Created by Raphaël Goupille on 17/09/2021.
//

import Foundation
import UIKit

struct ImageSetter {

static func setImage(weatherToDisplay: DisplayableWeather, imageView: UIImageView) {
    switch weatherToDisplay.id {
    case (WeatherId.thunderstorm):
        imageView.image = UIImage(named: "thunderstorm")
    case (WeatherId.showerRain):
        imageView.image = UIImage(named: "shower rain")
    case (WeatherId.rain):
            imageView.image = UIImage(named: "rain")
    case (WeatherId.snow):
        imageView.image = UIImage(named: "snow")
    case (WeatherId.otherShowerRain):
        imageView.image = UIImage(named: "shower rain")
    case (WeatherId.otherSnow):
        imageView.image = UIImage(named: "snow")
    case (WeatherId.mist):
        imageView.image = UIImage(named: "broken clouds")
    case (WeatherId.clearSky):
            imageView.image = UIImage(named: "clear sky")
    case (WeatherId.fewClouds):
            imageView.image = UIImage(named: "few clouds") 
    case (WeatherId.scatteredClouds):
        imageView.image = UIImage(named: "scattered clouds")
    case (WeatherId.brokenClouds):
        imageView.image = UIImage(named: "broken clouds")
    default :
        imageView.image = UIImage(named: "clear sky")
    }
}
    
}
