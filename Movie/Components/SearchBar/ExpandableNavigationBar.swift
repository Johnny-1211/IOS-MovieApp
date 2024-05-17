import SwiftUI

struct ExpandableNavigationBar: View {
    @Binding var searchText: String
    @Binding var activeTab: Tab
    @Environment(\.colorScheme) private var scheme
    @Namespace private var animation
    @FocusState private var isSearching: Bool
    
    let title : String
    
    var body: some View {
        GeometryReader{ proxy in
            let minY = proxy.frame(in: .scrollView(axis: .vertical)).minY
            let scrollViewHeight = proxy.bounds(of: .scrollView(axis: .vertical))?.height ?? 0
            let scaleProgress = minY > 0 ? 1 + (max(min(minY / scrollViewHeight, 1), 0) * 0.5) : 1
            let progress = isSearching ? 1 : max(min(-minY / 70, 1), 0)
            
            VStack(spacing: 10){
                
                Text(title)
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                    .keyboardType(.alphabet)
                    .scaleEffect(scaleProgress, anchor: .topLeading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 10)
                
                HStack(spacing:12){
                    Image(systemName: "magnifyingglass")
                        .font(.title3)
                    
                    TextField("", text: $searchText, prompt: Text("Search Movie").foregroundStyle(.gray))
                        .focused($isSearching)
                    
                    if isSearching{
                        Button{
                            isSearching = false
                            searchText = ""
                        } label: {
                            Image(systemName: "xmark")
                                .font(.title3)
                        }
                        .transition(.asymmetric(insertion: .push(from: .bottom), removal: .push(from: .top)))
                    }
                }
                .foregroundStyle(Color.black)
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .frame(height: 45)
                .clipShape(.capsule)
                .background{
                    RoundedRectangle(cornerRadius: 25.0 - (progress * 25))
                        .fill(Color.white)
                        .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 0)
                        .padding(.top, -progress * 190)
                        .padding(.bottom, -progress * 65)
                        .padding(.horizontal, -progress * 20)
                }
                
                ScrollView (.horizontal){
                    HStack(spacing:12){
                        ForEach(Tab.allCases, id: \.rawValue){ tab in
                            Button(action: {
                                withAnimation(.snappy){
                                    activeTab = tab
                                }
                            }, label: {
                                Text(tab.rawValue)
                                    .font(.callout)
                                    .foregroundStyle(activeTab == tab ? Color.white : Color.black)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 15)
                                    .background{
                                        if activeTab == tab {
                                            Capsule()
                                                .fill(Color.black)
                                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                                        } else {
                                            Capsule()
                                                .fill(Color.white)
                                        }
                                    }
                            })
                            .buttonStyle(.plain)
                        }
                    }
                }
                
            }
            .padding(.top,25)
            .safeAreaPadding(.horizontal, 20)
            .offset(y: minY < 0 || isSearching ? -minY : 0)
            .offset(y: -progress * 65)
        }
        .frame(height: 190)
        .padding(.bottom, 10)
        .padding(.bottom, isSearching ? -65 : 0)
        .animation(.snappy(duration: 0.3, extraBounce: 0), value: isSearching)
    }
}


