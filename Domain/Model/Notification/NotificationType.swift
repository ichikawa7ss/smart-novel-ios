//
//  NotificationType.swift
//  Domain
//
//  Created by ichikawa on 2020/10/29.
//

import Foundation

public protocol NotificationType {

    var name: Notification.Name { get }

    var object: AnyObject? { get }
}

extension NotificationType {

    public var object: AnyObject? {
        return nil
    }
}

public struct NotificationTypes {

    private init() {}

    static var prefix = "SmartNovel."
}

extension NotificationTypes {

    public struct SwitchButton {
        
        // swiftlint:disable nesting
        public enum Display: String, NotificationType, CaseIterable {
            case show
            case hide
            
            public var name: Notification.Name {
                return Notification.Name("\(NotificationTypes.prefix)Tab.Select.\(self.rawValue)")
            }
            
            public var object: AnyObject? {
                switch self {
                case .show:
                    return true as AnyObject
                case .hide:
                    return false as AnyObject
                }
            }
        }
    }
}
