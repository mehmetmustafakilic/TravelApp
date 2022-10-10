//
//  BookMarkItem.swift
//  TravelApp
//
//  Created by Mehmet Mustafa Kılıç on 10.10.2022.
//

import Foundation
import UIKit

class BookMarkItem {
    
    var id: UUID?
    var name: String?
    var image: UIImage?
    var commit: String?
    var catagory: String?
    
    init(id: UUID, name: String, image: UIImage, commit: String, catagory: String) {
        self.id = id
        self.name = name
        self.image = image
        self.commit = commit
        self.catagory = catagory
    }
}
