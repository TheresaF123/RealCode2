/*
See LICENSE folder for this sample’s licensing information.

Abstract:
CommandStatus struct wraps the command status. Used on both iOS and watchOS.
*/

import UIKit
import WatchConnectivity

// Constants to identify the Watch Connectivity methods, also used as user-visible strings in UI.
//
enum Command: String {
    case updateAppContext = "Look At Referee"
    case sendMessage = "Half Time/End of Game/Time Out"
    case sendMessageData = "Substitution"
    case transferUserInfo = " "
    case transferFile = "    "
    case transferCurrentComplicationUserInfo = "      "
}
extension UIIMage {
    concenience init(named imageName: ImageName){
        
        
    }
    
    
}
enum Phrase: String {
    case updated = "Updated"
    case sent = "Sent"
    case received = "Receive Notification below"
    case replied = "Replied"
    case transferring = "    "
    case canceled = "Canceled"
    case finished = "     "
    case failed = "   "
}

// Wrap a timed color payload dictionary with a stronger type.
//
struct TimedColor {
    var timeStamp: String
    var colorData: Data
    
    var color: UIColor {
        let optional = try? NSKeyedUnarchiver.unarchivedObject(ofClasses: [UIColor.self], from: colorData)
        guard let color = optional as? UIColor else {
            fatalError("Failed to unarchive a UIClor object!")
        }
        return color
    }
    var timedColor: [String: Any] {
        return [PayloadKey.timeStamp: timeStamp, PayloadKey.colorData: colorData]
    }
    
    init(_ timedColor: [String: Any]) {
        guard let timeStamp = timedColor[PayloadKey.timeStamp] as? String,
            let colorData = timedColor[PayloadKey.colorData] as? Data else {
                fatalError("Timed color dictionary doesn't have right keys!")
        }
        self.timeStamp = timeStamp
        self.colorData = colorData
    }
    
    init(_ timedColor: Data) {
        let data = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(timedColor)
        guard let dictionary = data as? [String: Any] else {
            fatalError("Failed to unarchive a timedColor dictionary!")
        }
        self.init(dictionary)
    }
}

// Wrap the command status to bridge the commands status and UI.
//
struct CommandStatus {
    var command: Command
    var phrase: Phrase
    var timedColor: TimedColor?
    var fileTransfer: WCSessionFileTransfer?
    var file: WCSessionFile?
    var userInfoTranser: WCSessionUserInfoTransfer?
    var errorMessage: String?
    
    init(command: Command, phrase: Phrase) {
        self.command = command
        self.phrase = phrase
    }
}
