//
//  MainVC.swift
//  Instagram
//
//  Created by Тигран on 13/09/2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import UIKit
import SDWebImage

class MainVC: UIViewController {
	// MARK: - Outlets
	@IBOutlet weak var userImageView: UIImageView! {
		didSet {
			userImageView.layer.cornerRadius = userImageView.frame.size.width / 2
			userImageView.layer.masksToBounds = true
		}
	}
	@IBOutlet weak var publicationsLabel: UILabel!
	@IBOutlet weak var followsLabel: UILabel!
	@IBOutlet weak var followersLabel: UILabel!
	@IBOutlet weak var fullNameLabel: UILabel!
	@IBOutlet weak var bioLabel: UILabel!
	@IBOutlet weak var websiteLabel: UILabel!
	@IBOutlet weak var tableView: UITableView!
	
	
	// MARK: - Variables
	private var userManager: UserManager? {
		didSet {
			self.presentUser()
		}
	}
	
	private var user: User? {
		didSet {
			guard user != nil else { return }
			DispatchQueue.main.async {
				self.userManager = UserManager(self.user!)
			}
		}
	}
	
	private var media: [MediaProtocol] = []
	
	// MARK: - VCLifeCycle
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.delegate = self
		tableView.dataSource = self
		loadUser()
		loadMedia()
	}
	
	// MARK: - Functions
	private func loadUser() {
		APIManager.shared.getUser({ (user) in
			if let user = user {
				self.user = user
			}
		})
	}
	
	private func presentUser() {
		guard let userManager = userManager else { return }
		let userImageUrl = URL(string: userManager.getUserImageUrl())
		userImageView?.sd_setImage(with: userImageUrl, completed: nil)
		publicationsLabel.text = userManager.getUserPublicationsCount()
		followsLabel.text = userManager.getUserFollowsCount()
		followersLabel.text = userManager.getUserFollowersCount()
		fullNameLabel.text = userManager.getUserFullName()
		bioLabel.text = userManager.getUserBio()
		websiteLabel.text = userManager.getUserWebsite()
	}
	
	private func loadMedia() {
		APIManager.shared.getMedia { (media) in
			if let media = media {
				self.media = media
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			}
		}
	}
	
	// MARK: - Actions
	@IBAction func logoutButtonTapped(_ sender: UIBarButtonItem) {
		AuthorizationService().logout()
	}
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
	
	// MARK: - UITableViewDataSource
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return media.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.mediaCellId, for: indexPath) as! MediaCell
		cell.setupCell(with: media[indexPath.row])
		return cell
	}
}
