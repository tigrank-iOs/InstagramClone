//
//  SearchedTagsView.swift
//  Instagram
//
//  Created by Тигран on 16/10/2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import UIKit

public class SearchedTagsView: UIView {
	
	var tableview: UITableView!
	var tags: [Tag] = []
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		configurateTable()
		NotificationCenter.default.addObserver(self, selector: #selector(searchTextDidReceive(_:)), name: .init(rawValue: Constants.NotificationsName.textReceived), object: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been emplemented")
	}
	
	func configurateTable() {
		tableview = UITableView(frame: self.bounds, style: .plain)
		tableview.delegate = self
		tableview.dataSource = self
		tableview.register(UITableViewCell.self, forCellReuseIdentifier: Constants.Storyboard.tagCellId)
		self.addSubview(tableview)
	}

	@objc private func searchTextDidReceive(_ notification: Notification) {
		guard let searchText = notification.object as? String else {
			return
		}
		APIManager.shared.getTags(for: searchText) { (newTags) in
			if let newTags = newTags {
				self.tags = newTags
				DispatchQueue.main.async {
					self.tableview.reloadData()
				}
			}
		}
	}
}

extension SearchedTagsView: UITableViewDelegate, UITableViewDataSource {
	
	// MARK: - UITableViewDataSource
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tags.count
	}
	
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.tagCellId, for: indexPath)
		cell.textLabel?.text = "#" + tags[indexPath.row].name
		cell.accessoryType = .disclosureIndicator
		return cell
	}
	
	// MARK: - UITableViewDelegate
	public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		NotificationCenter.default.post(name: .init(Constants.NotificationsName.tagSelected), object: tags[indexPath.row])
		isHidden = true
	}
}
