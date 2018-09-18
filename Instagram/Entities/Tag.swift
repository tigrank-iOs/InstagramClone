//
//  Tag.swift
//  Instagram
//
//  Created by Тигран on 18/09/2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import Foundation

public class Tag {
	let mediaCount: Int
	let name: String
	
	init(_ response: [String : Any]) {
		mediaCount = response["media_count"] as! Int
		name = response["name"] as! String
	}
}
