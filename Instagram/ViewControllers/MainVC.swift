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
	var user: User? {
		didSet {
			guard user != nil else { return }
			DispatchQueue.main.async {
				self.userNameLabel.text = self.user?.userName
			}
		}
	}
	
	var tag: Tag? {
		didSet {
			guard tag != nil else { return }
			APIManager.shared.getTagedMedia(for: tag!) { (media, error) in
				if let media = media {
					print("\n==========Media for tag \(self.tag!.name)==========")
					print(media)
				}
				if !error.isEmpty {
					print(error)
				}
			}
		}
	}
	
	// MARK: - VCLifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
		loadUser()
		
		APIManager.shared.getMedia { (media, error) in
			if let media = media {
				print("\n==========Media for user \(self.user!.userName)==========")
				print(media)
			}
			if !error.isEmpty {
				print(error)
			}
		}
		
		APIManager.shared.getTags(for: "happynewyear") { (tags, error) in
			if let tags = tags {
				self.tag = tags.first
				
				print("\n==========Tags for happynewyear==========")
				for tag in tags {
					print(tag.name)
				}
			}
			if !error.isEmpty {
				print(error)
			}
		}
	}
	
	// MARK: - Functions
	fileprivate func loadUser() {
		APIManager.shared.getUser { (user, error) in
			if let user = user {
				self.user = user
			}
			if !error.isEmpty {
				print(error)
			}
		}
	}
}
