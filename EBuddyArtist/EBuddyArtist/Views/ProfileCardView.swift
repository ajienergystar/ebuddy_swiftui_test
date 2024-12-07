//
//  ProfileCardView.swift
//  EBuddyArtist
//
//  Created by mac on 7/12/24.
//

import SwiftUI

struct ProfileCardView: View {
    var body: some View {
        CardView(
            title: "Zynx",
            status: "Available Today!",
            rating: "4.9",
            subRating: "61",
            manaRate: "110.0",
            subManaRate: ".00/1Hr"
        )
    }
}

struct ProfileCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileCardView()
            .preferredColorScheme(.dark) // Match the dark mode in the screenshot
    }
}
