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
	
	struct Auth {
		static public let clientId = "65de829ef3a2449b86d9504b6310e491"
		static public let redirectUrl = "https://instagram.com"
		static public let url = URL(string: "https://api.instagram.com/oauth/authorize/?client_id=\(clientId)&scope=public_content+follower_list+relationships+comments+likes&redirect_uri=\(redirectUrl)&response_type=token")!
	}
	
	struct Storyboard {
		static public let authVCId = "Authorization"
		static public let mainVCId = "Main"
	}
	
	struct API {
		static public let host = "https:api.instagram.com/v1/"
		static public let token = "?access_token="
		static public let body = "users/self/"
	}
}
