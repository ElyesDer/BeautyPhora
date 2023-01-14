//
//  File.swift
//  BeautyPhora
//
//  Created by Derouiche Elyes on 14/01/2023.
//

import Foundation
import RxDataSources

struct SectionViewModel {
    var header: String!
    var items: Products
}

extension SectionViewModel: SectionModelType {
    typealias Item  = ProductDTO
    init(original: SectionViewModel, items: Products) {
        self = original
        self.items = items
    }
}
