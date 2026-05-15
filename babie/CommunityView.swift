//
//  CommunityView.swift
//  babie
//
//  Created by Oğuzhan Aydın on 9.05.2026.
//

import SwiftUI

struct CommunityView: View {
    @State private var selectedFilter: String = "Tümü"
    let filters = ["Tümü", "Uzman Görüşleri", "Anneler Soruyor", "Gelişim"]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(hex: "F9FAFC").ignoresSafeArea() // Genel arka plan
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        
                        // Yeni Gönderi Oluşturma Alanı
                        CreatePostBox()
                        
                        // Filtreleme / Kategori Butonları
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(filters, id: \.self) { filter in
                                    FilterPill(title: filter, isSelected: selectedFilter == filter)
                                        .onTapGesture {
                                            selectedFilter = filter
                                        }
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        // --- AKIŞ (FEED) ---
                        
                        // 1. Örnek: Uzman (Pediatrist) Gönderisi
                        FeedPostCard(
                            isExpert: true,
                            avatarInitials: "ZK",
                            avatarColor: "345C72",
                            name: "Uzm. Dr. Zeynep Kaya",
                            title: "Pediatrist",
                            time: "2 saat önce",
                            content: "Bebeklerde uyku gerilemesi genellikle 4. ay civarında başlar. Bu dönemde bebeğinizin gece sık uyanması normaldir. Rutinlerinizi bozmadan sabırlı olmaya çalışın. Uyku öncesi ılık bir banyo ve masaj rahatlatıcı olabilir.",
                            imagePlaceholder: nil,
                            likes: 342,
                            comments: 56
                        )
                        
                        // 2. Örnek: Anne Gönderisi (Fotoğraflı)
                        FeedPostCard(
                            isExpert: false,
                            avatarInitials: "İR",
                            avatarColor: "FFD8CE",
                            name: "İrem",
                            title: "Atlas'ın Annesi • 4 aylık",
                            time: "5 saat önce",
                            content: "Kızlar merhaba! Atlas bugün ilk defa desteksiz 10 saniye oturabildi! 🎉 Ek gıdaya geçiş için doktorumuz haftaya tadımlara başlayabileceğimizi söyledi. Hangi marka mama sandalyesini önerirsiniz?",
                            imagePlaceholder: "baby.photo", // Temsili görsel için SF Symbol kullanıyoruz
                            likes: 128,
                            comments: 34
                        )
                        
                        // 3. Örnek: Uzman (Diyetisyen) Gönderisi
                        FeedPostCard(
                            isExpert: true,
                            avatarInitials: "MC",
                            avatarColor: "298A53", // Yeşile çalan bir uzman rengi
                            name: "Dyt. Murat Can",
                            title: "Bebek Beslenmesi Uzmanı",
                            time: "1 gün önce",
                            content: "Ek gıdaya başlarken '3 gün kuralı' altın değerindedir. Her yeni besini 3 gün boyunca tek başına vererek alerjik reaksiyonları kolayca takip edebilirsiniz. İlk pürelerinizde kabak ve havuç gibi sindirimi kolay sebzeleri tercih edin. 🥕🥦",
                            imagePlaceholder: nil,
                            likes: 512,
                            comments: 89
                        )
                    }
                    .padding(.vertical, 10)
                }
            }
            .navigationTitle("Topluluk")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color(hex: "345C72"))
                            .font(.system(size: 16, weight: .bold))
                    }
                }
            }
        }
    }
}

// MARK: - Alt Bileşenler (Subviews)

struct CreatePostBox: View {
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                Circle()
                    .fill(Color(hex: "FFD8CE"))
                    .frame(width: 40, height: 40)
                    .overlay(Text("AY").font(.system(size: 14, weight: .bold)).foregroundColor(Color(hex: "A36653")))
                
