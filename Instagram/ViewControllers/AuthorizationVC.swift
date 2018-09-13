//
//  AuthorizationVC.swift
//  Instagram
//
//  Created by Тигран on 13/09/2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import UIKit

public class AuthorizationVC: UIViewController {
	
	// MARK: - Outlets
	@IBOutlet weak var webView: UIWebView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	// MARK: - VCLifeCycle
	override public func viewDidLoad() {
        super.viewDidLoad()
		
		webView.delegate = self
		
		let request = URLRequest(url: Constants.Auth.url)
		webView.loadRequest(request)
    }

}

extension AuthorizationVC: UIWebViewDelegate {
	// MARK: - UIWebViewDelegate
	public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
		if let url = request.url?.absoluteString {
			if url.range(of: "#access_token") != nil {
				let token = url.components(separatedBy: "#access_token=").last!
				Credential.token = token
				presentMainVC()
			}
		}
		return true
	}
	
	public func webViewDidStartLoad(_ webView: UIWebView) {
		activityIndicator.startAnimating()
	}
	
	public func webViewDidFinishLoad(_ webView: UIWebView) {
		activityIndicator.isHidden = true
		activityIndicator.stopAnimating()
	}
	
	private func presentMainVC() {
		self.present((self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.mainVCId))!, animated: true, completion: nil)
	}
}
