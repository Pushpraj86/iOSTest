//
//  CustomerModel.swift
//  iOSTest
//
//  Created by Apple on 07/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)


struct Customerdetail: Codable {
    let data: DataClass
    let included: [Included]
}

struct DataClass: Codable {
    let type, id: String
    let attributes: DataAttributes
    let links: DataLinks
    let relationships: DataRelationships
}

struct DataAttributes: Codable {
    let paymentType: String
    let unbilledCharges, nextBillingDate: JSONNull?
    let title, firstName, lastName, dateOfBirth: String
    let contactNumber, emailAddress: String
    let emailAddressVerified, emailSubscriptionStatus: Bool
    
    enum CodingKeys: String, CodingKey {
        case paymentType = "payment-type"
        case unbilledCharges = "unbilled-charges"
        case nextBillingDate = "next-billing-date"
        case title
        case firstName = "first-name"
        case lastName = "last-name"
        case dateOfBirth = "date-of-birth"
        case contactNumber = "contact-number"
        case emailAddress = "email-address"
        case emailAddressVerified = "email-address-verified"
        case emailSubscriptionStatus = "email-subscription-status"
    }
}

struct DataLinks: Codable {
    let linksSelf: String
    
    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
    }
}

struct DataRelationships: Codable {
    let services: Service
}

struct Service: Codable {
    let links: ServicesLinks
}

struct ServicesLinks: Codable {
    let related: String
}

struct Included: Codable {
    let type, id: String
    let attributes: IncludedAttributes
    let links: DataLinks?
    let relationships: IncludedRelationships?
}

struct IncludedAttributes: Codable {
    let msn: String?
    let credit: Int?
    let creditExpiry: String?
    let dataUsageThreshold: Bool?
    let includedDataBalance: Int?
    let includedCreditBalance, includedRolloverCreditBalance, includedRolloverDataBalance, includedInternationalTalkBalance: JSONNull?
    let expiryDate: String?
    let autoRenewal, primarySubscription: Bool?
    let name: String?
    let includedData, includedCredit, includedInternationalTalk: JSONNull?
    let unlimitedText, unlimitedTalk, unlimitedInternationalText, unlimitedInternationalTalk: Bool?
    let price: Int?
    
    enum CodingKeys: String, CodingKey {
        case msn, credit
        case creditExpiry = "credit-expiry"
        case dataUsageThreshold = "data-usage-threshold"
        case includedDataBalance = "included-data-balance"
        case includedCreditBalance = "included-credit-balance"
        case includedRolloverCreditBalance = "included-rollover-credit-balance"
        case includedRolloverDataBalance = "included-rollover-data-balance"
        case includedInternationalTalkBalance = "included-international-talk-balance"
        case expiryDate = "expiry-date"
        case autoRenewal = "auto-renewal"
        case primarySubscription = "primary-subscription"
        case name
        case includedData = "included-data"
        case includedCredit = "included-credit"
        case includedInternationalTalk = "included-international-talk"
        case unlimitedText = "unlimited-text"
        case unlimitedTalk = "unlimited-talk"
        case unlimitedInternationalText = "unlimited-international-text"
        case unlimitedInternationalTalk = "unlimited-international-talk"
        case price
    }
}

struct IncludedRelationships: Codable {
    let subscriptions: Subscriptions?
    let service: Service?
    let product, downgrade: Downgrade?
}

struct Downgrade: Codable {
    let data: DAT?
}

struct DAT: Codable {
    let type, id: String
}

struct Subscriptions: Codable {
    let links: ServicesLinks
    let data: [DAT]
}

// MARK: Encode/decode helpers

class JSONNull: Codable {
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
