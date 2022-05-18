//
//  CachedState.swift
//  DiscordAPI
//
//  Created by Vincent Kwok on 22/2/22.
//

import Foundation

/// An observable class for storing cached data from the Gateway
///
/// Data from the `READY` event is stored in this cache. The data
/// within this cache is updated with received events, and should
/// remain fresh. This 
///
/// > In the future, presence updates and REST API requests will
/// > also be stored and kept fresh in this cache.
public class CachedState: ObservableObject {
    @Published public var guilds: [Guild]?
    @Published public var dms: [Channel]?
    @Published public var user: User?
    @Published public var users: [User]? // Cached users, grows over time
    
    public init() {}
}
