import SwiftUI

struct BookingView: View {
    
    // MARK: - Constants
    private enum Constants {
        static let minPeople = 1
        static let maxPeople = 8
        static let ruralSplit: Double = 0.90
        static let developerSplit: Double = 0.10
        static let totalAmount: Double = 45.0
    }
    
    // MARK: - State
    @State private var name = ""
    @State private var email = ""
    @State private var numberOfPeople = Constants.minPeople
    @State private var date = Date()
    @State private var bookingConfirmed = false
    @State private var showPaymentSheet = false
    
    // MARK: - Computed Properties
    private var isFormValid: Bool {
        !name.isEmpty && !email.isEmpty
    }
    
    private var ruralAmount: Double {
        Constants.totalAmount * Constants.ruralSplit
    }
    
    private var developerAmount: Double {
        Constants.totalAmount * Constants.developerSplit
    }

    // MARK: - Body
    var body: some View {
        Form {
            userInfoSection
            bookingDetailsSection
            paymentSplitSection
            confirmButtonSection
        }
        .navigationTitle(AppStrings.BookingView.bookNowTitle)
        .alert(AppStrings.BookingView.bookingConfirmedTitle, isPresented: $bookingConfirmed) {
            Button(AppStrings.BookingView.okButton, role: .cancel) { }
        } message: {
            Text("\(AppStrings.BookingView.bookingConfirmedMessage) \(numberOfPeople) on \(date.formatted(date: .long, time: .omitted)).")
        }
        .sheet(isPresented: $showPaymentSheet) {
            PaymentSheetView(amount: Constants.totalAmount) {
                bookingConfirmed = true
            }
        }
    }

    // MARK: - Subviews

    private var userInfoSection: some View {
        Section(header: Text(AppStrings.BookingView.yourInfo)) {
            TextField(AppStrings.BookingView.namePlaceholder, text: $name)
            TextField(AppStrings.BookingView.emailPlaceholder, text: $email)
                .keyboardType(.emailAddress)
        }
    }

    private var bookingDetailsSection: some View {
        Section(header: Text(AppStrings.BookingView.bookingDetails)) {
            Stepper(value: $numberOfPeople, in: Constants.minPeople...Constants.maxPeople) {
                Text("\(AppStrings.BookingView.numberOfPeople): \(numberOfPeople)")
            }
            DatePicker(AppStrings.BookingView.selectDate, selection: $date, displayedComponents: .date)
        }
    }

    private var paymentSplitSection: some View {
        Section(header: Text(AppStrings.BookingView.paymentSplit)) {
            Text("\(AppStrings.BookingView.total): $\(Constants.totalAmount, specifier: "%.2f")")
            Text("\(AppStrings.BookingView.ruralShare): $\(ruralAmount, specifier: "%.2f")")
            Text("\(AppStrings.BookingView.developerShare): $\(developerAmount, specifier: "%.2f")")
        }
    }

    private var confirmButtonSection: some View {
        Section {
            Button(AppStrings.BookingView.confirmAndPay) {
                showPaymentSheet = true
            }
            .disabled(!isFormValid)
        }
    }
}
