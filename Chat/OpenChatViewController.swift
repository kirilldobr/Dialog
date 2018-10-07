//
//  OpenChatViewController.swift
//  Dialog
//
//  Created by Kirill Dobryakov on 4.08.18.
//  Copyright © 2017 Kirill Dobryakov. All rights reserved.
//

import UIKit

class OpenChatViewController: UIViewController {

    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var bottomConstraint2: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageInputView: UITextView!
    @IBOutlet weak var messageInputTextViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imageHeightConstraint: UIImageView!
    @IBOutlet weak var editingView: UIView!
    
    var items = [CustomizableActionSheetItem]()
    let sampleViewItem = CustomizableActionSheetItem()
    
    var cellsAreEditing = false
    var selectedCells = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurateInputTextView()
        
        setupAttachmentsPopup()
        
        setupMainTableView()
        
        setupNavigationController()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        
        setupButton()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
setupButton()
    }

    func setupButton(){
        let button = UIBarButtonItem()
        button.title = ""
        button.style = .plain
        navigationItem.backBarButtonItem = button
        
        self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
    }
    
    func showMoreInfo(){
        performSegue(withIdentifier: "settings", sender: self)
    }

    func editMessages(){
        cellsAreEditing = true
        
        view.endEditing(true)
        
        editingView.isHidden = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Отмена", style: .done, target: self, action: #selector(cancelEdit))
        setupButton()
        for i in 0..<19{
            if let cell = (tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? BasicChatCell){
                cell.leadingConstraint?.constant = cellsAreEditing ? 46 : 16
                 cell.leadingMyMessageConstraint?.constant = cellsAreEditing ? 15 : -15
            }
        }
        UIView.animate(withDuration: 0.2) {
            self.tableView.layoutIfNeeded()
            
        }
    }
    
    func cancelEdit(){
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "moreBarButton"), landscapeImagePhone: #imageLiteral(resourceName: "moreBarButton"), style: .plain, target: self, action: #selector(showMoreInfo))
        setupButton()
        cellsAreEditing = false
        
        editingView.isHidden = true
        
        for i in 0..<19{
            if let cell = (tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? BasicChatCell){
                cell.leadingConstraint?.constant = cellsAreEditing ? 46 : 16
                cell.leadingMyMessageConstraint?.constant = cellsAreEditing ? 15 : -15
            }
        }
        UIView.animate(withDuration: 0.2) {
            self.tableView.layoutIfNeeded()
            
        }
    }
    
    func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue{
            bottomConstraint.constant = keyboardSize.height
            bottomConstraint2.constant = keyboardSize.height
            UIView.animate(withDuration: 0.2, animations:{
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func keyboardWillHide(_ notification: Notification){
        if ((notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            bottomConstraint.constant = 0
            bottomConstraint2.constant = 0
            UIView.animate(withDuration: 0.2, animations:{
                self.view.layoutIfNeeded()
            })
        }
    }
    
    //MARK: - Private
    
    private func setupAttachmentsPopup(){
        let sampleView = ChatAttachmentsSelectionView.loadFromNibNamed(nibNamed: "ChatAttachmentsSelectionView") as! ChatAttachmentsSelectionView
        let sampleViewItem = CustomizableActionSheetItem()
        sampleView.delegate = self
        sampleViewItem.type = .view
        sampleViewItem.view = sampleView
        sampleViewItem.height = 334
        items.append(sampleViewItem)
        
        //TODO: разобраться с появлением попапа, TODO: не работает смена шрифта
        //closeItem.height = 57
        let closeItem = CustomizableActionSheetItem()
        closeItem.type = .button
        closeItem.label = "Отмена"
        closeItem.font = UIFont(name: "SFUIDisplay-Bold", size: 20)
        closeItem.textColor = UIColor.black
        closeItem.selectAction = { (actionSheet: CustomizableActionSheet) -> Void in
            actionSheet.dismiss()
        }
        items.append(closeItem)
        
    }
    
    private func setupNavigationController(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "moreBarButton"), landscapeImagePhone: #imageLiteral(resourceName: "moreBarButton"), style: .plain, target: self, action: #selector(showMoreInfo))
    
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 480, height: 44))
        label.numberOfLines = 2
        label.text =  "Чат"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "SFUIText-Regular", size: 15)
        
        navigationItem.titleView = label
    }

    private func configurateInputTextView() {
        messageInputView.layer.borderColor = UIColor(colorLiteralRed: 223/255, green: 223/255, blue: 223/255, alpha: 1).cgColor
        messageInputView.layer.borderWidth = 1
        messageInputView.layer.cornerRadius = 4
        
        tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    private func setupMainTableView(){
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        tableView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(editMessages)))
    }
    
    
    //MARK: - Actions
    
    @IBAction func sendMessagePressed(_ sender: Any) { }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Удалить?", message:  "Вы действительно хотите удалить эти 20 сообщений?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Удалить", style: UIAlertActionStyle.destructive, handler: {(alert :UIAlertAction!) in
            alertController.dismiss(animated: true, completion: nil)
        })
        let cancelAction = UIAlertAction(title: "Отмена", style: UIAlertActionStyle.cancel, handler: {(alert :UIAlertAction!) in
            alertController.dismiss(animated: true, completion: nil)
        })
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func addAttachmentPressed(_ sender: Any) {
        view.endEditing(true)
        let actionSheet = CustomizableActionSheet()
        actionSheet.showInView((self.navigationController?.view)!, items: items)
    }
}


