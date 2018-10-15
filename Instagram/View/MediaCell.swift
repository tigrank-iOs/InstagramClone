//
//  MediaCell.swift
//  Instagram
//
//  Created by Тигран on 10/10/2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import UIKit

class MediaCell: UITableViewCell {
	
	// MARK: - Outlets
	@IBOutlet weak var userImageView: UIImageView! {
		didSet {
			userImageView.layer.cornerRadius = userImageView.frame.size.width / 2
			userImageView.layer.masksToBounds = true
		}
	}
	@IBOutlet weak var usernameLabel: UILabel!
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var postImageView: UIImageView!
	@IBOutlet weak var likesLabel: UILabel!
	@IBOutlet weak var captionLabel: UILabel!
	@IBOutlet weak var postImageHeightCont: NSLayoutConstraint!
	
	// MARK: - Functions
	public func setupCell(with media: MediaProtocol) {
		let userImageUrl = URL(string: media.user.pictureUrl)
		userImageView.sd_setImage(with: userImageUrl, completed: nil)
		usernameLabel.text = media.user.fullName
		if let location = media.location {
			locationLabel.text = location["name"] as? String
		} else {
			locationLabel.text = ""
		}
		let image = media.images["standard_resolution"]!
		let postImageUrl = URL(string: image.url)
		postImageView.sd_setImage(with: postImageUrl, completed: nil)
		
		let desiredHeight = CGFloat(image.height) / CGFloat(image.width) * self.bounds.width
		postImageHeightCont.constant = desiredHeight
		
		likesLabel.text = "Нравится \(media.likes)"
		if let caption = media.caption {
			let attributes = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12)]
			let attributedString = NSMutableAttributedString(string: media.user.username, attributes: attributes)
			
			let normalString = NSMutableAttributedString(string: " \(caption.text)")
			
			attributedString.append(normalString)
			captionLabel.attributedText = attributedString
		} else {
			captionLabel.text = ""
		}
	}
}
