import SwiftUI
import Combine

struct StudentDetailsView: View {
    @ObservedObject var viewModel = MainViewModel()
    var data: Student
    var body: some View {
        ZStack {
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    VStack {
                        Spacer()
                        if let callLogs = viewModel.callLogs, !viewModel.packageDetails.isEmpty {
                            ScrollView{
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(.white)
                                        .shadow(color: .gray, radius: 4)
                                        .frame(width: 360, height: 120)
                                        .overlay(
                                            HStack {
                                                Image("ic_launcher_round")
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fit)
                                                    .frame(width: 80, height: 80, alignment: .top)
                                                    .clipShape(Circle())
                                                    .shadow(color: Color.defaultBlue, radius: 4)
                                                VStack(alignment: .center) {
                                                    Text(data.name)
                                                        .font(.headline)
                                                        .fontWeight(.bold)
                                                        .foregroundColor(.black)
                                                    Text(data.username)
                                                        .font(.subheadline)
                                                        .fontWeight(.bold)
                                                        .foregroundColor(Color.defaultOrange)
                                                }
                                                .padding()
                                                Spacer()
                                            }
                                        )
                                }
                                HStack {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 20)
                                            .foregroundColor(.white)
                                            .shadow(color: .gray, radius: 4)
                                            .frame(width: 160, height: 120)
                                            .padding([.horizontal], 10)
                                        VStack {
                                            Text("Token Balance")
                                                .font(.title3)
                                                .fontWeight(.regular)
                                                .foregroundColor(.black)
                                            Text("\(data.token ?? 0.00, specifier: "%.2f")")
                                                .font(.headline)
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                        }
                                        .padding()
                                    }
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 20)
                                            .foregroundColor(.white)
                                            .shadow(color: .gray, radius: 4)
                                            .frame(width: 160, height: 120)
                                            .padding([.horizontal], 10)
                                        VStack {
                                            Text("Relative Minutes")
                                                .font(.title3)
                                                .fontWeight(.regular)
                                                .foregroundColor(.black)
                                            Text("\((data.token ?? 0.00) / data.token_rate_per_min, specifier: "%.2f")")
                                                .font(.headline)
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                        }
                                        .padding()
                                    }
                                }
                                packageViews
                                callLogViews(callLogs: callLogs)
                                ContactUs()
                            }}
                        else if viewModel.errorMessage.isEmpty {
                                           Text("Loading...")
                                               .foregroundColor(.white)
                                               .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                       } else {
                                           ErrorView(errorMessage: viewModel.errorMessage) {
                                               reloadData()
                                           }
                                           .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                                       }
                        
                    }
                    
                }
                .onAppear {
                reloadData()
                }
            }
        
    }
    private func reloadData() {
        if let details = loadDetails() {
            viewModel.getPaymentPackages(token: details.access_token, jwtAuth: details.jwt_token)
            viewModel.getCallLogs(token: details.access_token, jwtAuth: details.jwt_token, student_id: data.id, page: "1")
        } else {
            viewModel.errorMessage = "Failed to load details from UserDefaults."
          
        }
    }

    private func loadDetails() -> Details? {
        if let savedDetailsData = UserDefaults.standard.data(forKey: "details") {
            let decoder = JSONDecoder()
            if let loadedDetails = try? decoder.decode(Details.self, from: savedDetailsData) {
                return loadedDetails
            }
        }
        return nil
    }

    private var packageViews: some View {
        ZStack {
            Image("card_background")
                .resizable()
                .frame(width: 360, height: 200)
                .cornerRadius(20)
                .overlay(
                    ScrollView(.horizontal) {
                        HStack(alignment: .center, spacing: 26) {
                            ForEach(viewModel.packageDetails, id: \.id) { package in
                                PackageView(Data: package,student:data)
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                )
        }
    }

    private func callLogViews(callLogs: CommunicationResponse) -> some View {
        ZStack {
            Image("card_background")
                .resizable()
                .frame(width: 360, height: 400)
                .cornerRadius(20)
                .overlay(
                    VStack {
                        Text("Call Logs")
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        ScrollView(.vertical) {
                            VStack(alignment: .center, spacing: 10) {
                                ForEach(callLogs.results, id: \.id) { data in
                                    CallLogView(Data: data)
                                }
                            }
                        }
                    }
                )
        }
    }
}
