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
	
	// MARK: - VCLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
		
		if let token = Credential.token {
			APIManager.shared.load(Constants.API.host + Constants.API.body + Constants.API.token + token) { (json) in
				if let result = (json as? [String : Any])?["data"] as? [String : Any] {
					let user = User(response: result)
					self.user = user
				}
			}
		}
    }
}
