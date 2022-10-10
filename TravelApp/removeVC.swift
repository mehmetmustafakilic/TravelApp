//
//  removeVC.swift
//  TravelApp
//
//  Created by Mehmet Mustafa Kılıç on 10.10.2022.
//

import UIKit
import CoreData

class removeVC: UIViewController {

    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var removeCommit: UILabel!
    @IBOutlet weak var removeName: UILabel!
    @IBOutlet weak var removeCategory: UILabel!
    @IBOutlet weak var imageRemove: UIImageView!
    

    var imageStr: UIImage?
    var nameStr: String?
    var commitStr: String?
    var categoryStr: String?
    var indexpath: IndexPath = []
    
    var bookmarkArray = [BookMarkItem]()
    var detailModell: ResponseModel?
    var model: [ResponseModel] = []
    var type: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cornerRadius()
        configData()

        // Do any additional setup after loading the view.
    }
    
    func configData() {
        removeName.text = nameStr
        removeCommit.text = commitStr
        removeCategory.text = categoryStr
        imageRemove.image = imageStr
        
    }
    

    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func deleteFromCoreData(indexPath: IndexPath) {
        guard let task = Constants.fetchedRC?.object(at: indexPath) else { return }
        Constants.context.delete(task)
        Constants.appDelegate?.saveContext()
    }
    
    struct Constants {
        static var fetchedRC: NSFetchedResultsController<Favorites>?
        static var appDelegate = UIApplication.shared.delegate as? AppDelegate
        static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        static let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        
    }

    @IBAction func removeClicked(_ sender: Any) {
        do {
            let results = try Constants.context.fetch(Constants.fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject]  {
                    Constants.context.delete(result)
                
                    do{
                        try Constants.context.save()
                        dismiss(animated: true)
                    }catch{
                        print("error")
                    }
                    break
                    
                }
            }
        } catch {
            print("error")
        }
    }
    
    private func cornerRadius() {
        if #available(iOS 11.0, *) {
            imageRemove.clipsToBounds = false
            imageRemove.layer.cornerRadius = 34
            imageRemove.layer.maskedCorners = [.layerMaxXMaxYCorner,
                                               .layerMinXMaxYCorner]
        } else {
            let rectShape = CAShapeLayer()
            rectShape.bounds = imageRemove.frame
            rectShape.position = imageRemove.center
            rectShape.path = UIBezierPath(roundedRect: imageRemove.bounds,
                                          byRoundingCorners: [.bottomLeft, .bottomLeft],
                                          cornerRadii: CGSize(width: 20, height: 20)).cgPath
            imageRemove.layer.mask = rectShape
        }
    }
    
    
}


