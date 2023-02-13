//
//  PhotoModel.swift
//  JSONPhotos
//
//  Created by YoungJoon Kim on 2/11/23.
//

import Foundation

struct PhotoModel: Codable {
    var albumId: Int?
    var id: Int?
    var tltle: String?
    var url: String?
    var thumbnailUrl: String?
}
