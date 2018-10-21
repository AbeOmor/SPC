//
//  Song.swift
//  Tunes
//
//  Created by Abraham Omorogbe on 2018-10-20.
//  Copyright © 2018 Abraham Omorogbe. All rights reserved.
//// MARK - Instance
import Foundation
struct Song: Codable{
    
    let title: String
    let resultCount: Int
    let artistName: String
    let trackName: String
    let start   : Date
    let location : Array<Double>
    
//    let previewUrl: String
//    let artworkUrl100:String
//
//    var artworkUrl: String {
//        return artworkUrl100.replacingOccurrences(of: "100", with: "1000")
//    }
}

// MARK: - Downloader
extension Song{
    
    private struct SongResponse: Codable{
        let next : String
        let resultCount: Int
        let results: [Song]
    }
    
    static func search(
        with query: String,
        completionHandler: @escaping ([Song]) -> Void)
    {
        
        let safeQuery = query.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed)!
        
        let path = "https://itunes.apple.com/search"
        + "?entity=song"
        + "&term=\(safeQuery)"
        
//        let path_concerts = "https://api.predicthq.com/v1/events/"
//        + "?category=concerts"
//        + "&q=\(safeQuery)"
        
       let url = URL(string: path)!
        //var request = URLRequest(url: url)
        //request.setValue("Authorization", forHTTPHeaderField: "Bearer QKuEuGjFBhwWWmQ8RHc4si2dShcggH")

        URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            
            guard let data = data,
                let response = try? JSONDecoder().decode(SongResponse.self, from: data),
            response.resultCount != 0
            else {
                completionHandler([])
                return
            }
            print(response)
            completionHandler(response.results)
        }).resume()

    }
}
