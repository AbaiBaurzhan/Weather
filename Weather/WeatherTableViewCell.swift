//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by Абай Бауржан on 22.12.2024.
//

import UIKit
import SDWebImage

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var windLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

    func setData(weather: WeatherItem) {
        temperatureLabel.text = weather.weatherTemperature
        windLabel.text = weather.weatherWind
        descriptionLabel.text = weather.weatherDescription
    }
}
