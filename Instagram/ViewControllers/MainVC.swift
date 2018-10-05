//
//  MainVC.swift
//  Instagram
//
//  Created by Тигран on 13/09/2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
	// MARK: - Outlets
	@IBOutlet weak var userNameLabel: UILabel!
	
	// MARK: - Variables
	var userManager: UserManager? {
		didSet {
			self.userNameLabel.text = userManager!.getUserName()
		}
	}
	
	var user: User? {
		didSet {
			guard user != nil else { return }
			DispatchQueue.main.async {
				self.userManager = UserManager(self.user!)
			}
		}
	}
	
	var tag: Tag? {
		didSet {
			guard tag != nil else { return }
			APIManager.shared.getMedia(for: tag!) { (media) in
				if let media = media {
					print("\n==========Media for tag \(self.tag!.name)==========")
					print(media)
				}
			}
		}
	}
	
	// MARK: - VCLifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
		loadUser()
		APIManager.shared.getMedia { (media) in
			if let media = media {
				print("\n==========Media for user \(self.user!.userName)==========")
				print(media)
			}
		}
		
		APIManager.shared.getTags(for: "happynewyear") { (tags) in
			if let tags = tags {
				self.tag = tags.first
				
				print("\n==========Tags for happynewyear==========")
				for tag in tags {
					print(tag.name)
				}
			}
		}
	}
	
	// MARK: - Functions
	fileprivate func loadUser() {
		APIManager.shared.getUser({ (user) in
			if let user = user {
				self.user = user
			}
		})
	}
}
