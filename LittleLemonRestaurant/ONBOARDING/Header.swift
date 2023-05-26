//
//  Header.swift
//  LittleLemonRestaurant
//
//  Created by Guild Junior on 24/05/23.
//

import SwiftUI

struct Header: View {
    var body: some View {
        HStack(alignment: .center, spacing: 40) {
            Spacer()
            Image("littleLemon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 220, height: 50)
            
            Image("profile-image-placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 45, height: 45)
                .clipShape(Circle())
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
