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
    var items: ProductModels
}

extension SectionViewModel: SectionModelType {
    init(original: SectionViewModel, items: ProductModels) {
        self = original
        self.items = items
    }
}
