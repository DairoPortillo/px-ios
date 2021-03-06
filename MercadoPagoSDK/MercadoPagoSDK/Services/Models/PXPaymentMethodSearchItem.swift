//
//  PXPaymentMethodSearchItem.swift
//  MercadoPagoSDK
//
//  Created by Eden Torres on 10/20/17.
//  Copyright © 2017 MercadoPago. All rights reserved.
//

import Foundation
/// :nodoc:
open class PXPaymentMethodSearchItem: NSObject, Codable {
    open var id: String!
    open var type: String?
    open var _description: String?
    open var comment: String?
    open var children: [PXPaymentMethodSearchItem] = []
    open var childrenHeader: String?
    open var showIcon: Bool?
    open var icon: Int?

    public init(id: String, type: String?, description: String?, comment: String?, children: [PXPaymentMethodSearchItem], childrenHeader: String?, showIcon: Bool?, icon: Int?) {
        self.id = id
        self.type = type
        self._description = description
        self.comment = comment
        self.children = children
        self.childrenHeader = childrenHeader
        self.showIcon = showIcon
        self.icon = icon
    }

    public enum CodingKeys: String, CodingKey {
        case id
        case type
        case _description = "description"
        case comment
        case children
        case childrenHeader = "children_header"
        case showIcon = "show_icon"
        case icon
    }

    required public convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id: String = try container.decode(String.self, forKey: .id)
        let type: String? = try container.decodeIfPresent(String.self, forKey: .type)
        let description: String? = try container.decodeIfPresent(String.self, forKey: ._description)
        let comment: String? = try container.decodeIfPresent(String.self, forKey: .comment)
        let children: [PXPaymentMethodSearchItem] = try container.decodeIfPresent([PXPaymentMethodSearchItem].self, forKey: .children) ?? []
        let childrenHeader: String? = try container.decodeIfPresent(String.self, forKey: .childrenHeader)
        let showIcon: Bool? = try container.decodeIfPresent(Bool.self, forKey: .showIcon)
        let icon: Int? = try container.decodeIfPresent(Int.self, forKey: .icon)

        self.init(id: id, type: type, description: description, comment: comment, children: children, childrenHeader: childrenHeader, showIcon: showIcon, icon: icon)
    }
}
