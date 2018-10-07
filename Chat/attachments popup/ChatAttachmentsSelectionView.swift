//
//  ChatsAttachmentsSelectionView.swift
//  Dialog
//
//  Created by Kirill Dobryakov on 27/03/2017.
//  Copyright © 2017 Kirill Dobryakov. All rights reserved.
//

import UIKit

protocol UpdatePopupSizeDelegate {
    func updateSize(big: Bool);
}

class ChatAttachmentsSelectionView: UIView {

    var delegate: UpdatePopupSizeDelegate?
    
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!

    @IBAction func cameraPressed(_ sender: Any) {
    }
    @IBAction func galleryPressed(_ sender: Any) {
    }
    @IBAction func locationPressed(_ sender: Any) {
    }
    @IBAction func contactsPressed(_ sender: Any) {
    }
    
    @IBOutlet weak var photoHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        collectionView.register(ChatAttachmentPhotoCell.self, forCellWithReuseIdentifier: "ChatAttachmentPhotoCell")
        collectionView.register(UINib(nibName: "ChatAttachmentPhotoCell", bundle: nil), forCellWithReuseIdentifier: "ChatAttachmentPhotoCell")
    }
}



extension ChatAttachmentsSelectionView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatAttachmentPhotoCell", for: indexPath) as! ChatAttachmentPhotoCell
        cell.mainImageView.image = #imageLiteral(resourceName: "icbg")
        cell.selectedImageView.isHighlighted = selectedIndexes.contains(indexPath)
        return cell
    }
}


var selectedIndexes = [IndexPath]()

extension ChatAttachmentsSelectionView : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !selectedIndexes.contains(indexPath){
            selectedIndexes.append(indexPath)
            photoHeightConstraint.constant = 270
            cameraButton.setTitle("Отправить", for: .normal)
            UIView.animate(withDuration: 0.2, animations: { 
                self.layoutIfNeeded()
            })
            
        }
        else{
            cameraButton.setTitle("Камера", for: .normal)
            selectedIndexes = selectedIndexes.filter() {$0 != indexPath}
            photoHeightConstraint.constant = 100
            UIView.animate(withDuration: 0.2, animations: {
                self.layoutIfNeeded()
            })
            
            
        }
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        selectedIndexes = selectedIndexes.filter() {$0 != indexPath}
        collectionView.reloadData()
    }
}

extension ChatAttachmentsSelectionView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: collectionView.frame.size.height)
    }
}



