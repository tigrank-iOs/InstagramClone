//
//  APIManager.swift
//  Instagram
//
//  Created by Тигран on 02/10/2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import Foundation

public class APIManager {
	private init() { }
	
	public static let shared: APIManager = APIManager()
	public typealias UserQueryResults = (User?) -> Void
	public typealias MediaQueryResults = ([MediaProtocol]?) -> Void
	public typealias TagQueryResults = ([Tag]?) -> Void
	
	private var user: User?
	
	public func getUser(_ completion: @escaping UserQueryResults) {
		QueryService.shared.get(entity: .user, for_lattitude: nil, longtitude: nil, name: nil, tag: nil) { (user, error) in
			if let user = user as? User {
				self.user = user
				completion(user)
			}
			if !(error.isEmpty) {
				print(error)
				completion(nil)
			}
		}
	}
	
	public func getMedia(_ completion: @escaping MediaQueryResults) {
		if user == nil {
			self.getUser { (user) in
				if let user = user {
					self.user = user
					self.makeMediaQuery(completion, for_lattitude: nil, longtitude: nil, name: nil, tag: nil)
				} else {
					completion(nil)
				}
			}
		} else {
			self.makeMediaQuery(completion, for_lattitude: nil, longtitude: nil, name: nil, tag: nil)
		}
	}
	
	public func getMedia(for lattitude: String, longtitude: String, _ completion: @escaping MediaQueryResults) {
		if user == nil {
			self.getUser { (user) in
				if let user = user {
					self.user = user
					self.makeMediaQuery(completion, for_lattitude: lattitude, longtitude: longtitude, name: nil, tag: nil)
				} else {
					completion(nil)
				}
			}
		} else {
			self.makeMediaQuery(completion, for_lattitude: lattitude, longtitude: longtitude, name: nil, tag: nil)
		}
	}
	
	public func getMedia(for tag: Tag, _ completion: @escaping MediaQueryResults) {
		if user == nil {
			self.getUser { (user) in
				if let user = user {
					self.user = user
					self.makeMediaQuery(completion, for_lattitude: nil, longtitude: nil, name: nil, tag: tag)
				} else {
					completion(nil)
				}
			}
		} else {
			self.makeMediaQuery(completion, for_lattitude: nil, longtitude: nil, name: nil, tag: tag)
		}
	}
	
	public func getTags(for name: String, _ completion: @escaping TagQueryResults) {
		QueryService.shared.get(entity: .tag, for_lattitude: nil, longtitude: nil, name: name, tag: nil) { (tags, error) in
			if let tags = tags as? [Tag] {
				completion(tags)
			}
			if !(error.isEmpty) {
				print(error)
				completion(nil)
			}
		}
	}
	
	private func makeMediaQuery(_ completion: @escaping MediaQueryResults, for_lattitude lattitude: String?, longtitude: String?, name: String?, tag: Tag?) {
		QueryService.shared.get(entity: .media, for_lattitude: lattitude, longtitude: longtitude, name: name, tag: tag, { (media, error) in
			if let media = media as? [MediaProtocol] {
				completion(media)
			}
			if !(error.isEmpty) {
				print(error)
				completion(nil)
			}
		})
	}
}
