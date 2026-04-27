//
//  ViewController.swift
//  BasicNavigationController
//
//  Created by Tecsup on 20/04/26.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var messageTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "First screen"
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let destinationVC = segue.destination as? SecondViewController {
                destinationVC.receivedMessage = messageTextField.text ?? ""
            }
        }
    }
    
}

