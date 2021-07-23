//
//  ViewController.swift
//  TableViewiOS
//
//  Created by Greek Mac Mini 5 on 22/07/21.
//

import UIKit

class ViewController: UIViewController {
    
    var eightThousandersPeaks = [String]()
    var eightThousandersPeaksHeight = [String]()
    @IBOutlet weak var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        eightThousandersPeaks += ["Mount Everest", "K2", "Kangchenjunga",
                                  "Lhotse","Makalu", "Cho Oyu",
                                  "Dhaulagiri","Manaslu", "Nanga Parbat",
                                  "Annapurna I", "Gasherbrum I", "Broad Peak",
                                  "Gasherbrum II", "Shishapangma"]
        
        eightThousandersPeaksHeight += ["8850", "8611", "8586",
                                        "8516", "8463", "8201",
                                        "8167", "8156", "8126",
                                        "8091", "8068", "8047",
                                        "8035", "8013"]
        
        self.tableView?.isEditing = false
    }
    
    @IBAction func editingToggle(_ sender: UIBarButtonItem) {
        self.tableView?.isEditing = !self.tableView!.isEditing
    }
}

extension ViewController {
    
    
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eightThousandersPeaks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Trick to get static variable in Swift
        struct staticVariable { static var tableIdentifier = "TableIdentifier" }
        
        var cell:UITableViewCell? = tableView.dequeueReusableCell(
            withIdentifier: staticVariable.tableIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: staticVariable.tableIdentifier)
        }
        
        cell?.textLabel?.text = eightThousandersPeaks[indexPath.row]
        cell?.detailTextLabel?.text = eightThousandersPeaksHeight[indexPath.row]
        let image = #imageLiteral(resourceName: "dot_green")
        cell?.imageView?.image = image
        let highlitedImage = #imageLiteral(resourceName: "dot_red")
        cell?.imageView?.highlightedImage = highlitedImage
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Get data from model
        let textLabel = eightThousandersPeaks[indexPath.row]
        let selectedCell = tableView.cellForRow(at: indexPath)
        // Get data from cell
        let detailTextLabel = selectedCell?.detailTextLabel?.text
        let message = "You selected \(textLabel) (\(detailTextLabel ?? "no detals"))"
        let alert = UIAlertController(title: "Information",
                                      message: message,
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Close",
                                         style: .default,
                                         handler: { _ in
                                            tableView.deselectRow(at: indexPath, animated: true)
                                         })
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let detailTextLabel = eightThousandersPeaksHeight[indexPath.row]
        
        if let height = Int(detailTextLabel) {
            if (height <= 8300) {
                print("\(height) is lower than 8500m limit")
                return nil
            }
            else {
                return indexPath
            }
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if let isEditing = self.tableView?.isEditing {
            return isEditing
        } else {
            return false
        }
        
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            eightThousandersPeaks.remove(at: indexPath.row)
//            eightThousandersPeaksHeight.remove(at: indexPath.row)
//            tableView.reloadData()
//        }
//    }
    //
    //    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
    //        return .none
    //    }
    //
    //    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
    //        return false
    //    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movePeakName = eightThousandersPeaks[sourceIndexPath.row]
        let movePeakHeight = eightThousandersPeaksHeight[sourceIndexPath.row]
        
        eightThousandersPeaks.remove(at: sourceIndexPath.row)
        eightThousandersPeaksHeight.remove(at: sourceIndexPath.row)
        
        eightThousandersPeaks.insert(movePeakName, at: destinationIndexPath.row)
        eightThousandersPeaksHeight.insert(movePeakHeight, at: destinationIndexPath.row)
        
        tableView.reloadData()
    }
    
    func dummyAction(title: String) {
        let alert = UIAlertController(title: "Information",
                                      message: title,
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Close",
                                         style: .default,
                                         handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let actionMove = UIContextualAction(style: .normal,
                                            title: "Move",
                                            handler: {
                                                (action: UIContextualAction,
                                                 view: UIView,
                                                 completionHandler:(Bool) -> Void) in
                                                
                                                self.dummyAction(title: "Move Action")
                                            })
        actionMove.backgroundColor = .blue
        
        let actionEdit = UIContextualAction(style: .normal,
                                            title: "Edit",
                                            handler: {
                                                (action: UIContextualAction,
                                                 view: UIView,
                                                 completionHandler:(Bool) -> Void) in
                                                
                                                self.dummyAction(title: "Edit Action")
                                            })
        
        actionEdit.backgroundColor = .green
        
        let configuration = UISwipeActionsConfiguration(actions: [actionMove, actionEdit])
        return configuration
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let actionDelete = UIContextualAction(style: .normal,
                                              title:  "Delete",
                                              handler: { (action:UIContextualAction, view:UIView, completionHandler:(Bool) -> Void) in
                                                
                                                self.dummyAction(title: "Delete action")
                                              })
        actionDelete.backgroundColor = .red
        
        let actionView = UIContextualAction(style: .normal,
                                            title:  "View",
                                            handler: { (action:UIContextualAction, view:UIView, completionHandler:(Bool) -> Void) in
                                                
                                                self.dummyAction(title: "View action")
                                            })
        actionView.backgroundColor = .yellow
        
        let configuration = UISwipeActionsConfiguration(actions: [actionDelete, actionView])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    
}