                Text("Bir soru sor veya deneyimini paylaş...")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(Color(hex: "F2F5F7"))
                    .cornerRadius(20)
            }
            
            HStack {
                ActionButton(icon: "photo.on.rectangle.angled", text: "Fotoğraf", color: "345C72")
                Spacer()
                ActionButton(icon: "video.fill", text: "Video", color: "A36653")
                Spacer()
                ActionButton(icon: "doc.text.fill", text: "Makale", color: "298A53")
            }
            .padding(.horizontal, 8)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .padding(.horizontal)
        .shadow(color: Color.black.opacity(0.02), radius: 5, x: 0, y: 2)
    }
}

struct ActionButton: View {
    var icon: String
    var text: String
    var color: String
    
    var body: some View {
        Button(action: {}) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 14))
                Text(text)
                    .font(.system(size: 13, weight: .medium))
            }
            .foregroundColor(Color(hex: color))
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(Color(hex: color).opacity(0.1))
            .cornerRadius(12)
        }
    }
}

struct FilterPill: View {
    var title: String
    var isSelected: Bool
    
    var body: some View {
        Text(title)
            .font(.system(size: 13, weight: isSelected ? .bold : .medium))
            .foregroundColor(isSelected ? .white : Color(hex: "345C72"))
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(isSelected ? Color(hex: "345C72") : Color(hex: "EEF3F6"))
            .cornerRadius(20)
    }
}

struct FeedPostCard: View {
    var isExpert: Bool
    var avatarInitials: String
    var avatarColor: String
    var name: String
    var title: String
    var time: String
    var content: String
    var imagePlaceholder: String?
    var likes: Int
    var comments: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Profil ve Başlık Alanı
            HStack(alignment: .center, spacing: 12) {
                Circle()
                    .fill(Color(hex: avatarColor).opacity(isExpert ? 1.0 : 0.8))
                    .frame(width: 44, height: 44)
                    .overlay(
                        Text(avatarInitials)
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(isExpert ? .white : Color(hex: "A36653"))
                    )
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 4) {
                        Text(name)
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(Color(hex: "333333"))
                        
                        if isExpert {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(Color(hex: "345C72"))
                                .font(.system(size: 12))
                        }
                    }
                    
                    HStack(spacing: 4) {
                        Text(title)
                            .font(.system(size: 12, weight: isExpert ? .semibold : .regular))
                            .foregroundColor(isExpert ? Color(hex: "345C72") : .gray)
                        Text("•")
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                        Text(time)
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.gray)
                        .rotationEffect(.degrees(90))
                }
            }
            
            // İçerik Metni
            Text(content)
                .font(.system(size: 14))
                .foregroundColor(Color(hex: "4A4A4A"))
                .lineSpacing(4)
                .multilineTextAlignment(.leading)
            
            // Eğer görsel varsa (Annelerin fotoğraf paylaşımı)
            if let img = imagePlaceholder {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(hex: "F2F5F7"))
                    .frame(height: 180)
                    .overlay(
                        VStack(spacing: 8) {
                            Image(systemName: img)
                                .font(.system(size: 40))
                                .foregroundColor(.gray.opacity(0.5))
                            Text("Anne tarafından yüklenen fotoğraf")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                    )
            }
            
            Divider()
                .padding(.vertical, 4)
            
            // Alt Etkileşim Butonları (Beğen, Yorum, Paylaş)
            HStack {
                InteractionButton(icon: "heart", text: "\(likes)")
                Spacer()
                InteractionButton(icon: "message", text: "\(comments)")
                Spacer()
                InteractionButton(icon: "arrowshape.turn.up.right", text: "Paylaş")
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .padding(.horizontal)
        .shadow(color: Color.black.opacity(0.03), radius: 6, x: 0, y: 3)
    }
}

struct InteractionButton: View {
    var icon: String
    var text: String
    
    var body: some View {
        Button(action: {}) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 16))
                Text(text)
                    .font(.system(size: 13, weight: .medium))
            }
            .foregroundColor(.gray)
        }
    }
}

// Preview
struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
    }
}
