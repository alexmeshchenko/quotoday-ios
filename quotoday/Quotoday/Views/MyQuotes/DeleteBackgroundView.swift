//
//  DeleteBackgroundView.swift
//  Quotoday
//
//  Created by Aleksandr Meshchenko on 03.08.25.
//

import SwiftUI

struct DeleteBackgroundView: View {
    let onDelete: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            
            Button(action: onDelete) {
                HStack {
                    Spacer()
                    VStack(spacing: 4) {
                        Image(systemName: "trash.fill")
                            .font(.title2)
                        Text("Delete")
                            .font(.caption)
                    }
                    .foregroundColor(.white)
                    .frame(width: 80)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.red)
            }
        }
        .background(Color.red)
        .cornerRadius(12)
    }
}
