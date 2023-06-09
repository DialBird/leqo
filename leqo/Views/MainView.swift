//
//  MainView.swift
//  leqo
//
//  Created by 谷口敬亮 on 2023/05/31.
//

import SwiftUI

struct Friend: Identifiable {
  let id = UUID()
  let name: String
}

struct MainView: View {
  @State var friends = [Friend(name: "asf"), Friend(name: "fr"), Friend(name: "mo")]
  @State private var refreshDate: [Date] = []
  
  private func delete(indexSet: IndexSet) {
    indexSet.forEach { idx in
      friends.remove(at: idx)
    }
  }
  private func move(from source: IndexSet, to destination: Int) {
    friends.move(fromOffsets: source, toOffset: destination)
  }
  
  var body: some View {
    NavigationStack {
      VStack {
        List {
          ForEach(friends) { friend in
            Text(friend.name)
              .listRowSeparator(.hidden)
          }.onDelete(perform: delete)
            .onMove(perform: move)
        }
        .toolbar {
          EditButton()
        }
        .refreshable {
          DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            friends.append(Friend(name: "YO"))
            print("sadf")
          }
        }
        .navigationTitle("Oceans")
      }
    }
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}
