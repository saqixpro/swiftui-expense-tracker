//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Saqib Afridi on 11/06/2023.
//

import SwiftUI

struct Title: View {
    @State var title: String;
    var body: some View {
        Text(title).font(.title).bold()
    }
}

struct Header: View {
    var body: some View {
        HStack {
            Title(title: "Home")
            Spacer()
            Button(action: {
                print("it works");
            }) {
                Image(systemName: "bell").resizable().frame(width: 25, height: 25).foregroundColor(.black)
            }
        }.padding(.top, 20)
    }
}

enum TransactionType {
    case monthly, weekly, daily
}

func parseTransactionType(tx: TransactionType) -> String {
    switch tx {
    case .daily:
        return "Daily"
    case .monthly:
        return "Monthly"
    default: return "Weekly"
    }
    
}

struct TransactionView: View {
    @State var title: String;
    @State var price: Int;
    @State var type: TransactionType;
    var __type:String;
    
    init(title: String, price: Int, type: TransactionType) {
        self.title = title
        self.price = price
        self.type = type
        self.__type = parseTransactionType(tx: type)
    }

    
    var body: some View {
        HStack {
            VStack {
                Text(title).font(.title3).bold().frame(maxWidth: .infinity, alignment: .leading)
                Text(__type).font(.body).foregroundColor(.gray).frame(maxWidth: .infinity, alignment: .leading)
            }.padding(.vertical, 10).padding(.horizontal, 10)
            Spacer()
            VStack {
                Text("$\(String(price))").font(.headline).font(.title).frame(maxWidth: .infinity, alignment: .trailing)
            }.padding(.vertical, 10).padding(.horizontal, 10)
        }.background(.white).cornerRadius(6).shadow(color: .gray, radius: 3)
    }
    
}

struct GraphItem : View {
    @State var height: Int;
    var body: some View {
        VStack {
            
        }.frame(width: 20, height: CGFloat(height)).background(.orange).padding(.bottom, 8).cornerRadius(8).padding(.bottom, -8)
    }
}

struct AnalyticsView: View {
    var body: some View {
        VStack(alignment: .leading, content: {
            HStack{
                Text("Analytics").foregroundColor(.white)
                Spacer()
                Button {
                    print("This Month Button")
                } label: {
                    Text("This Month").foregroundColor(.white)
                }

            }.padding(.horizontal, 30).padding(.vertical, 20)
            Spacer()
            HStack(alignment: .bottom, content: {
                Spacer()
                GraphItem(height: 80)
                Spacer()
                GraphItem(height: 57)
                Spacer()
                GraphItem(height: 44)
                Spacer()
                GraphItem(height: 83)
                Spacer()
            })
        }).frame(height: 200).background(Color.black).cornerRadius(15)
    }
}

struct Spending : View {
    @State var spending: Float;
    var body: some View {
        VStack{
            Text("This month Spend").foregroundColor(.gray).font(.custom("Helvetica", size: 16)).padding(.vertical, 2)
            Text("$\(String(spending))").font(.largeTitle).bold()
        }.padding(.vertical, 30)
    }
}

struct Transaction: Identifiable {
    var id = UUID();
    
    let title: String;
    let price: Int;
    let type: TransactionType;
}

struct ContentView: View {
    private var transactions = [
        Transaction(title: "Github", price: 12, type: TransactionType.weekly),
        Transaction(title: "Google", price: 14, type: TransactionType.weekly),
        Transaction(title: "Microsoft", price: 45, type: TransactionType.monthly),
        Transaction(title: "Netflix", price: 5, type: TransactionType.monthly),
        Transaction(title: "ChatGPT", price: 50, type: TransactionType.monthly),
        Transaction(title: "iCloud+", price: 5, type: TransactionType.daily),
        
    ]
    
    var body: some View {
        VStack {
           Header()
            Spending(spending: 1200)
            AnalyticsView()
            Spacer()
            List(transactions){
                TransactionView(title: $0.title, price: $0.price, type: $0.type)
            }.padding(.horizontal, -38).scrollIndicators(.hidden)
        }.padding(.horizontal, 30)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
