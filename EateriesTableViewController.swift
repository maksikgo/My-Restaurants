//
//  EateriesTableViewController.swift
//  Eateries
//
//  Created by Maksim Halubko on 29.01.22.
//

import UIKit

class EateriesTableViewController: UITableViewController {
    
    var restaurants:  [Restaurant] = [
    Restaurant(name: "Wood&Fire", type: "restaurant", location: "Minsk", image: "wood&fire.jpeg", isVisited: false),
    Restaurant(name: "Clever Irish Pub", type: "restaurant", location: "Minsk", image: "clever.png", isVisited: false),
    Restaurant(name: "Nova", type: "restaurant", location: "Minsk", image: "nova.png", isVisited: false),
    Restaurant(name: "Rich Cat", type: "restaurant", location: "Minsk", image: "cat.jpeg", isVisited: false),
    Restaurant(name: "X.O.", type: "restaurant", location: "Minsk", image: "xo.jpeg", isVisited: false)]

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 85
        tableView.rowHeight = UITableView.automaticDimension

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return restaurants.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EateriesTableViewCell
        cell.thumbnailImageView.image = UIImage(named: restaurants[indexPath.row].image)
        cell.thumbnailImageView.layer.cornerRadius = 32.5
        cell.thumbnailImageView.clipsToBounds = true
        cell.nameLabel.text = restaurants[indexPath.row].name
        cell.locationLabel.text = restaurants[indexPath.row].location
        cell.typeLabel.text = restaurants[indexPath.row].type
        
        cell.accessoryType = self.restaurants[indexPath.row].isVisited ? .checkmark : .none

        return cell
    }

//    THERE IS NO NEED TO USE THESE LINES OF CODE NOW
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let ac = UIAlertController(title: nil, message: "Choose your action", preferredStyle: .actionSheet)
//        let call = UIAlertAction(title: "Call +375(29)111-111\(indexPath.row)", style: .default) {
//        (action: UIAlertAction) -> Void in
//        let alertC = UIAlertController(title: nil, message: "Calling error", preferredStyle: .alert)
//        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alertC.addAction(ok)
//        self.present(alertC, animated: true, completion: nil)
//        }
//
//        let isVisitedTitle = self.restaurantIsVisited[indexPath.row] ? "I wasn't here" : "I was here"
//        let isVisited = UIAlertAction(title: isVisitedTitle, style: .default) { (action) in
//        let cell = tableView.cellForRow(at: indexPath)
//
//        self.restaurantIsVisited[indexPath.row] = !self.restaurantIsVisited[indexPath.row]
//            cell?.accessoryType = self.restaurantIsVisited[indexPath.row] ? .checkmark : .none
//        }
//
//        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//        ac.addAction(call)
//        ac.addAction(isVisited)
//        ac.addAction(cancel)
//
//        present(ac, animated: true, completion: nil)
//
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            self.restaurantImages.remove(at: indexPath.row)
//            self.restaurantNames.remove(at: indexPath.row)
//            self.restaurantIsVisited.remove(at: indexPath.row)
//        }
//        tableView.deleteRows(at: [indexPath], with: .fade)
//    }

    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let share = UITableViewRowAction(style: .default, title: "Share") {
            (action, indexPath) in
            let defaultText = "I am visiting a " + self.restaurants[indexPath.row].name
            if let image = UIImage(named: self.restaurants[indexPath.row].image) {
            let activityController = UIActivityViewController(activityItems: [defaultText, image], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
            }
        }
        
        let delete = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            self.restaurants.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        share.backgroundColor = .blue
        delete.backgroundColor = .red
        return [delete, share]
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let dvc = segue.destination as! EateryDetailViewController
                dvc.restaurant = self.restaurants[indexPath.row]
            }
        }
    }
    
    
    
}
