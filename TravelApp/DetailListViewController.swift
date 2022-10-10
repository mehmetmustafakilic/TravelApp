//
//  DetailListViewController.swift
//  TravelApp
//
//  Created by Mehmet Mustafa Kılıç on 4.10.2022.
//

import UIKit

class DetailListViewController: UIViewController {

    @IBOutlet weak var detailListName: UILabel!
    @IBOutlet private weak var detailListTableView: UITableView!
    
    var dataHotelList: [ResponseModel] = []
    var flightList: [ResponseModel] = []
    var type: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailListTableView.register(UINib(nibName: "DetailListTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailListTableViewCell")
        
        detailListTableView.delegate = self
        detailListTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DetailListViewController{
    func regiterCell() {
       // detailListTableView.regiter()
        
    }

    
}

extension DetailListViewController: UITableViewDelegate, UITableViewDataSource {
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type == "Hotel" {
            return dataHotelList.count
        } else {
            return flightList.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC {
            detailVC.modalPresentationStyle = .fullScreen
            if type == "Hotel" {
                print(dataHotelList[indexPath.row])
                detailVC.detailModel = dataHotelList[indexPath.row]
            } else {
                print(flightList[indexPath.row])
                detailVC.detailModel = flightList[indexPath.row]
            }
            self.present(detailVC, animated:true, completion:nil)
            
            }
        
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailListTableViewCell", for: indexPath) as! DetailListTableViewCell
        if type == "Hotel" {
            detailListName?.text = "Hotels"
            let imageStr = dataHotelList[indexPath.row].image
            cell.detailListCellimage.image = UIImage(named: imageStr)
            cell.detailListCellName.text =  dataHotelList[indexPath.row].name
            cell.detailsListCellCommit.text = dataHotelList[indexPath.row].commit
            return cell
        } else if type == "Flight"{
            detailListName?.text = "Flights"
            let imageStr = flightList[indexPath.row].image
            cell.detailListCellimage.image = UIImage(named: imageStr)
            cell.detailListCellName.text =  flightList[indexPath.row].name
            cell.detailsListCellCommit.text = flightList[indexPath.row].commit
            return cell
        }
        else{
            print("error")
            return cell
        }
    }
}
