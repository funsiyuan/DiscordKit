//
//  APIChannel.swift
//  DiscordAPI
//
//  Created by Vincent Kwok on 21/2/22.
//

import Foundation

public extension DiscordREST {
    // MARK: Get Channel
    // GET /channels/{channel.id}
    func getChannel(id: Snowflake) async throws -> Channel {
        return try await getReq(path: "channels/\(id)")
    }

    // MARK: Get Channel Messages
    // GET /channels/{channel.id}/messages
    func getChannelMsgs(
        id: Snowflake,
        limit: Int = 50,
        around: Snowflake? = nil,
        before: Snowflake? = nil,
        after: Snowflake? = nil
    ) async throws -> [Message] {
        var query = [URLQueryItem(name: "limit", value: String(limit))]
		if around != nil { query.append(URLQueryItem(name: "around", value: around?.description)) } else if before != nil {query.append(URLQueryItem(name: "before", value: before?.description))} else if after != nil { query.append(URLQueryItem(name: "after", value: after?.description)) }

        return try await getReq(path: "channels/\(id)/messages", query: query)
    }

    // MARK: Get Channel Message
    // Ailas of getChannelMsgs with predefined params
    func getChannelMsg(
        id: Snowflake,
        msgID: Snowflake
    ) async throws -> Message {
        if DiscordKitConfig.default.isBot {
            return try await getReq(path: "channels/\(id)/messages/\(msgID)")
        } else {
            // Actual endpoint only available to bots, so we're using a workaround
            let messages = try await getChannelMsgs(id: id, limit: 1, around: msgID)
            guard !messages.isEmpty else {
                throw RequestError.genericError(reason: "Messages endpoint did not return any messages")
            }
            return messages[0]
        }
    }

    // MARK: Create Channel Message
    // POST /channels/{channel.id}/messages
    func createChannelMsg(
        message: NewMessage,
        attachments: [URL],
        id: Snowflake
    ) async throws -> Message {
        return try await postReq(path: "channels/\(id)/messages", body: message, attachments: attachments)
    }

    // MARK: Delete Message
    // DELETE /channels/{channel.id}/messages/{message.id}
    func deleteMsg(
        id: Snowflake,
        msgID: Snowflake
    ) async throws {
        return try await deleteReq(path: "channels/\(id)/messages/\(msgID)")
    }

    // MARK: Acknowledge Message Read (Undocumented endpoint!)
    // POST /channels/{channel.id}/messages/{message.id}/ack
    func ackMessageRead(
        id: Snowflake,
        msgID: Snowflake
    ) async throws -> MessageReadAck {
        return try await postReq(path: "channels/\(id)/messages/\(msgID)/ack", body: MessageReadAck(token: nil), attachments: [])
    }

    // MARK: Typing Start (Undocumented endpoint!)
    func typingStart(id: Snowflake) async throws {
        return try await emptyPostReq(path: "channels/\(id)/typing")
    }
}
