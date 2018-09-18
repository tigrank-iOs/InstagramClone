//
//  Media.swift
//  Instagram
//
//  Created by Тигран on 18/09/2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import Foundation

public enum MediaTypes {
	case photo, video
}

public protocol MediaProtocol {
	var id: String { get }
	var user: User { get }
	var images: [String : Photo]? { get }
	var caption: Caption? { get }
	var userHasLiked: Bool { get }
	var likes: Int { get }
	var tags: [String?] { get }
	var filter: String { get }
	var comments: Int { get }
	var type: MediaTypes { get }
	var link: String { get }
	var location: [String : Any]? { get }
	var usersInPhoto: [[String? : Any?]] { get }
}

public struct Image: MediaProtocol {
	public var id: String
	public var user: User
	public var images: [String : Photo]?
	public var caption: Caption?
	public var userHasLiked: Bool
	public var likes: Int
	public var tags: [String?]
	public var filter: String
	public var comments: Int
	public var type: MediaTypes = .photo
	public var link: String
	public var location: [String : Any]?
	public var usersInPhoto: [[String? : Any?]]
	
	init(response: [String : Any]) {
		id = response["id"] as! String
		user = User(response: response["user"] as! [String : Any])
		for data in response["images"] as! [String : Any] {
			images?[data.key] = Photo(data: data.value as! [String : Any])
		}
		caption = Caption(data: response["caption"] as! [String : Any])
		userHasLiked = response["user_has_liked"] as! Bool
		likes = (response["likes"] as! [String : Any])["count"] as! Int
		tags = response["tags"] as! [String]
		filter = response["filter"] as! String
		comments = (response["comments"] as! [String : Any])["count"] as! Int
		link = response["link"] as! String
		location = response["location"] as? [String : Any]
		usersInPhoto = response["users_in_photo"] as! [[String : Any]]
	}
}

public struct Video: MediaProtocol {
	public var id: String
	public var user: User
	public var images: [String : Photo]?
	public var caption: Caption?
	public var userHasLiked: Bool
	public var likes: Int
	public var tags: [String?]
	public var filter: String
	public var comments: Int
	public var type: MediaTypes = .photo
	public var link: String
	public var location: [String : Any]?
	public var usersInPhoto: [[String? : Any?]]
	
	public var videos: [String : VideoModel]?
	
	init(response: [String : Any]) {
		id = response["id"] as! String
		user = User(response: response["user"] as! [String : Any])
		for data in response["images"] as! [String : Any] {
			images?[data.key] = Photo(data: data.value as! [String : Any])
		}
		caption = Caption(data: response["caption"] as! [String : Any])
		userHasLiked = response["user_has_liked"] as! Bool
		likes = (response["likes"] as! [String : Any])["count"] as! Int
		tags = response["tags"] as! [String]
		filter = response["filter"] as! String
		comments = (response["comments"] as! [String : Any])["count"] as! Int
		link = response["link"] as! String
		location = response["location"] as? [String : Any]
		usersInPhoto = response["users_in_photo"] as! [[String : Any]]
		
		for data in response["videos"] as! [String : Any] {
			videos?[data.key] = VideoModel(data: data.value as! [String : Any])
		}
	}
}

public struct Photo {
	var width: Int
	var height: Int
	var url: String
	
	init(data: [String : Any]) {
		width = data["width"] as! Int
		height = data["height"] as! Int
		url = data["url"] as! String
	}
}

public struct Caption {
	var id: Int
	var text: String
	var user: User
	
	init(data: [String : Any]) {
		id = Int(data["id"] as! String)!
		text = data["text"] as! String
		user = User(response: data["from"] as! [String : Any])
	}
}

public struct VideoModel {
	var width: Int
	var height: Int
	var url: String
	var id: Int
	
	init(data: [String : Any]) {
		width = data["width"] as! Int
		height = data["height"] as! Int
		url = data["url"] as! String
		id = Int(data["id"] as! String)!
	}
}
