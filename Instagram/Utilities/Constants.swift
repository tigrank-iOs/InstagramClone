//
//  Constants.swift
//  Instagram
//
//  Created by Тигран on 13/09/2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import Foundation

public class Constants {
	
	private init() { }
	
	// Структура, содержащая необходимые константы для авторизации пользователя в сети Инстаграмм
	struct Auth {
		static public let clientId = "65de829ef3a2449b86d9504b6310e491"
		static public let redirectUrl = "https://instagram.com"
		static public let url = URL(string: "https://api.instagram.com/oauth/authorize/?client_id=\(clientId)&scope=public_content+follower_list+relationships+comments+likes&redirect_uri=\(redirectUrl)&response_type=token")!
	}
	
	// Структура, содержащая константы для обращения к контроллерам в строриборде
	struct Storyboard {
		static public let authVCId = "Authorization"
		static public let mainVCId = "Main"
	}
	
	// Структура, содержащая необходимые константы для осуществления запроса информации о текущем пользователе
	struct UserAPI {
		static public let host = "https:api.instagram.com/v1/"
		static public let currentUserBody = "users/self/"
		static public let userMediaBody = "users/self/media/recent/"
		static public let token = "?access_token="
	}
	
	// Структура, содержащая необходимые константы для осуществления поиска медиа в заданой местности
	struct MediaAPI {
		static public let host = "https:api.instagram.com/v1/"
		static public let body = "media/search?"
		static public let latitude = "lat="
		static public let longtitude = "&lng="
		static public let token = "&access_token="
	}
	
	// Структура, содержащая необходимые константы для осуществления запроса информации о текущем пользователе
	struct TagAPI {
		static public let host = "https:api.instagram.com/v1/"
		static public let searchTagBody = "tags/search"
		static public let tag = "?q="
		static public let searchMedia = "tags/"
		static public let media = "/media/recent"
		static public let token = "&access_token="
		static public let mediaToken = "?access_token="
	}
}
