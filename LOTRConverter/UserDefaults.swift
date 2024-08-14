//
//  UserDefaults.swift
//  LOTRConverter
//
//  Created by Arunachalam on 14/08/24.
//

import SwiftUI
import Combine

final class Preferences {
    
    static let standard = Preferences(userDefaults: .standard)
    fileprivate let userDefaults: UserDefaults
    
    /// Sends through the changed key path whenever a change occurs.
    var preferencesChangedSubject = PassthroughSubject<AnyKeyPath, Never>()
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    //    @UserDefault("should_show_hello_world")
    //    var shouldShowHelloWorld: Bool = false
    //
    //    @UserDefault("left_typing")
    //    var leftTyping: Bool = true
    
    @UserDefault("left_currency")
    var leftCurrency: Currency = .copperPenny
    
    @UserDefault("right_currency")
    var rightCurrency: Currency = .goldPiece
}

@propertyWrapper
struct UserDefault<Value: RawRepresentable> {
    let key: String
    let defaulValue: Value
    
    var wrappedValue: Value {
        get { fatalError("Wrapped value should not be used.") }
        set { fatalError("Wrapped value should not be used.") }
    }
    
    init(wrappedValue: Value, _ key: String) {
        self.key = key
        self.defaulValue = wrappedValue
    }
    
    public static subscript(
        _enclosingInstance instance: Preferences,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<Preferences, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<Preferences, Self>
    )-> Value{
        get {
            let container = instance.userDefaults
            let key = instance[keyPath: storageKeyPath].key
            let defaultValue = instance[keyPath: storageKeyPath].defaulValue
            let storedValue = container.object(forKey: key) as? Value.RawValue ?? defaultValue.rawValue
            return Value(rawValue: storedValue) ?? defaultValue
        }
        set {
            let container = instance.userDefaults
            let key = instance[keyPath: storageKeyPath].key
            container.set(newValue.rawValue, forKey: key)
            instance.preferencesChangedSubject.send(wrappedKeyPath)
        }
    }
}
