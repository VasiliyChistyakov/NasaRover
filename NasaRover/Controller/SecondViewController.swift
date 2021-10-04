//
//  SecondViewController.swift
//  NasaRover
//
//  Created by Чистяков Василий Александрович on 01.10.2021.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var imageSecVc: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var photoGallery: Photo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = photoGallery.imgSrc
        NetworkingManager.shared.fecthImage(urlString: image) { model in
            DispatchQueue.main.async {
                self.imageSecVc.image = model
            }
        }
        self.nameLabel.text = photoGallery.camera.name
        self.dataLabel.text = photoGallery.rover.launchDate
        self.descriptionLabel.text = photoGallery.camera.fullName
    }
}


