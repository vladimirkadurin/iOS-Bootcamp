//
//  WebViewVC.swift
//  SomeUp
//
//  Created by Vladimir Kadurin on 19.02.19.
//  Copyright © 2019 Vladimir Kadurin. All rights reserved.
//

import UIKit

class WebViewVC: UIViewController {
    @IBOutlet weak var webVIew: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var urlString: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let urlString = urlString, let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webVIew.loadRequest(request)
        }

        webVIew.delegate = self
    }
}

extension WebViewVC: UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        activityIndicator.startAnimating()
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
    }

    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        activityIndicator.stopAnimating()
        showPopupWith(title: "Error", message: "There was an error loadfing the url.")
    }
}
