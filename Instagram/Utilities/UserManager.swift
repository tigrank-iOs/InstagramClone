//
//  UserManager.swift
//  Instagram
//
//  Created by Тигран on 05/10/2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import Foundation

public class UserManager {
	
	let user: User
	
	init(_ user: User) {
		self.user = user
	}
	
	public func getUserName() -> String {
		return self.user.userName
	}
}
