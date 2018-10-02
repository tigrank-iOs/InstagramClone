//
//  Parsers.swift
//  Instagram
//
//  Created by Тигран on 02/10/2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import Foundation

protocol ParserProtocol {
	typealias QueryResult = (Any?, String) -> Void
	var errorMessage: String { get set }
	func parseJSON(_ json: [String : Any], completion: @escaping QueryResult)
}

class UserParser: ParserProtocol {
	var errorMessage: String = ""
	
	func parseJSON(_ json: [String : Any], completion: @escaping UserParser.QueryResult) {
		if let result = json["data"] as? [String : Any] {
			let user = User(response: result)
			completion(user, errorMessage)
		} else {
			errorMessage += "Result for User format doesn`t match required struct"
			completion(nil, errorMessage)
		}
	}
}

class MediaParser: ParserProtocol {
	var errorMessage: String = ""
	var mediaArray: [MediaProtocol] = []
	
	func parseJSON(_ json: [String : Any], completion: @escaping MediaParser.QueryResult) {
		if let result = json ["data"] as? [[String : Any]] {
			for data in result {
				let media = MediaFactory.createMediaObject(data)
				if media != nil {
					mediaArray.append(media!)
				}
			}
			completion(mediaArray, errorMessage)
		} else {
			errorMessage += "Result for Media format doesn`t match required struct"
			completion(nil, errorMessage)
		}
	}
	
	
}

class TagParser: ParserProtocol {
	var errorMessage: String = ""
	var tagsArray: [Tag] = []
	
	func parseJSON(_ json: [String : Any], completion: @escaping TagParser.QueryResult) {
		if let result = json["data"] as? [[String : Any]] {
			for data in result {
				let tag = Tag(data)
				tagsArray.append(tag)
			}
			completion(tagsArray, errorMessage)
		} else {
			errorMessage += "Result for Media format doesn`t match required struct"
			completion(nil, errorMessage)
		}
	}
	
	
}
