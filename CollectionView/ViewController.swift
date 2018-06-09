//
//  ViewController.swift
//  CollectionView
//
//  Created by Ngọc Anh on 6/6/18.
//  Copyright © 2018 Ngọc Anh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var images: [UIImage] = []
    
    let padding: CGFloat = 10
    var numberOfItems: CGFloat = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // su dung cho size giong nhau
        
        let width  = (view.frame.width - 2 * padding - (numberOfItems - 1) * padding)/numberOfItems
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = padding
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.scrollDirection = .vertical
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // su dung cho size khac nhau
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width  = (view.frame.width-20)/3
//        if indexPath.row % 2 == 0 {
//            return CGSize(width: width, height: width * 2)
//        }
//        return CGSize(width: width, height: width)
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == images.count {
            let cellAddNew = collectionView.dequeueReusableCell(withReuseIdentifier: "addcell", for: indexPath)
            return cellAddNew
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
            cell.imageView.image = images[indexPath.row]
            return cell
        }
    }
    // lay anh thu thu vien
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == images.count {
            print("add new image")
            let imagePickerControl = UIImagePickerController()
            imagePickerControl.delegate = self
            imagePickerControl.sourceType = .photoLibrary
            present(imagePickerControl, animated: true, completion: nil)
        }
    }

}
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            images.append(selectImage)
            collectionView.reloadData()
        }
        dismiss(animated: true, completion: nil)
    }
}


