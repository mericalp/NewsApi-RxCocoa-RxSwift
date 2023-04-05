//
//  WebViewController.swift
//  NewsApp
//
//  Created by Meric Alp on 5.04.2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    var url: URL!

    override func viewDidLoad() {
        super.viewDidLoad()

        webView.load(URLRequest(url: url))
    }

}
