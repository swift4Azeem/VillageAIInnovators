//
//  PaymentSheetView.swift
//  RurelApp
//
//  Created by harleen.sabherwal on 11/07/25.
//

import SwiftUI

struct PaymentSheetView: View {
    
    // MARK: - Properties
    let amount: Double
    let onPaymentSuccess: () -> Void

    // MARK: - Constants
    private enum Constants {
        static let ruralSharePercentage: Double = 0.90
        static let developerSharePercentage: Double = 0.10
        static let buttonCornerRadius: CGFloat = 12
    }

    // MARK: - Computed Properties
    private var ruralShare: Double {
        amount * Constants.ruralSharePercentage
    }

    private var developerShare: Double {
        amount * Constants.developerSharePercentage
    }

    // MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            header
            paymentBreakdown
            Spacer()
            payButton
        }
        .padding()
    }

    // MARK: - Subviews
    private var header: some View {
        Text(AppStrings.PaymentSheetView.paymentSummary)
            .font(.headline)
    }

    private var paymentBreakdown: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(AppStrings.PaymentSheetView.totalAmount): $\(amount, specifier: "%.2f")")
            Text("\(AppStrings.PaymentSheetView.ruralPartnerShare): $\(ruralShare, specifier: "%.2f")")
            Text("\(AppStrings.PaymentSheetView.appDeveloperShare): $\(developerShare, specifier: "%.2f")")
        }
    }

    private var payButton: some View {
        Button(action: onPaymentSuccess) {
            HStack {
                Image(systemName: AppStrings.Images.credit)
                Text(AppStrings.PaymentSheetView.payButton)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(Constants.buttonCornerRadius)
        }
        .accessibilityIdentifier(AppStrings.Images.pay)
    }
}
