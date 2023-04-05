//
//  File.swift
//  NewsApp
//
//  Created by Meric Alp on 5.04.2023.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView(frame: view.frame)
        view.addSubview(webView)
    }
}
