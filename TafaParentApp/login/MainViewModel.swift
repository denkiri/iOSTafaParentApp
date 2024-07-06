import Foundation
import Combine

class MainViewModel: ObservableObject {
    @Published var showingAlert = false
    @Published var errorMessage = ""
    @Published var loadedDetails: Details?
    @Published var profileDetails: ProfileDetails?
    @Published var callLogs:CommunicationResponse?
    @Published var packageDetails:[PaymentPackagesItem] = []
    private var cancellables = Set<AnyCancellable>()

    func login(username: String, password: String) {
        guard let url = URL(string: API.loginEndpoint) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let loginDetails = LoginDetails(username: username, password: password)
        guard let httpBody = try? JSONEncoder().encode(loginDetails) else { return }
        request.httpBody = httpBody

        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                switch httpResponse.statusCode {
                case 200...299:
                    return result.data
                case 400:
                    let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: result.data)
                    throw HTTPErrorResponse.badRequest(errorResponse?.details ?? "Bad Request")
                case 401:
                    throw HTTPErrorResponse.unauthorized("Unauthorized")
                case 403:
                    throw HTTPErrorResponse.forbidden("Forbidden")
                case 500:
                    throw HTTPErrorResponse.serverError("Internal Server Error")
                default:
                    throw HTTPErrorResponse.unknown("Unknown Error")
                }
            }
            .decode(type: Auth.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.showingAlert = true
                case .finished:
                    break
                }
            }, receiveValue: { auth in
                self.saveDetails(auth.details)
                self.getProfile(token: auth.details.access_token, jwtAuth: auth.details.jwt_token)
            })
            .store(in: &self.cancellables)
    }
    func getProfile(token: String, jwtAuth: String) {
        guard let url = URL(string: API.profileEndpoint) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("Bearer \(jwtAuth)", forHTTPHeaderField: "JWTAUTH")

        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                switch httpResponse.statusCode {
                case 200...299:
                    return result.data
                case 401:
                    throw HTTPErrorResponse.unauthorized("Unauthorized")
                case 403:
                    throw HTTPErrorResponse.forbidden("Forbidden")
                case 500:
                    throw HTTPErrorResponse.serverError("Internal Server Error")
                default:
                    throw HTTPErrorResponse.unknown("Unknown Error")
                }
            }
            .decode(type: ProfileResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.showingAlert = true
                case .finished:
                    break
                }
            }, receiveValue: { profile in
                self.profileDetails = profile.details.profile
                self.loadedDetails = self.loadDetails()
                UserDefaults.standard.set(true, forKey: "isLoggedIn")
               // print("Profile details fetched successfully: \(profile.details)")
            })
            .store(in: &self.cancellables)
    }
    func getPaymentPackages(token: String, jwtAuth: String) {
        guard let url = URL(string: API.paymentsPackages) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("Bearer \(jwtAuth)", forHTTPHeaderField: "JWTAUTH")

        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                switch httpResponse.statusCode {
                case 200...299:
                    return result.data
                case 401:
                    throw HTTPErrorResponse.unauthorized("Unauthorized")
                case 403:
                    throw HTTPErrorResponse.forbidden("Forbidden")
                case 500:
                    throw HTTPErrorResponse.serverError("Internal Server Error")
                default:
                    throw HTTPErrorResponse.unknown("Unknown Error")
                }
            }
            .decode(type: [PaymentPackagesItem].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print("Error loading packages")
                    self.showingAlert = true
                case .finished:
                    break
                }
            }, receiveValue: { packages in
                self.packageDetails = packages
                print("packages fetched successfully: \(packages)")
            })
            .store(in: &self.cancellables)
    }
    func getCallLogs(token: String, jwtAuth: String,student_id: String, page: String) {
        guard var urlComponents = URLComponents(string: API.callLogs) else { return }
        urlComponents.queryItems = [
            URLQueryItem(name: "student_id", value: student_id),
            URLQueryItem(name: "page", value: page)
        ]
        
        guard let url = urlComponents.url else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("Bearer \(jwtAuth)", forHTTPHeaderField: "JWTAUTH")

        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Data in
                guard let httpResponse = result.response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                switch httpResponse.statusCode {
                case 200...299:
                    return result.data
                case 401:
                    throw HTTPErrorResponse.unauthorized("Unauthorized")
                case 403:
                    throw HTTPErrorResponse.forbidden("Forbidden")
                case 500:
                    throw HTTPErrorResponse.serverError("Internal Server Error")
                default:
                    throw HTTPErrorResponse.unknown("Unknown Error")
                }
            }
            .decode(type: CommunicationResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.showingAlert = true
                case .finished:
                    break
                }
            }, receiveValue: { callLogs in
                self.callLogs = callLogs
                print("callLogs details fetched successfully: \(callLogs)")
            })
            .store(in: &self.cancellables)
    }

    private func saveDetails(_ details: Details) {
        let encoder = JSONEncoder()
        if let encodedDetails = try? encoder.encode(details) {
            UserDefaults.standard.set(encodedDetails, forKey: "details")
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
    func logout() {
        UserDefaults.standard.removeObject(forKey: "details")
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
    }
    
}

