//
//  SearchedUserCell.swift
//  Yep
//
//  Created by NIX on 16/4/5.
//  Copyright © 2016年 Catch Inc. All rights reserved.
//

import UIKit

final class SearchedUserCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        separatorInset = YepConfig.SearchedItemCell.separatorInset
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        avatarImageView.image = nil
        nicknameLabel.text = nil
        usernameLabel.text = nil
        timeLabel.text = nil
    }

    func configureWithUserRepresentation(_ user: UserRepresentation, keyword: String?, showTime: Bool = true) {

        let userAvatar = UserAvatar(userID: user.userID, avatarURLString: user.avatarURLString, avatarStyle: nanoAvatarStyle)
        avatarImageView.navi_setAvatar(userAvatar, withFadeTransitionDuration: avatarFadeTransitionDuration)

        if let keyword = keyword {
            nicknameLabel.attributedText = user.nickname.yep_hightlightSearchKeyword(keyword, baseFont: YepConfig.SearchedItemCell.nicknameFont, baseColor: YepConfig.SearchedItemCell.nicknameColor)

        } else {
            nicknameLabel.text = user.nickname
        }

        if let mentionUsername = user.mentionedUsername {
            usernameLabel.isHidden = false

            if let keyword = keyword {
                usernameLabel.attributedText = mentionUsername.yep_hightlightSearchKeyword(keyword, baseFont: YepConfig.SearchedItemCell.usernameFont, baseColor: YepConfig.SearchedItemCell.usernameColor)

            } else {
                usernameLabel.text = mentionUsername
            }

        } else {
            usernameLabel.isHidden = true
        }

        if showTime {
            timeLabel.text = String.trans_promptLastSeenAt(user.lastSignInUnixTime)
        } else {
            timeLabel.text = nil
        }
    }
}

