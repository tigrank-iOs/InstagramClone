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
	
	public func getUserFullName() -> String {
		return self.user.fullName
	}
	
	public func getUserImageUrl() -> String {
		return self.user.profilePictureURL
	}
	
	public func getUserPublicationsCount() -> String {
		return self.user.mediaCount.description
	}
	
	public func getUserFollowersCount() -> String {
		return self.user.followedByCount.description
	}
	
	public func getUserFollowsCount() -> String {
		return self.user.followsCount.description
	}
	
	public func getUserBio() -> String {
		guard let bio = self.user.bio else {
			return ""
		}
		return bio
	}
	
	public func getUserWebsite() -> String {
		guard let website = self.user.website else {
			return ""
		}
		return website
	}
}
