import SwiftUI

enum Tabs: String, CaseIterable {
    case today = "Today"
    case all = "All"
    case overtime = "Overtime"
}

struct HorizontalScroll: View {
    @State private var selectedTab: Tabs = .today
    @State private var scrollOffset: CGFloat = 0

    private let userid: String
    
    init(userid: String) {
        self.userid = userid
    }
    
    var body: some View {
        VStack {
            // Custom tab bar
            HStack(spacing: 0) {
                ForEach(Tabs.allCases, id: \.self) { tab in
                    Text(tab.rawValue)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .contentShape(Capsule())
                        .foregroundColor(selectedTab == tab ? .black : .gray)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                selectedTab = tab
                                scrollOffset = -CGFloat(Tabs.allCases.firstIndex(of: tab)!) * UIScreen.main.bounds.width
                            }
                        }
                }
            }
            .background {
                GeometryReader { geometry in
                    let size = geometry.size
                    let capsuleWidth = size.width / CGFloat(Tabs.allCases.count)
                    Capsule()
                        .frame(width: capsuleWidth, height: 4)
                        //.foregroundColor(.blue)
                        .offset(x: -scrollOffset / size.width * capsuleWidth)
                        .animation(.easeInOut, value: scrollOffset)
                }
            }
            .background(.gray.opacity(0.1), in: Capsule())
            .padding(.horizontal)

            // Tab content with real data (no scrolling, only view via tab taps)
            ZStack {
                newItemsView(userid: userid, filter: .today)
                    .opacity(selectedTab == .today ? 1 : 0)
                    .frame(width: UIScreen.main.bounds.width)

                newItemsView(userid: userid, filter: .all)
                    .opacity(selectedTab == .all ? 1 : 0)
                    .frame(width: UIScreen.main.bounds.width)

                newItemsView(userid: userid, filter: .overtime)
                    .opacity(selectedTab == .overtime ? 1 : 0)
                    .frame(width: UIScreen.main.bounds.width)
            }
            .animation(.easeInOut, value: selectedTab)
        }
    }
}

#Preview {
    HorizontalScroll(userid: "iNuMaZ06z6ThioA5jjwXAsXMPiZ2")
}
