//
//  CachedState.swift
//  DiscordAPI
//
//  Created by Vincent Kwok on 22/2/22.
//

import Foundation

/// An observable class for storing cached data from the Gateway
///
/// See ``DiscordGateway/cache`` for more details.
public class CachedState: ObservableObject {
    @Published public var guilds: [Guild]?
    @Published public var dms: [Channel]?
    @Published public var user: User?
    @Published public var users: [User]? // Cached users, grows over time
}
