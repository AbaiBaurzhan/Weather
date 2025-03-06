//
//  TableViewController.swift
//  Weather
//
//  Created by Абай Бауржан on 22.12.2024.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD


class TableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var cityLabel: UILabel!
    
    var arrayWeather = [WeatherItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.delegate = self
        search.searchBar.placeholder = "Search city"
        navigationItem.searchController = search
        search.obscuresBackgroundDuringPresentation = false
        
        searchWeather(term: "Roma")
    }
    
    func searchWeather(term: String) {
        SVProgressHUD.show()

        let apiKey = "6d18a3d20b6bd8a808ef07149c815874"
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(term)&appid=\(apiKey)&units=metric&lang=ru"
        
        AF.request(url, method: .get).responseData { response in
            SVProgressHUD.dismiss()

            switch response.result {
            case .success(let data):
                let json = JSON(data)
                
                // Проверка кода ответа API
                if json["cod"].intValue != 200 {
                    self.showAlert(message: "Город не найден.")
                    return
                }
                
                let weather = WeatherItem(json: json)
                self.arrayWeather = [weather]
                
                DispatchQueue.main.async {
                    self.cityLabel.text = term.capitalized
                    self.tableView.reloadData()
                }

            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                self.showAlert(message: "Не удалось получить данные о погоде.")
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let city = searchBar.text, !city.trimmingCharacters(in: .whitespaces).isEmpty else {
            showAlert(message: "Пожалуйста, введите действительное название города.")
            return
        }
        
        arrayWeather.removeAll()
        tableView.reloadData()
        searchWeather(term: city)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayWeather.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherTableViewCell
        cell.setData(weather: arrayWeather[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
