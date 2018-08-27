//
//  NotificationViewController.swift
//  NotificationContentExt
//
//  Created by Kaya Thomas on 8/12/18.
//  Copyright © 2018 Kaya Thomas. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var newEpisodeLabel: UILabel!
    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
        likeButton.addTarget(self, action: #selector(likeButtonTapped(sender:)), for: .touchUpInside)
    }
    
    func didReceive(_ notification: UNNotification) {

        self.newEpisodeLabel.text = notification.request.content.title
        self.episodeNameLabel.text = notification.request.content.body

        let imgAttachment = notification.request.content.attachments[0]
        let buttonNormalStateAtt = notification.request.content.attachments[1]
        let buttonHighlightStateAtt = notification.request.content.attachments[2]

        guard let imageData = NSData(contentsOf: imgAttachment.url), let buttonNormalStateImgData = NSData(contentsOf: buttonNormalStateAtt.url), let buttonHighlightStateImgData = NSData(contentsOf: buttonHighlightStateAtt.url) else { return }

        let image = UIImage(data: imageData as Data)
        let buttonNormalStateImg = UIImage(data: buttonNormalStateImgData as Data)?.withRenderingMode(.alwaysOriginal)
        let buttonHighlightStateImg = UIImage(data: buttonHighlightStateImgData as Data)?.withRenderingMode(.alwaysOriginal)

        imageView.image = image
        likeButton.setImage(buttonNormalStateImg, for: .normal)
        likeButton.setImage(buttonHighlightStateImg, for: .selected)
    }

    @objc func likeButtonTapped(sender: UIButton) {
        likeButton.isSelected = !sender.isSelected
    }

    func didReceive(_ response: UNNotificationResponse, completionHandler completion:
        (UNNotificationContentExtensionResponseOption) -> Void) {
        guard let currentActions = extensionContext?.notificationActions else { return }

        if response.actionIdentifier == "play-action" {
            let pauseAction = UNNotificationAction(identifier: "pause-action", title: "Pause", options: [])
            let otherAction = currentActions[1]
            let newActions = [pauseAction, otherAction]
            extensionContext?.notificationActions = newActions

        } else if response.actionIdentifier == "queue-action" {
            let removeAction = UNNotificationAction(identifier: "remove-action", title: "Remove from Queue", options: [])
            let otherAction = currentActions[0]
            let newActions = [otherAction, removeAction]
            extensionContext?.notificationActions = newActions

        }  else if response.actionIdentifier == "pause-action" {
            let playAction = UNNotificationAction(identifier: "play-action", title: "Play", options: [])
            let otherAction = currentActions[1]
            let newActions = [playAction, otherAction]
            extensionContext?.notificationActions = newActions

        } else if response.actionIdentifier == "remove-action" {
            let queueAction = UNNotificationAction(identifier: "queue-action", title: "Queue Next", options: [])
            let otherAction = currentActions[0]
            let newActions = [otherAction, queueAction]
            extensionContext?.notificationActions = newActions
        }

        completion(.doNotDismiss)
    }
}
