//
//  AmityMessageFileTableView.swift
//  AmityUIKit
//
//  Created by Mark on 14/6/2565 BE.
//  Copyright © 2565 BE Amity. All rights reserved.
//

import Foundation
//
//  AmityMessageAudioTableViewCell.swift
//  AmityUIKit
//
//  Created by Sarawoot Khunsri on 2/12/2563 BE.
//  Copyright © 2563 BE Amity. All rights reserved.
//

import UIKit
import AmitySDK

final class AmityMessageFileTableViewCell: AmityMessageTableViewCell {
    
    @IBOutlet private var fileImageView: UIImageView!
    @IBOutlet private var fileNameLabel: UILabel!
    @IBOutlet private var activityIndicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        fileImageView.image = AmityIconSet.Chat.iconPlay
    }
    
    func setupView() {
       
//        fileImageView.image = AmityIconSet.Chat.iconPlay
        fileNameLabel.textColor = AmityColorSet.baseInverse
        fileNameLabel.textAlignment = .left
        fileNameLabel.font = AmityFontSet.body
        
        activityIndicatorView.hidesWhenStopped = true
        
    }
    
    override func display(message: AmityMessageModel) {
        if !message.isDeleted {
            if message.isOwner {
                
                fileImageView.tintColor = AmityColorSet.baseInverse
                activityIndicatorView.style = .white
//                fileNameLabel.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 108
                switch message.syncState {
                case .syncing:
                    activityIndicatorView.startAnimating()
                case .synced, .default, .error:
                    fileImageView.image = AmityIconSet.File.iconFileDefault
                    fileNameLabel.text = message.object.getFileInfo()?.fileName
                    activityIndicatorView.stopAnimating()
                @unknown default:
                    break
                }
            } else {
                fileImageView.image = AmityIconSet.File.iconFileDefault
                fileNameLabel.text = message.object.getFileInfo()?.fileName
                fileNameLabel.textColor = AmityColorSet.base
                activityIndicatorView.style = .gray
//                fileNameLabel.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 160
            }
            
           
        }
        super.display(message: message)
    }
    
    override class func height(for message: AmityMessageModel, boundingWidth: CGFloat) -> CGFloat {
        let displaynameHeight: CGFloat = message.isOwner ? 0 : 22
        if message.isDeleted {
            return AmityMessageTableViewCell.deletedMessageCellHeight + displaynameHeight
        }
        return 90 + displaynameHeight
    }
    
}

extension AmityMessageFileTableViewCell  {
    @IBAction func openFile(_ sender: UIButton) {
        if !message.isDeleted && message.syncState == .synced {
//            sender.isEnabled = false
            screenViewModel.action.performCellEvent(for: .fileViewer(indexPath: indexPath))
           
        }
    }
}


   
