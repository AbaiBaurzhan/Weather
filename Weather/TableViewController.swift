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
        
        searchWeather(term: "London")
    }
    
    func searchWeather(term: String) {
        SVProgressHUD.show()

        let url = "https://goweather.herokuapp.com/weather/\(term)"
        AF.request(url, method: .get).responseData { response in
            SVProgressHUD.dismiss()

            switch response.result {
            case .success(let data):
                if response.response?.statusCode == 200 {
                    let json = JSON(data)
                    let weather = WeatherItem(json: json)
                    self.arrayWeather = [weather]
                    
                    DispatchQueue.main.async {
                        self.cityLabel.text = term.capitalized
                        self.tableView.reloadData()
                    }
                } else {
                    self.showAlert(message: "Город не найден.")
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
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayWeather.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherTableViewCell

        // Configure the cell...

        cell.setData(weather: arrayWeather[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
