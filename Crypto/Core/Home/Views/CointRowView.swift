//
//  CointRowView.swift
//  Crypto
//
//  Created by Keith Staines on 29/10/2021.
//

import SwiftUI

struct CointRowView: View {
    
    let coin: Coin
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CointRowView_Previews: PreviewProvider {
    
    static var previews: some View {
        CointRowView(coin: Self.dev.coin)
    }
}
