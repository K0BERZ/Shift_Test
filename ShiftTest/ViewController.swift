//
//  ViewController.swift
//  ShiftTest
//
//  Created by Константин Березовский on 2023-04-24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var competitions = [Competition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Fetch competitions from server
        fetchCompetitions()
        
        // Set table view data source and delegate
        tableView.dataSource = self
        tableView.delegate = self
        
        let alert = UIAlertController(title: "Успешно", message: "Регистрация завершина!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        
    }
    
    @IBAction func welcomeButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: "Привет, \(currentUser)!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return competitions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompetitionCell", for: indexPath) as! CompetitionCell
        
        let competition = competitions[indexPath.row]
        cell.competitionNameLabel.text = competition.name
        cell.startEndTimeLabel.text = "\(competition.start_time) - \(competition.end_time)"
        
        return cell
    }
    
    
    private func fetchCompetitions() {
        let url = URL(string: "https://kontests.net/api/v1/all")!
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print("Error fetching competitions: \(error)")
                return
            }
            
            guard let data = data else {
                print("No data received from server")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let competitions = try decoder.decode([Competition].self, from: data)
                
                DispatchQueue.main.async {
                    self?.competitions = competitions
                    self?.tableView.reloadData()
                }
            } catch let error {
                print("Error decoding competitions: \(error)")
            }
        }
        
        task.resume()
    }
}
