//
//  User.swift
//  Instagram
//
//  Created by Тигран on 13/09/2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import Foundation

protocol UserDelegate {
	func userCreated(_ user: User)
}

class User {
	let id: Int
	let userName: String
	let profilePictureURL: String
	let fullName: String
	let bio: String?
	let website: String?
	let mediaCount: Int
	let followsCount: Int
	let followedByCount: Int
	
	private var delegate: UserDelegate?
	
	convenience init(response: [String : Any], delegate: UserDelegate) {
		self.init(response: response)
		self.delegate = delegate
		self.delegate?.userCreated(self)
	}
	
	init(response: [String : Any]) {
		id = Int(response["id"] as! String)!
		userName = response["username"] as! String
		profilePictureURL = response["profile_picture"] as! String
		fullName = response["full_name"] as! String
		bio = response["bio"] as? String
		website = response["website"] as? String
		if let counts = response["counts"] as? [String : Int] {
			mediaCount = counts["media"]!
			followsCount = counts["follows"]!
			followedByCount = counts["followed_by"]!
		} else {
			mediaCount = 0
			followsCount = 0
			followedByCount = 0
		}
	}
}
