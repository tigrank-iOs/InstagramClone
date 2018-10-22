//
//  MediaCell.swift
//  Instagram
//
//  Created by Тигран on 10/10/2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import UIKit

public class MediaCell: UITableViewCell {
	
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
}
