//
//  BookmarksViewController.swift
//  TravelApp
//
//  Created by Mehmet Mustafa Kılıç on 3.10.2022.
//

import UIKit
import CoreData

class BookmarksViewController: UIViewController {
    
    @IBOutlet weak var bookmarksTableView: UITableView!
    
    var dataHotelList: [ResponseModel] = []
    var flightList: [ResponseModel] = []
    var type: String?
    
    var nameArray = [String]()
    var idArray = [UUID]()
    var imageArray = [UIImage]()
    var commitArray = [String]()
    var categoryArray = [String]()
    var bookmarkArray = [BookMarkItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        getData()

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getData()
        bookmarksTableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
        bookmarksTableView.reloadData()
    }
  
    
    func registerCell() {
        let nib = UINib(nibName: "DetailListTableViewCell", bundle: nil)
        bookmarksTableView.register(nib, forCellReuseIdentifier: "DetailListTableViewCell")
    }
    
    func getData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                if let name = result.value(forKey: "name") as? String {
                    if let id = result.value(forKey: "id") as? UUID {
                        if let imageData = result.value(forKey: "image") as? Data {
                            if let commit = result.value(forKey: "commit") as? String {
                                if let catagory = result.value(forKey: "category") as? String{
                                    let bookMarkItem = BookMarkItem(id: id, name: name, image: UIImage(data: imageData)!, commit: commit, catagory: catagory)
                                    bookmarkArray.append(bookMarkItem)
                                
                                }
                            }
                        }
                    }
                }
                self.bookmarksTableView.reloadData()
                
            }
        } catch {
            print("error")
        }
    }
}

extension BookmarksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarkArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailListTableViewCell", for: indexPath) as! DetailListTableViewCell
        let bookmark = bookmarkArray[indexPath.row]
        cell.detailListCellName.text = bookmark.name
        cell.detailsListCellCommit.text = bookmark.commit
        cell.detailListCellimage.image = bookmark.image
        
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt  indexPath: IndexPath) {
        if editingStyle == .delete {
            let bookmark = bookmarkArray[indexPath.row]
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
            let idString = bookmark.id!.uuidString
            
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject]  {
                        if let id = result.value(forKey: "id") as? UUID{
                            
                            if id == bookmark.id{
                                context.delete(result)
                                bookmarkArray.remove(at: indexPath.row)
                                self.bookmarksTableView.reloadData()
                                
                                do{
                                    try context.save()
                                }catch{
                                    print("error")
                                }
                                break
                            }
                        }
                    }
                }
            } catch {
                print("error")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let removeVC = storyboard.instantiateViewController(withIdentifier: "removeVC") as? removeVC {
            removeVC.modalPresentationStyle = .fullScreen
            removeVC.detailModell = dataHotelList[safe: indexPath.row]
            removeVC.nameStr = bookmarkArray[indexPath.row].name
            removeVC.categoryStr =  bookmarkArray[indexPath.row].catagory
            removeVC.imageStr =  bookmarkArray[indexPath.row].image
            removeVC.commitStr =  bookmarkArray[indexPath.row].commit
            removeVC.indexpath = indexPath
            self.present(removeVC, animated:true, completion:nil)
          
        }
        
    }
}

