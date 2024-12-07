//
//  CardView.swift
//  EBuddyArtist
//
//  Created by mac on 7/12/24.
//

import SwiftUI

struct CardView: View {
    
    let title: String
    let status: String
    let rating: String
    let subRating: String
    let manaRate: String
    let subManaRate: String
    
    var body: some View {
        VStack(alignment:.leading, spacing: 24) {
            // Header
            HStack {
                HStack(spacing: 18) {
                    Text(title)
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                    
                    Circle()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color(hex: "#4CAF4F"))
                }
                
                Spacer()
                
                HStack(spacing: 24) {
                    Image("blue-star")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                    
                    
                    Image("instagram")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                }
            }
            .padding([.horizontal, .top])
            // Header
            
            // Image Section
            ZStack(alignment: .topLeading) {
                Image("artist-korea")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 260)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                VStack(alignment: .leading, spacing: 168) {
                    HStack(spacing: 10) {
                        Image("lightning")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 20, height: 20)
                        
                        Text(status)
                            .font(.system(size: 18))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }
                    .frame(width: 170, height: 28)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.black.opacity(0.7))
                    .clipShape(Capsule())
                    
                    // Game icons
                    HStack{
                        HStack(spacing: -10) {
                            Image("cod")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .overlay(
                                    Circle().stroke(Color.white, lineWidth: 2)
                                )
                            
                            ZStack {
                                Image("mobile_legends")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                    .overlay(
                                        Circle().stroke(Color.white, lineWidth: 2)
                                    )
                                ZStack {
                                    Circle()
                                        .fill(Color("circle").opacity(0.5))
                                        .frame(width: 60, height: 60)
                                    
                                    Text("+3")
                                        .font(.system(size: 18))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("circleText"))
                                        .padding(4)
                                }
                            }
                        }
                        
                        Spacer()
                        
                        Image("voice-purple")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.white)
                    }
                    // Game icons
                    
                }
                .padding([.top, .horizontal], 12)
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(radius: 3)
            
            
            // Star Rating and Price
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 4) {
                    Image("yellow-star")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                    
                    Text(rating)
                        .font(.headline)
                    
                    Text(subRating)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                HStack(spacing: 3) {
                    Image("mana-fire")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                    
                    HStack(spacing: 0){
                        Text(manaRate)
                            .font(.headline)
                        Text(subManaRate)
                            .font(.subheadline)
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .frame(maxHeight: 440)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 5)
        .padding()
    }
}
