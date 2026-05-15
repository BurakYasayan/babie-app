//
//  OrdersView.swift
//  babie
//
//  Created by Oğuzhan Aydın on 9.05.2026.
//

import SwiftUI

struct OrdersView: View {
    @State private var selectedTab: Int = 0 // 0: Aktif Siparişler, 1: Geçmiş Siparişler
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "F9FAFC").ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Üst Sekmeler (Aktif / Geçmiş)
                    HStack(spacing: 0) {
                        TabButton(title: "Aktif Siparişler", isSelected: selectedTab == 0) {
                            withAnimation(.easeInOut) { selectedTab = 0 }
                        }
                        TabButton(title: "Geçmiş Siparişler", isSelected: selectedTab == 1) {
                            withAnimation(.easeInOut) { selectedTab = 1 }
                        }
                    }
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.02), radius: 5, x: 0, y: 3)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 16) {
                            if selectedTab == 0 {
                                // Aktif Siparişler
                                OrderCardView(
                                    orderNo: "BB-8472910",
                                    date: "14 Ağustos 2026",
                                    status: .shipped,
                                    itemCount: 2,
                                    price: "₺1.199",
                                    imageIcons: ["cube.box.fill", "tshirt.fill"]
                                )
                                
                                OrderCardView(
                                    orderNo: "BB-8472915",
                                    date: "16 Ağustos 2026",
                                    status: .processing,
                                    itemCount: 1,
                                    price: "₺349",
                                    imageIcons: ["cross.case.fill"]
                                )
                            } else {
                                // Geçmiş Siparişler
                                OrderCardView(
                                    orderNo: "BB-7361922",
                                    date: "14 Temmuz 2026",
                                    status: .delivered,
                                    itemCount: 3,
                                    price: "₺1.199",
                                    imageIcons: ["cube.box.fill", "tshirt.fill", "drop.fill"]
                                )
                                
                                OrderCardView(
                                    orderNo: "BB-6251833",
                                    date: "14 Haziran 2026",
                                    status: .delivered,
                                    itemCount: 2,
                                    price: "₺999",
                                    imageIcons: ["cube.box.fill"]
                                )
                            }
                        }
                        .padding(.vertical, 20)
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Siparişlerim")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Subviews

struct TabButton: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                Text(title)
                    .font(.system(size: 15, weight: isSelected ? .bold : .medium))
                    .foregroundColor(isSelected ? Color(hex: "345C72") : .gray)
                
                // Alt Çizgi
                Rectangle()
                    .fill(isSelected ? Color(hex: "345C72") : Color.clear)
                    .frame(height: 3)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 16)
    }
}

enum OrderStatus {
    case processing
    case shipped
    case delivered
    
    var title: String {
        switch self {
        case .processing: return "Hazırlanıyor"
        case .shipped: return "Kargoya Verildi"
        case .delivered: return "Teslim Edildi"
        }
    }
    
    var colorHex: String {
        switch self {
        case .processing: return "E58E26" // Turuncu
        case .shipped: return "345C72"    // Lacivert
        case .delivered: return "298A53"  // Yeşil
        }
    }
    
    var icon: String {
        switch self {
        case .processing: return "clock.fill"
        case .shipped: return "box.truck.fill"
        case .delivered: return "checkmark.circle.fill"
        }
    }
}

struct OrderCardView: View {
    var orderNo: String
    var date: String
    var status: OrderStatus
    var itemCount: Int
    var price: String
    var imageIcons: [String]
    
    var body: some View {
        VStack(spacing: 0) {
            // Üst Kısım: Tarih ve Durum
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(date)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color(hex: "333333"))
                    Text("Sipariş No: \(orderNo)")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                // Durum Rozeti
                HStack(spacing: 4) {
                    Image(systemName: status.icon)
                        .font(.system(size: 12))
                    Text(status.title)
                        .font(.system(size: 12, weight: .bold))
                }
                .foregroundColor(Color(hex: status.colorHex))
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Color(hex: status.colorHex).opacity(0.1))
                .cornerRadius(20)
            }
            .padding()
            .background(Color(hex: "F2F5F7").opacity(0.5))
            
            Divider()
            
            // Orta Kısım: Ürün İkonları ve Fiyat
            HStack(alignment: .center) {
                // Temsili Ürün İkonları
                HStack(spacing: -10) {
                    ForEach(0..<min(imageIcons.count, 3), id: \.self) { index in
                        Circle()
                            .fill(Color(hex: "EEF3F6"))
                            .frame(width: 40, height: 40)
                            .overlay(
                                Image(systemName: imageIcons[index])
                                    .foregroundColor(Color(hex: "345C72"))
                                    .font(.system(size: 16))
                            )
                            .overlay(
                                Circle().stroke(Color.white, lineWidth: 2)
                            )
                    }
                    if imageIcons.count > 3 {
                        Circle()
                            .fill(Color(hex: "EEF3F6"))
                            .frame(width: 40, height: 40)
                            .overlay(Text("+\(imageIcons.count - 3)").font(.system(size: 12, weight: .bold)).foregroundColor(.gray))
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    }
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("\(itemCount) Ürün")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(Color(hex: "345C72"))
                }
                .padding(.leading, 8)
                
                Spacer()
                
                Text(price)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color(hex: "345C72"))
            }
            .padding()
            
            // Alt Kısım: Butonlar
            HStack(spacing: 12) {
                if status == .shipped {
                    Button(action: {}) {
                        Text("Kargo Takip")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color(hex: "345C72"))
                            .cornerRadius(8)
                    }
                }
                
                Button(action: {}) {
                    Text("Sipariş Detayı")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Color(hex: "345C72"))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.white)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(hex: "345C72").opacity(0.3), lineWidth: 1)
                        )
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 16)
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.03), radius: 6, x: 0, y: 3)
    }
}

// Preview
struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
    }
}
