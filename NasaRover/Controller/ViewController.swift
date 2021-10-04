//
//  ViewController.swift
//  NasaRover
//
//  Created by Чистяков Василий Александрович on 26.09.2021.
//

import UIKit


class ViewController: UIViewController {
    
    let urlString = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2015-6-3&api_key=DEMO_KEY"
    //    let urlString = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=DEMO_KEY"
    
    let countCell = 3
    let offset:CGFloat = 2.0
    var arrayPhoto: Model!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        NetworkingManager.shared.fetchData(url: urlString) { [weak self] model in
            DispatchQueue.main.async {
                self?.arrayPhoto = model
                self?.collectionView.reloadData()
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrayPhoto?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        
        let image = arrayPhoto.photos[indexPath.row].imgSrc
        
        NetworkingManager.shared.fecthImage(urlString: image) { image in
            DispatchQueue.main.async {
                cell.photoNasa.image = image
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameCv = collectionView.frame
        
        let widthCell = frameCv.width / CGFloat(countCell)
        let heighCell = widthCell
        
        let spacing = CGFloat((countCell + 1)) * offset / CGFloat(countCell)
        
        return CGSize(width: widthCell - spacing , height: heighCell - (offset * 2))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SecondViewController", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SecondViewController" {
            let vc = segue.destination as! SecondViewController
            let indexPath = sender as! IndexPath
            
            let photo = arrayPhoto.photos[indexPath.row]
            vc.photoGallery = photo
        }
    }
}


