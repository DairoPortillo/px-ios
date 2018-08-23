//
//  OneTapItem.swift
//  MercadoPagoSDK
//
//  Created by Eden Torres on 10/05/2018.
//  Copyright © 2018 MercadoPago. All rights reserved.
//

import Foundation

internal class OneTapItem: NSObject {

    var paymentMethodId: String
    open var paymentTypeId: String?
    open var oneTapCard: OneTapCard?

    public init(paymentMethodId: String, paymentTypeId: String?, oneTapCard: OneTapCard?) {
        self.paymentMethodId = paymentMethodId
        self.paymentTypeId = paymentTypeId
        self.oneTapCard = oneTapCard
    }
}

internal extension OneTapItem {
    func getPaymentOptionId() -> String {
        if let oneTapCard = oneTapCard {
            return oneTapCard.cardId
        }
        return paymentMethodId
    }
}