extension OpenChatViewController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat(MAXFLOAT)))
        var newFrame = textView.frame
        
        newFrame.size = CGSize.init(width: CGFloat(fmaxf(Float(newSize.width), Float(fixedWidth))), height: newSize.height)
        self.messageInputTextViewHeight.constant = newSize.height
        textView.frame = newFrame
        
        tableView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}



extension OpenChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      selectedCells[indexPath.row] = !selectedCells[indexPath.row]
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: BasicChatCell!
        
        if indexPath.row <= 10 {
            cell = self.tableView.dequeueReusableCell(withIdentifier: "InputTextMessageCell") as! InputTextMessageCell
            cell.transform = CGAffineTransform(scaleX: 1, y: -1);
            (cell as! InputTextMessageCell).messageLabel.text = "Тестовый текст на кучу кучу кучу строк траыфпыфап ыар ывр ывар ыкрп ыур уыр ыар вар выеер "
            
            
        } else if indexPath.row == 11 {
            let cell:OutputTextMessageCell = self.tableView.dequeueReusableCell(withIdentifier: "OutputTextMessageCell") as! OutputTextMessageCell
            cell.transform = CGAffineTransform(scaleX: 1, y: -1);
            cell.messageLabel.text = "Тестовый текст на кучу кучу кучу строк траыфпыфап ыар ывр ывар ыкрп ыур уыр ыар вар выеер "
            return cell
        } else if indexPath.row == 12 {
            cell = self.tableView.dequeueReusableCell(withIdentifier: "OutputTextMessageCell") as! OutputTextMessageCell
            cell.transform = CGAffineTransform(scaleX: 1, y: -1);
            (cell as! OutputTextMessageCell).messageLabel.text = "Чуть чуть "
          
        } else if indexPath.row > 12 && indexPath.row < 18 {
            cell = self.tableView.dequeueReusableCell(withIdentifier: "InputTextMessageCell") as! InputTextMessageCell
            cell.transform = CGAffineTransform(scaleX: 1, y: -1);
            (cell as! InputTextMessageCell).messageLabel.text = "Тестовый текст на кучу кучу кучу строк траыфпыфап ыар ывр ывар ыкрп ыур уыр ыар вар выеер "
        
            
        } else if indexPath.row == 18 {
            cell = self.tableView.dequeueReusableCell(withIdentifier: "InputImageCell") as! InputImageCell
            cell.transform = CGAffineTransform(scaleX: 1, y: -1)
            let messageImage = #imageLiteral(resourceName: "icbg")
            
        
            if let cell = cell as? InputImageCell
            {
                cell.imageWidthConstraint.constant = view.frame.width * 0.7
                
                cell.imageHeightConstraint.constant = messageImage.size.height / (messageImage.size.width / cell.imageWidthConstraint.constant)
                
                cell.messageImageView.image = messageImage
            }
            
            


        } else if indexPath.row == 19 {
            cell = self.tableView.dequeueReusableCell(withIdentifier: "InputImageCell") as! InputImageCell
            cell.transform = CGAffineTransform(scaleX: 1, y: -1);
            let messageImage = #imageLiteral(resourceName: "flowerTest")
            
         
            
            
            if let cell = cell as? InputImageCell
            {

            cell.imageHeightConstraint.constant = messageImage.size.height / (messageImage.size.width / cell.imageWidthConstraint.constant)
            cell.messageImageView.image = messageImage
            
            }

        } else {
            return UITableViewCell()
        }
        
        cell.layoutIfNeeded()
        cell.selectionImageView.isHighlighted = selectedCells[indexPath.row]
        print(cell.selectionImageView.isHighlighted)
        cell.leadingConstraint?.constant = cellsAreEditing ? 46 : 16
        cell.leadingMyMessageConstraint?.constant = cellsAreEditing ? 15 : -15
        return cell
        
    }
}

extension OpenChatViewController : UpdatePopupSizeDelegate{
    func updateSize(big: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.sampleViewItem.height = big ? 324 : 224
        }
    }
}
