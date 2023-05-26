//
//  Hero.swift
//  LittleLemonRestaurant
//
//  Created by Guild Junior on 24/05/23.
//

import SwiftUI

struct Hero: View {
    @Environment(\.presentationMode) var presentation // 
    
    @Binding var searchText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Little Lemon")
                .font(.custom("MarkaziText-Medium", size: 64))
                .foregroundColor(Color("primaryTwo"))
                .frame(width: 300, height: 50, alignment: .leading)
            
            Text("Chicago")
                .font(.custom("MarkaziText-Regular", size: 40))
                .foregroundColor(Color("highlightOne"))
                .frame(width: 200, height: 5, alignment: .leading)
            
            HStack(spacing: 0) {
                Text("""
                    We are a family owned
                    Mediterranean restaurant,
                    focused on traditional
                    recipes served with a
                    modern twist.
                    """)
                .font(.custom("Karla-Medium", size: 16))
                .foregroundColor(Color("highlightOne"))
                .frame(width: 200, height: 120, alignment: .leading)
                .padding(5)
                
                Image("Hero image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            if UserDefaults.standard.bool(forKey: keyIsLoggedIn) == true {
                TextField("Search menu", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.custom("Karla-Bold", size: 16))
                    .disableAutocorrection(true)
            }
            TextField("Search menu",text: $searchText)
                .textFieldStyle(.roundedBorder)
                .font(.custom("Karla-Medium", size: 16))
                .searchable(text: $searchText)
        }
        .padding(12)
        .background(Color("primaryOne"))
    }
}


struct Hero_Previews: PreviewProvider {
    static var previews: some View {
        Hero(searchText: Binding.constant(""))
    }
}
