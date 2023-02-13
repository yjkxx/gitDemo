////
////  VideoModel.swift
////  JSONCodingKeys
////
////  Created by YoungJoon Kim on 2/11/23.
////
//
//import Foundation
//
//struct VideoModel: Codable {
//
//    var duration: Double?
//    var image_id: String?
//    var plays: Int?
//    var created_at: String?
//    var size: Double?
//    var transcodings: [Transcodings]?
//    var title: String?
//    var updated_at: String?
//    var account_id: String?
//    var progress: Double?
//    var original_movie: OriginalMovie?
//    var tags: [String]?
//    var id: String?
//    var aspect_ratio_multiplier: Double?
//    var screenshot: Screenshot?
//    var state: String?
//}
//
//struct Transcodings: Codable {
//    var id: String?
//    var rtmp_stream_uri: String?
//    var size: Double?
//    var http_uri: String?
//    var title: String?
//    var progress: Double?
//    var rtmp_base_uri: String?
//    var bitrate: Int?
//    var height: Int?
//    var rtmp_uri: String?
//    var state: String?
//    var width: Int?
//}
//
//struct OriginalMovie: Codable {
//    var http_uri: String?
//    var size: Double?
//}
//
//struct Screenshot: Codable {
//    var normal: String?
//    var thumb: String?
//    var original: String?
//}
//

// This file was generated from JSON Schema using codebeautify, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome1 = try Welcome1(json)

import Foundation

struct VideoModel: Codable {

    let transcodings: [Transcoding]?
    let screenshot: Screenshot?
    let title: String?
    
}



// MARK: - Screenshot
struct Screenshot: Codable  {
    let normal, thumb, original: String?
}

// MARK: - Transcoding
struct Transcoding: Codable  {
    let id: String?
    let height: Int?
    let width: Int?
}

extension Transcoding {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.height = try container.decodeIfPresent(Int.self, forKey: .height)
        self.width = try container.decodeIfPresent(Int.self, forKey: .width)

    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case height
        case width
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.id, forKey: .id)
    }
}
