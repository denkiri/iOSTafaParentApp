//
//  PackageView.swift
//  TafaParentApp
//
//  Created by Macbook Pro on 20/05/2024.
//
import SwiftUI
import Combine
let samplePackageData = PaymentPackagesItem(amount: "50", id: "1")
struct PackageView: View {
    var Data: PaymentPackagesItem
    var student: Student
    @State private var showPaymentDialog = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
                .shadow(color: .gray, radius: 4)
                .frame(width: 150, height: 160)
                .padding([.horizontal], 10)
                .overlay(
                    VStack(alignment: .center) {
                        Text("Recharge")
                            .font(.title3)
                            .fontWeight(.regular)
                            .foregroundColor(.black)
                        Text("Tokens")
                            .font(.title3)
                            .fontWeight(.regular)
                            .foregroundColor(.black)
                        Text("KSH \(Data.amount)")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                        Button(action: {
                            showPaymentDialog = true
                        }) {
                            RoundedRectangle(cornerRadius: 120)
                                .frame(width: 100, height: 40, alignment: .center)
                                .foregroundColor(Color.green)
                                .shadow(color: .gray, radius: 8)
                                .overlay(Text("Pay"))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                                .padding()
                        }
                    }
                )
        }
        .sheet(isPresented: $showPaymentDialog) {
            let amountInDouble: String = Data.amount
            let amountInt: Double = Double(amountInDouble) ?? 0.00
            PaymentConfirmationView(showPaymentDialog: $showPaymentDialog,student: student,amount: Int(amountInt))
        }
    }
}

import Combine
import SwiftUI
struct PaymentConfirmationView: View {
    @ObservedObject var viewModel = MainViewModel()
    @Binding var showPaymentDialog: Bool
    var student: Student
    var amount: Int
    @State private var isLoading: Bool = false
    @State private var showAlert: Bool = false
    @State private var phoneNumber: String = ""
    @State private var timerCancellable: AnyCancellable?
    @AppStorage("invoice") private var invoice: String?

    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack {
                   if let invoiceStatus = viewModel.invoiceStatus {
                       statusView(for: invoiceStatus.details.status)
                           .onAppear {
                               if invoiceStatus.details.status == "PENDING", let details = loadDetails(), let invoice = invoice {
                                   startTimer(token: details.access_token, jwtAuth: details.jwt_token, invoice_id: invoice)
                               }
                           }
                           .onDisappear {
                               stopTimer()
                           }
                   } else {
                       
                       confirmPurchaseView()
                   }
               }
               
               .padding()
               .alert(isPresented: $showAlert) {
                          Alert(title: Text("Error"), message: Text("Phone number cannot be empty."), dismissButton: .default(Text("OK")))
                      }
           }
           .frame(maxWidth: .infinity, maxHeight: .infinity)
           .background(Color.clear)
       }


    private func startTimer(token: String, jwtAuth: String, invoice_id: String) {
        timerCancellable = Timer.publish(every: 5.0, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if let details = loadDetails(), let invoice = UserDefaults.standard.string(forKey: "invoice") {
                    viewModel.getInvoiceStatus(token: details.access_token, jwtAuth: details.jwt_token, invoice_id: invoice)
                }
            }
    }

    private func stopTimer() {
        timerCancellable?.cancel()
        timerCancellable = nil
    }

    private func statusView(for status: String) -> some View {
        VStack {
            switch status {
            case "COMPLETE":
                successView()
            case "CANCELLED":
                cancelledView()
            case "PENDING":
                pendingView()
            default:
                unexpectedStatusView(status: status)
            }
        }
    }

    private func successView() -> some View {
        VStack {
            Image(systemName: "checkmark.circle")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)
            Text("Payment Successful")
                .font(.headline)
                .padding()
            Button("Home") {
                showPaymentDialog = false
            }
            .buttonStyle(FilledButtonStyle(color: .green))
        }
        .padding()
        .onAppear {
            stopTimer()
        }
    }

    private func cancelledView() -> some View {
        VStack {
            Image(systemName: "xmark.circle")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
            Text("Payment Failed")
                .font(.headline)
                .padding()
            Button("Try Again") {
                // Handle Try Again action
            }
            .buttonStyle(FilledButtonStyle(color: .green))
        }
        .padding()
        .onAppear {
            stopTimer()
        }
    }

    private func pendingView() -> some View {
        VStack {
            Image(systemName: "clock")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.orange)
            Text("Awaiting Payment")
                .foregroundColor(Color.black)
                .font(.headline)
                .padding()
            Button("Cancel") {
                showPaymentDialog = false
            }
            .buttonStyle(FilledButtonStyle(color: Color.defaultOrange))
        }
        .padding()
    }

    private func unexpectedStatusView(status: String) -> some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
            Text("Unexpected status: \(status)")
                .font(.headline)
                .padding()
        }
        .padding()
        .onAppear {
            stopTimer()
        }
    }

    private func confirmPurchaseView() -> some View {
        
        VStack {
            if isLoading {
                ProgressView("Processing...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .tint(.green)
                    .font(.title2)
                    .foregroundColor(Color.black)
                    .padding(.top, 15)
                    
            }
            else
            {
                Text("Confirm Purchase")
                    .foregroundColor(Color.black)
                    .font(.title2)
                    .bold()
                    .padding(.top, 15)
                Divider()
                    .padding(.vertical, 10)
                Text("Please enter a valid active Mpesa Number to receive an M-pesa prompt on your phone")
                    .foregroundColor(Color.black)
                    .font(.body)
                    .padding(5)
                TextField("Enter Mobile", text: $phoneNumber)
                    .padding(10)
                    .frame(width: 350)
                    .font(Font.system(size: 15, weight: .medium, design: .serif))
                    .foregroundColor(.black)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 0.5)
                        .frame(height: 45))
                    .multilineTextAlignment(.center)
                    .padding(10)
                Divider()
                    .background(Color.orange)
                    .padding(.vertical, 20)
                HStack(spacing: 20) {
                    Button("Cancel") {
                        showPaymentDialog = false
                    }
                    .buttonStyle(FilledButtonStyle(color: Color.defaultOrange))
                    Button("Pay Now") {
                        if phoneNumber.isEmpty {
                            showAlert = true
                        }
                        else{
                            isLoading = true
                            if let details = loadDetails() {
                                viewModel.TopUpStudentTokens(token: details.access_token, jwtAuth: details.jwt_token, amount: amount, phone_number: phoneNumber, service_type: "TOPUP", student_id: student.id)
                            } else {
                                isLoading = false
                                print("Failed to load details from UserDefaults.")
                            }
                        }}
                    .buttonStyle(FilledButtonStyle(color: Color.green))
                }
                .padding(.top, 30)
            }}
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 20)
                .frame(maxWidth: 400)
        }
    
    private func handleStatusAppear(status: String) {
        if status != "PENDING" {
            stopTimer()
        }
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

struct FilledButtonStyle: ButtonStyle {
    var color: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(5)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

//#Preview {
//    PackageView(Data: samplePackageData, student: Student)
//}
