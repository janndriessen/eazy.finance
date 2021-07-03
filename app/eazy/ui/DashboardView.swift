//
//  DashboardView.swift
//  eazy
//
//  Created by Jann Driessen on 24.06.21.
//

import SwiftUI

struct DashboardView: View {
    @State private var notificationMessage = "Your borrowed money is ready for payout.\nTap here to send it."
    @State private var showPayoutMessage = false
    @State private var showPayoutModal = false
    let transactions = ["tx1", "tx2", "tx3", "tx4", "tx5"]

    private let paymentsApi = PaymentsApi()

    var body: some View {
        ZStack(alignment: .top) {
            EazyColor.background.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading) {
                    HStack(alignment: .bottom) {
                        Text("Hi Alice/Bob 👋🏼🕶")
                            .font(.system(.title, design: .rounded))
                        Spacer()
                        Text("💳")
                            .onTapGesture {
                                CardsApi().testAuth()
                            }
                    }
                    .padding()
                    BorrowView(apy: "3.10%")
                    EarnView(apy: "2.03%")
                    TransactionsHeaderView()
                        .padding()
                    ForEach(transactions, id: \.self) { _ in
                        TransactionListItem()
                    }
                }
                .padding()
            }
            MessageView(message: notificationMessage)
                .offset(x: 0, y: showPayoutMessage ? 0 : -150)
                .onTapGesture {
                    showPayoutMessage.toggle()
                    showPayoutModalScreen()
                }
                .sheet(isPresented: $showPayoutModal, content: {
                    NavigationView {
                        PayoutView()
                    }
                })
        }
        .onAppear() {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                togglePayoutMessage()
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                    togglePayoutMessage()
//                }
//            }
            paymentsApi.checkPaymentStatus(for: "7478d655-7c80-40df-b90d-e92767d0c037") { result in
                DispatchQueue.main.async {
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(_):
                        self.notificationMessage = "You're payment was accepted. Tap here\nfor more details."
                        self.showPayoutMessage.toggle()
                    }
                }
            }
        }
    }

    private func togglePayoutMessage() {
        withAnimation {
            self.showPayoutMessage.toggle()
        }
    }

    private func showPayoutModalScreen() {
        withAnimation {
            self.showPayoutModal = true
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}

private struct MessageView: View {
    var message: String

    var body: some View {
        VStack(alignment: .center) {
            Text(message)
                .font(.system(.subheadline, design: .rounded))
                .fixedSize()
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 15.0)
                        .fill(EazyColor.highlight))
        }
    }
}

private struct BorrowView: View {
    var apy: String

    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(
                    LinearGradient(gradient: EazyGradient.borrow,
                                   startPoint: .top,
                                   endPoint: .bottom))
                .frame(height: 210)
            VStack(alignment: .leading) {
                HStack(alignment: .bottom) {
                    Text("BORROW")
                        .font(.system(.title, design: .rounded).bold())
                        .foregroundColor(EazyColor.headline)
                    Spacer()
                    Text("APY \(apy)")
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(EazyColor.title)
                }
                VStack(alignment: .leading) {
                    HStack {
                        Text("$1,000.00")
                            .font(.system(.headline, design: .rounded))
                            .padding(8)
                        Text("Borrowed")
                            .font(.system(.subheadline, design: .rounded))
                    }
                    HStack {
                        Text("$1,000.00")
                            .font(.system(.headline, design: .rounded))
                            .padding(8)
                        Text("Collateral")
                            .font(.system(.subheadline, design: .rounded))
                    }
                }
                .padding(.leading, -6)
                .padding(.vertical, 12)
                HStack {
                    ZStack {
                        Text("Borrow More")
                            .font(.system(.subheadline, design: .rounded).bold())
                            .foregroundColor(EazyColor.element)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 15.0)
                                    .fill(EazyColor.button.opacity(0.56)))
                    }
                    Spacer()
                    ZStack {
                        Text("Repay")
                            .font(.system(.subheadline, design: .rounded).bold())
                            .foregroundColor(EazyColor.element)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 15.0)
                                    .fill(EazyColor.button.opacity(0.86)))
                    }
                }
            }
            .padding()
        }
    }
}

private struct EarnView: View {
    var apy: String

    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(
                    LinearGradient(gradient: EazyGradient.element,
                                   startPoint: .top,
                                   endPoint: .bottom))
                .frame(height: 164)
            VStack(alignment: .leading) {
                HStack(alignment: .bottom) {
                    Text("EARN")
                        .font(.system(.title, design: .rounded).bold())
                        .foregroundColor(EazyColor.headline)
                    Spacer()
                    Text("APY \(apy)")
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(EazyColor.title)
                }
                Text("Supply some money via your added\npayment methods and start earning.")
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(EazyColor.text)
                    .padding(.vertical, 4)
                ZStack {
                    Text("Start Earning")
                        .font(.system(.subheadline, design: .rounded).bold())
                        .foregroundColor(EazyColor.element)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 15.0)
                                .fill(EazyColor.button.opacity(0.86)))
                }
            }
            .padding()
        }
    }
}

private struct TransactionsHeaderView: View {
    var body: some View {
        HStack(alignment: .bottom) {
            Text("Transactions")
                .font(.system(.headline, design: .rounded).bold())
            Spacer()
            Text("see all")
                .font(.system(.subheadline, design: .rounded))
                .foregroundColor(EazyColor.text)
        }
    }
}

private struct TransactionListItem: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("0xf2c7ca6...d73f")
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(EazyColor.highlight)
                Text("12:00")
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(EazyColor.text)
            }
            Spacer()
            Spacer()
            VStack {
                ZStack(alignment: .center) {
                    Text("pending")
                        .font(.system(.footnote, design: .rounded))
                        .foregroundColor(EazyColor.title.opacity(0.6))
                        .padding(.vertical, 4)
                        .padding(.horizontal, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(EazyColor.pending.opacity(0.1))
                        )
                }
                Spacer()
            }
            .padding(.trailing, 8)
            VStack(alignment: .trailing) {
                Text("1,000 USDC")
                    .font(.system(.body, design: .rounded))
                    .foregroundColor(EazyColor.title)
                Text("$1,000")
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(EazyColor.text)
            }
        }
        .padding(.bottom, 16)
        .padding(.horizontal, 8)
    }
}
