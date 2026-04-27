//
//  SecondViewController.swift
//  BasicNavigationController
//
//  Created by Tecsup on 20/04/26.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var messageLabel: UILabel!
    var receivedMessage: String = "tu mensaje aquí"
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "Message Received"
        messageLabel.text = receivedMessage}
    
}
