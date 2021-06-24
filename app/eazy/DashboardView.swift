//
//  DashboardView.swift
//  eazy
//
//  Created by Jann Driessen on 24.06.21.
//

import SwiftUI

struct DashboardView: View {
    let transactions = ["tx1", "tx2", "tx3", "tx4", "tx5"]

    var body: some View {
        ZStack {
            EazyColor.background.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading) {
                    HStack(alignment: .bottom) {
                        Text("Hi Alice 👋🏼")
                            .font(.system(.title, design: .rounded))
                        Spacer()
                        Text("💳")
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
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
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
                .frame(height: 200)
            VStack {
                Text("BORROW")
                    .font(.system(.title, design: .rounded).bold())
                    .foregroundColor(EazyColor.headline)
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
                .frame(height: 200)
            VStack {
                Text("EARN")
                    .font(.system(.title, design: .rounded).bold())
                    .foregroundColor(EazyColor.headline)
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
                    .foregroundColor(EazyColor.highlight)
                Text("12:00")
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
            .padding(.trailing, 16)
            VStack(alignment: .trailing) {
                Text("1000 USDC")
                    .foregroundColor(EazyColor.title)
                Text("$1000")
                    .foregroundColor(EazyColor.text)
            }
        }
        .padding(.bottom, 16)
        .padding(.horizontal, 8)
    }
}
