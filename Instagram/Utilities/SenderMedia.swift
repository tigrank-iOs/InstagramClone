//
//  SenderMedia.swift
//  Instagram
//
//  Created by Тигран on 02/10/2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import Foundation

public protocol UserMedia {
	var username: String { get }
	var pictureUrl: String { get }
}

public class SenderMedia: UserMedia {
	private let owner: User
	
	init(_ owner: User) {
		self.owner = owner
	}
	
	public var username: String {
		return self.owner.userName
	}
	
	public var pictureUrl: String {
		return self.owner.profilePictureURL
	}
}
