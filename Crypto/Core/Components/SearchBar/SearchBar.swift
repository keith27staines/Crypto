//
//  Searchbar.swift
//  Crypto
//
//  Created by Keith Staines on 31/10/2021.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchString: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchString.isEmpty ? Color.theme.secondaryText : Color.theme.accent
                )
            TextField("Search by name or symbol", text: $searchString)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                
            if !searchString.isEmpty {
                Button {
                    searchString = ""
                    UIApplication.shared.endEditing()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.accentColor)
                    
                }
                .padding(6)
            }
        }
        .font(.headline)
        .foregroundColor(Color.theme.accent)
        .padding()
        .frame(height: 50)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(
                    color: Color.theme.shadowColor,
                    radius: 10,
                    x: 0,
                    y: 0
                )
        )
        .padding()
    }
}

struct SearchBar_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            SearchBarWrapper()
                .preferredColorScheme(.light)
            SearchBarWrapper()
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
    
    struct SearchBarWrapper: View {
        @State private var search = "btc"
        var body: some View {
            SearchBar(searchString: $search)
        }
    }
}


