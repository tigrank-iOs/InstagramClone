//
//  CellSetuper.swift
//  Instagram
//
//  Created by Тигран on 22/10/2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import UIKit

public struct CellSetuper {
	
	private var cell: MediaCell!
	private var media: MediaProtocol!
	
	init(with cell: MediaCell, media: MediaProtocol) {
		self.cell = cell
		self.media = media
	}
	
	public func getCell() -> MediaCell {
		let userImageUrl = URL(string: media.user.pictureUrl)
		cell.userImageView.sd_setImage(with: userImageUrl, completed: nil)
		cell.usernameLabel.text = media.user.fullName
		if let location = media.location {
			cell.locationLabel.text = location["name"] as? String
		} else {
			cell.locationLabel.text = ""
		}
		let image = media.images["standard_resolution"]!
		let postImageUrl = URL(string: image.url)
		cell.postImageView.sd_setImage(with: postImageUrl, completed: nil)
		
		let desiredHeight = CGFloat(image.height) / CGFloat(image.width) * cell.bounds.width
		cell.postImageHeightCont.constant = desiredHeight
		
		cell.likesLabel.text = "Нравится \(media.likes)"
		if let caption = media.caption {
			let attributes = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12)]
			let attributedString = NSMutableAttributedString(string: media.user.username, attributes: attributes)
			
			let normalString = NSMutableAttributedString(string: " \(caption.text)")
			
			attributedString.append(normalString)
			cell.captionLabel.attributedText = attributedString
		} else {
			cell.captionLabel.text = ""
		}
		return cell
	}
	
}
