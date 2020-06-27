//
//  AAMaterialText+Dictionary.swift
//  AAMaterialText
//
//  Created by Muhammad Ahsan Ali on 2020/05/31.
//

import UIKit

extension Dictionary {
    mutating func merge(dict: [Key: Value]) -> Dictionary {
        for (key, value) in dict { self[key] = value }
        return self
    }
}
