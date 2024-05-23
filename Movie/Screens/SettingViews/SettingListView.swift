import SwiftUI

struct SettingListView: View {
    @EnvironmentObject var fireAuthHelper : FireAuthHelper
    @EnvironmentObject var fireDBHelper : FireDBHelper

    var body: some View {
        NavigationStack{
            ZStack{
                VStack(alignment: .leading, spacing: 12){
                    Text("Account")
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 20)
                    
                    List{
                        NavigationLink {
                            NameUpdateView()
                        } label: {
                            Text("Update user name")
                        }
                        
                        NavigationLink {
                            EmailUpdateView()
                        } label: {
                            Text("Update email")
                        }
                        
                        NavigationLink {
                            PasswordUpdateView()
                        } label: {
                            Text("Update password")
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .environmentObject(fireDBHelper)
                    .environmentObject(fireAuthHelper)
                }
                .background(Color("background"))
            }
        }
    }
}


#Preview {
    var fireDBHelper = FireDBHelper.getInstance()
    var fireAuthHelper = FireAuthHelper()
    return SettingListView()
        .environmentObject(fireDBHelper)
        .environmentObject(fireAuthHelper)
}
