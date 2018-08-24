//
//  NotificationSettingsViewController.swift
//  NotificationTester
//
//  Created by Kaya Thomas on 8/12/18.
//  Copyright © 2018 Kaya Thomas. All rights reserved.
//

import UIKit

class NotificationSettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let settingsLabel = UILabel(frame: CGRect.zero)
        settingsLabel.text = "Notification Settings Page"
        settingsLabel.font = UIFont.systemFont(ofSize: 30)
        view.addSubview(settingsLabel)

        settingsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        settingsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
