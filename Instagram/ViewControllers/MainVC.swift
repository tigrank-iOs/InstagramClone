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
	
	// MARK: - VCLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
		
		if let token = Credential.token {
			APIManager.shared.load(Constants.API.host + Constants.API.body + Constants.API.token + token) { (json) in
				if let result = (json as? [String : Any])?["data"] as? [String : Any] {
					let _ = User(response: result, delegate: self)
				}
			}
		}
    }
}

extension MainVC: UserDelegate {
	// MARK: - UserDelegate
	func userCreated(_ user: User) {
		DispatchQueue.main.async {
			self.userNameLabel.text = user.userName
		}
	}
	
	
}
