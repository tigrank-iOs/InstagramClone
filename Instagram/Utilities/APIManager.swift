//
//  APIManager.swift
//  Instagram
//
//  Created by Тигран on 13/09/2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import UIKit

public class APIManager {
	private init() { }
	
	// MARK: - Variables
	public static let shared: APIManager = APIManager()
	
	public typealias UserQueryResult = (User?, String) -> Void
	public typealias MediaQueryResult = ([MediaProtocol]?, String) -> Void
	public typealias TagsQueryResult = ([Tag]?, String) -> Void
	
	private var errorMessage: String = ""
	private var mediaArray: [MediaProtocol] = []
	private var tagsArray: [Tag] = []
	
	// MARK: - Functions
	// Базовый метод для выполнения GET запросов в сеть
	private func load(_ url: String, _ completion: @escaping (Any?, String) -> Void) {
		self.errorMessage = ""
		DispatchQueue.main.async {
			UIApplication.shared.isNetworkActivityIndicatorVisible = true
		}
		URLSession.shared.dataTask(with: URL(string: url)!) { [weak self] (data, response, error) in
			guard let strongSelf = self else { return }
			guard let data = data, error == nil else {
				strongSelf.errorMessage += "Data task error: \(error!.localizedDescription)\n"
				completion(nil, strongSelf.errorMessage)
				DispatchQueue.main.async {
					UIApplication.shared.isNetworkActivityIndicatorVisible = false
				}
				return
			}
			DispatchQueue.main.async {
				UIApplication.shared.isNetworkActivityIndicatorVisible = false
			}
			completion(try? JSONSerialization.jsonObject(with: data, options: .mutableContainers), strongSelf.errorMessage)
		}.resume()
	}
	
	// Метод по загрузки текущего пользователя. В результате выполнения отдаем замыкание, которое содержит объект класса User и описание ошибок, если таковые возникли
	public func getUser(_ completion: @escaping UserQueryResult) {
		guard let token = Credential.token else {
			errorMessage += "Cannot get token"
			completion(nil, errorMessage)
			return
		}
		let url = Constants.UserAPI.host + Constants.UserAPI.currentUserBody + Constants.UserAPI.token + token
		self.load(url) { [weak self] (json, error) in
			guard let strongSelf = self else { return }
			if let result = (json as? [String : Any])?["data"] as? [String : Any] {
				let user = User(response: result)
				completion(user, strongSelf.errorMessage)
			} else {
				strongSelf.errorMessage += "Result for User format doesn`t match required struct"
				completion(nil, strongSelf.errorMessage)
			}
		}
	}
	
	// Метод для загрузки медиа текущего пользователя
	public func getMedia(_ completion: @escaping MediaQueryResult) {
		guard let token = Credential.token else {
			errorMessage += "Cannot get token"
			completion(nil, errorMessage)
			return
		}
		let url = Constants.UserAPI.host + Constants.UserAPI.userMediaBody + Constants.UserAPI.token + token
		self.load(url) { [weak self] (json, error) in
			guard let strongSelf = self else { return }
			strongSelf.mediaArray.removeAll()
			if let result = (json as? [String : Any])?["data"] as? [[String : Any]] {
				for data in result {
					let media = MediaFactory.createMediaObject(data)
					if media != nil {
						strongSelf.mediaArray.append(media!)
					}
				}
				completion(strongSelf.mediaArray, strongSelf.errorMessage)
			} else {
				strongSelf.errorMessage += "Result for Media format doesn`t match required struct"
				completion(nil, strongSelf.errorMessage)
			}
		}
	}
	
	// Метод для поиска медиа в заданной местности
	public func getMediaFor(lattitude: String, longtitude: String, _ completion: @escaping MediaQueryResult) {
		guard let token = Credential.token else {
			errorMessage += "Cannot get token"
			completion(nil, errorMessage)
			return
		}
		let url = Constants.MediaAPI.host + Constants.MediaAPI.body + Constants.MediaAPI.latitude + Constants.MediaAPI.longtitude + Constants.MediaAPI.token + token
		
		self.load(url) { [weak self] (json, error) in
			guard let strongSelf = self else { return }
			strongSelf.mediaArray.removeAll()
			if let result = (json as? [String : Any])?["data"] as? [[String : Any]] {
				for data in result {
					let media = MediaFactory.createMediaObject(data)
					if media != nil {
						strongSelf.mediaArray.append(media!)
					}
				}
				completion(strongSelf.mediaArray, strongSelf.errorMessage)
			} else {
				strongSelf.errorMessage += "Result for Media format doesn`t match required struct"
				completion(nil, strongSelf.errorMessage)
			}
		}
	}
	
	// Метод для поиска всех тегов по части имени тега
	public func getTags(for name: String, _ completion: @escaping TagsQueryResult) {
		guard let token = Credential.token else {
			errorMessage += "Cannot get token"
			completion(nil, errorMessage)
			return
		}
		let url = Constants.TagAPI.host + Constants.TagAPI.searchTagBody + Constants.TagAPI.tag + name + Constants.TagAPI.token + token
		self.load(url) { [weak self] (json, error) in
			guard let strongSelf = self else { return }
			strongSelf.tagsArray.removeAll()
			if let result = (json as? [String : Any])?["data"] as? [[String : Any]] {
				for data in result {
					let tag = Tag(data)
					strongSelf.tagsArray.append(tag)
				}
				completion(strongSelf.tagsArray, strongSelf.errorMessage)
			} else {
				strongSelf.errorMessage += "Result for Media format doesn`t match required struct"
				completion(nil, strongSelf.errorMessage)
			}
		}
	}
	
	// Метод для поиска медиа по тегу
	public func getTagedMedia(for tag: Tag, _ completion: @escaping MediaQueryResult) {
		guard let token = Credential.token else {
			errorMessage += "Cannot get token"
			completion(nil, errorMessage)
			return
		}
		var url = Constants.TagAPI.host + Constants.TagAPI.searchMedia + tag.name + Constants.TagAPI.media + Constants.TagAPI.mediaToken + token
		url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
		self.load(url) { [weak self] (json, error) in
			guard let strongSelf = self else { return }
			strongSelf.mediaArray.removeAll()
			if let result = (json as? [String : Any])?["data"] as? [[String : Any]] {
				for data in result {
					let media = MediaFactory.createMediaObject(data)
					if media != nil {
						strongSelf.mediaArray.append(media!)
					}
				}
				completion(strongSelf.mediaArray, strongSelf.errorMessage)
			} else {
				strongSelf.errorMessage += "Result for Media format doesn`t match required struct"
				completion(nil, strongSelf.errorMessage)
			}
		}
	}
}
