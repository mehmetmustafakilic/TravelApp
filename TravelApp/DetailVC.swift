//
//  DetailVC.swift
//  TravelApp
//
//  Created by Mehmet Mustafa Kılıç on 4.10.2022.
//

import UIKit
import CoreData

class DetailVC: UIViewController {

    @IBOutlet weak var detailVCButton: UIButton!
    @IBOutlet private weak var detailCommit: UILabel!
    @IBOutlet private weak var detailName: UILabel!
    @IBOutlet private weak var detailCategory: UILabel!
    @IBOutlet private weak var imageDetail: UIImageView!
    
    var detailModel: ResponseModel?
    var model: [ResponseModel] = []
    var type: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cornerRadius()
        configureData()
    }

    func configureData() {
        let imageStr = detailModel?.image
        detailName.text = detailModel?.name
        detailCommit.text = detailModel?.commit
        detailCategory.text = detailModel?.catagory
        imageDetail.image = UIImage(named: imageStr!)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func detailButton(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newFavorite = NSEntityDescription.insertNewObject(forEntityName: "Favorites", into: context)
        
        //Attiributes
        
        newFavorite.setValue(detailName.text, forKey: "name")
        newFavorite.setValue(detailCommit.text, forKey: "commit")
        newFavorite.setValue(detailCategory.text, forKey: "category")
        newFavorite.setValue(UUID(), forKey: "id")
        let data = imageDetail.image!.jpegData(compressionQuality: 0.5)
        newFavorite.setValue(data, forKey: "image")
        
        do {
            try context.save()
            print("success")
            self.dismiss(animated: true, completion: nil)
            
        } catch {
            print("error")
        }
    }
    
    private func cornerRadius() {
        if #available(iOS 11.0, *) {
            imageDetail.clipsToBounds = false
            imageDetail.layer.cornerRadius = 34
            imageDetail.layer.maskedCorners = [.layerMaxXMaxYCorner,
                                               .layerMinXMaxYCorner]
        } else {
            let rectShape = CAShapeLayer()
            rectShape.bounds = imageDetail.frame
            rectShape.position = imageDetail.center
            rectShape.path = UIBezierPath(roundedRect: imageDetail.bounds,
                                          byRoundingCorners: [.bottomLeft, .bottomLeft],
                                          cornerRadii: CGSize(width: 20, height: 20)).cgPath
            imageDetail.layer.mask = rectShape
        }
    }
    
}

extension UIImageView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
