//
//  OkashiData.swift
//  MyOkashi
//
//  Created by NSPC201admin on 2024/03/06.
//

import UIKit
import SwiftUI
import Foundation

struct OkashiItem: Identifiable{
    let id = UUID()
    let name:String
    let link: URL
    let image: URL
}

class OkashiData: ObservableObject{
    struct ResultJson: Codable{
        struct Item: Codable{
            let name: String?
            let url: URL?
            let image: URL?
        }
        let item: [Item]?
    }
    
    @Published var okashiList: [OkashiItem] = []
    
    func searchOkashi(keyword: String) async{
        print(keyword)
        
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else{
            return
        }
        
        guard let req_url = URL(string:
                                    "https://sysbird.jp/toriko/api/?apikey=guest&format=json'keyword=\(keyword_encode)&max=108order=r")
        else {
            return
        }
        print(req_url)
        
        do {
            let (data , _) = try await URLSession.shared.data(from: req_url)
            let decoder = JSONDecoder()
            let json = try decoder.decode(ResultJson.self, from: data)
            
            guard let items = json.item else { return }
            DispatchQueue.main.async {
                self.okashiList.removeAll()
            }
            
            for item in items{
                if let name = item.name,
                   let link = item.url,
                   let image = item.image{
                    let okashi = OkashiItem(name: name, link: link, image: image)
                    DispatchQueue.main.async{
                        self.okashiList.append(okashi)
                    }
                }
            }
            print(self.okashiList)
            
        } catch {
            print("エラーが出ました")
        }
    }
    
    
}
