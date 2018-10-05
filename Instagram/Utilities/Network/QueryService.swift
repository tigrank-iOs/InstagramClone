//
//  QueryService.swift
//  Instagram
//
//  Created by Тигран on 13/09/2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import UIKit

enum EntityTypes {
	case user, media, tag
}

class QueryService {
	private init() { }
	
	// MARK: - Variables
	static let shared: QueryService = QueryService()
	
	private var parser: ParserProtocol!
	private var errorMessage: String = ""
	typealias QueryResults = (Any?, String) -> Void
	
	// MARK: - Functions
	// Базовый метод для выполнения GET запросов в сеть
	private func load(_ url: String, _ completion: @escaping QueryResults) {
		self.errorMessage = ""
		DispatchQueue.main.async {
			UIApplication.shared.isNetworkActivityIndicatorVisible = true
		}
		guard let url = URL(string: url) else {
			self.errorMessage += "Error: bad URL received"
			completion(nil, self.errorMessage)
			return
		}
		URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
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
	
	// Унифицированный метод для получения JSON из сети и парсинга в нужный тип файла
	public func get(entity type: EntityTypes, for_lattitude lattitude: String?, longtitude: String?, name: String?, tag: Tag?, _ completion: @escaping QueryResults) {
		
		let url = createURL(type, lattitude, longtitude, tag, name)
		
		self.load(url) { [weak self] (json, error) in
			guard let weakSelf = self else { return }
			
			guard let json = json as? [String : Any] else {
				weakSelf.errorMessage += "Wrong JSON received"
				completion(nil, weakSelf.errorMessage)
				return
			}
			
			weakSelf.assignParser(for: type)
			
			weakSelf.parser.parseJSON(json, completion: { (entities, error) in
				weakSelf.errorMessage += error
				completion(entities, error)
			})
		}
	}
	
	// Метод создает URL по заданным параметрам
	private func createURL(_ type: EntityTypes, _ lattitude: String?, _ longtitude: String?, _ tag: Tag?, _ name: String?) -> String {
		guard let token = Credential.token else {
			errorMessage += "Cannot get token"
			return errorMessage
		}
		var url = ""
		switch type {
		case .user:
			url = Constants.UserAPI.host + Constants.UserAPI.currentUserBody + Constants.UserAPI.token + token
		case .media:
			if let lat = lattitude, let lon = longtitude {
				url = Constants.MediaAPI.host + Constants.MediaAPI.body + Constants.MediaAPI.latitude + lat + Constants.MediaAPI.longtitude + lon + Constants.MediaAPI.token + token
			} else if let tag = tag {
				url = Constants.TagAPI.host + Constants.TagAPI.searchMedia + tag.name + Constants.TagAPI.media + Constants.TagAPI.mediaToken + token
			} else {
				url = Constants.UserAPI.host + Constants.UserAPI.userMediaBody + Constants.UserAPI.token + token
			}
		case .tag:
			guard let name = name else {
				errorMessage += "No name for tag"
				return errorMessage
			}
			url = Constants.TagAPI.host + Constants.TagAPI.searchTagBody + Constants.TagAPI.tag + name + Constants.TagAPI.token + token
		}
		return url
	}
	
	// Метод назначает свойству parser необходимо занчение исходя из типа данных
	private func assignParser(for type: EntityTypes) {
		switch type {
		case .user: self.parser = UserParser()
		case .media: self.parser = MediaParser()
		case .tag: self.parser = TagParser()
		}
	}
}
