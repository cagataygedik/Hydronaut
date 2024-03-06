//
//  WaterModel.swift
//  Hydronaut
//
//  Created by Celil Çağatay Gedik on 5.03.2024.
//

import Foundation

class WaterManager {
    typealias Water = Int
    
    static var shared = WaterManager()
    private let storage = UserDefaults.standard
    
    private(set) var userIntake: Water = 0 {
        didSet {
            NotificationCenter.default.post(name: WaterManager.waterVolumeDidChange, object: nil)
        }
    }
    
    private(set) var recommendedIntake: Water = 0 {
        didSet {
            NotificationCenter.default.post(name: WaterManager.recommendedIntakeDidChange, object: nil)
        }
    }
    
    private(set) var nickName: String = "" {
        didSet {
            NotificationCenter.default.post(name: WaterManager.nickNameDidChange, object: nil)
        }
    }
    
    var achievementRate: Float {
        return ( Float(userIntake) / Float(recommendedIntake) ) * 100
    }
    
    private init() { }
    deinit{}
    
    func fetchUserInfo() {
        guard let dateString = storage.string(forKey: UserInfoKey.recordedDate.rawValue),
              let recordedDate = ISO8601DateFormatter().date(from: dateString) else { return }
        
        if Calendar.current.isDateInToday(recordedDate) {
            userIntake = storage.integer(forKey: UserInfoKey.userIntake.rawValue)
        }
        
        recommendedIntake = storage.integer(forKey: UserInfoKey.recommendedIntake.rawValue)
        let nickname = storage.string(forKey: UserInfoKey.nickName.rawValue) ?? "Not Registered"
        self.nickName = nickname
    }
    
    func addWaterVolume(size volume: Water) {
        self.userIntake += volume
    }
    
    func resetVolume() {
        userIntake = 0
    }
    
    func updateUserInfo(with userInfo: [UserInfoKey: Any?]) {
        guard let nickName = userInfo[UserInfoKey.nickName] as? String,
              let recommendedIntake = userInfo[UserInfoKey.recommendedIntake] as? Int else { return }
        self.nickName = nickName
        self.recommendedIntake = recommendedIntake
    }
    
    func saveUserInfo() {
        let recordedDate = ISO8601DateFormatter().string(from: Date())
        storage.setValue(nickName, forKey: UserInfoKey.nickName.rawValue)
        storage.setValue(recordedDate, forKey: UserInfoKey.recordedDate.rawValue)
        storage.setValue(userIntake, forKey: UserInfoKey.userIntake.rawValue)
        storage.setValue(recommendedIntake, forKey: UserInfoKey.recommendedIntake.rawValue)
    }
    
    func calculateRecommendedIntake(userHeight height: Int, userWeight weight: Int) -> Int {
        var result = (Float(height) + Float(weight)) / Float(100)
        result = ((result * 10).rounded(.down)) / 10
        result = result * 1000 // Convert to milliliters
        return Int(result)
    }
}

extension WaterManager {
    static let nickNameDidChange = Notification.Name("nickNameDidChange")
    static let waterVolumeDidChange = Notification.Name("waterVolumeDidChange")
    static let recommendedIntakeDidChange = Notification.Name("recommendedIntakeDidChange")
}

extension WaterManager {
    enum UserInfoKey: String {
        case userIntake
        case recordedDate
        case recommendedIntake
        case nickName
    }
}