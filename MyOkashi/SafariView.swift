//
//  SafariView.swift
//  MyOkashi
//
//  Created by NSPC201admin on 2024/03/06.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable{
    var url: URL
    func makeUIViewController(context: Context) -> SFSafariViewController{
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context){
        
    }
}
