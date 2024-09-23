
import SwiftUI

struct MainTabView: View {
    @State var headers: [Header] = []
    @State private var stories: [RSSItem] = []
    @State private var storiesByCategory: [String: [RSSItem]] = [:]
    @State private var categoryToSectionMap: [String: String] = [:]
    @State private var isLoading: Bool = false
    @State private var hasAppeared: Bool = false

    let storyURL = URL(string: Bundle.main.infoDictionary!["storyURL"] as! String)

    func getRSSItems() async {
        guard let url = storyURL else { return }
        let parser = RSSParser()
        parser.parse(from: url) { items in
            self.stories = items
            self.storiesByCategory = organizeStoriesByCategory(stories: items, headers: self.headers, categoryToSectionMap: categoryToSectionMap)
        }
    }

    var body: some View {
        NavigationStack {
            if isLoading {
                ProgressView("正在載入")
            } else {
                TabView {
                    ForEach(headers) { header in
                        if let stories = storiesByCategory[header.name] {
                            HomePageView(header: header, stories: stories)
                        }
                    }
                }
                .navigationTitle("鏡週刊")
            }
        }
        .task {
            print("isLoading")
            isLoading = true
            do {
                let (fetchedHeaders, map) = try await fetchHeaders()
                headers = Array(fetchedHeaders.dropFirst())
                categoryToSectionMap = map
                await getRSSItems()
                print("getRSSItems end")
            } catch {}
            isLoading = false
            print("isLoading end")
        }
    }
}

#Preview {
    MainTabView()
}
