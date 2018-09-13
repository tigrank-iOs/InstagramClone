//
//  APIManager.swift
//  Instagram
//
//  Created by Тигран on 13/09/2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import UIKit

public class APIManager {
	static let shared: APIManager = APIManager()
	
	private init() { }
	
	func load(_ url: String, _ completion: @escaping (Any?) -> Void) {
		UIApplication.shared.isNetworkActivityIndicatorVisible = true
		URLSession.shared.dataTask(with: URL(string: url)!) {
			(data, response, error) in
			guard let data = data, error == nil else {
				completion(nil)
				DispatchQueue.main.async {
					UIApplication.shared.isNetworkActivityIndicatorVisible = false
				}
				return
			}
			DispatchQueue.main.async {
				UIApplication.shared.isNetworkActivityIndicatorVisible = false
			}
			completion(try? JSONSerialization.jsonObject(with: data, options: .mutableContainers))
		}.resume()
	}
}
