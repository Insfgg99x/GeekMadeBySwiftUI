# GeekMadeBySwiftUI

干货集中营SwiftUI版

```swift
var body: some View {
    NavigationView {
        List {
            PageView(vm.banners.map { KFImage(URL(string: $0)) })
                .scaledToFill()
                .frame(height: sw * 0.6)
                .clipped()
                .listRowInsets(EdgeInsets())
            ForEach((0..<vm.data.count), id : \.self) { index in
                Section(header:
                    VStack(alignment: .leading) {
                        Text(self.vm.data[index].category)
                        .font(.headline)
                        .bold()
                        .frame(height : 25)
                        .padding(.leading, 15)
                        .offset(x: 0, y: 5)
                        Divider()
                    }
                    .background(Color.white)
                ) {
                    ForEach(self.vm.data[index].feeds) { feed in
                        NavigationLink(destination: FeedDetail(feed: feed)) {
                            FeedView(feed: feed)
                        }
                        .padding(.trailing, -16)//hide accosryView(arrow)
                    }
                }
            }
            .listRowInsets(EdgeInsets())
        }
        .navigationBarTitle("Today", displayMode: .inline)
    }
```

```swift
var body: some View {
    NavigationView {
        VStack {
            Picker("type", selection: $vm.type) {
                ForEach(Feed.FeedType.allCases, id: \.self) {
                    Text($0.rawValue)
                        .tag($0)
                        .font(.system(size: 8))
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.leading, 10)
            .padding(.trailing, 10)
            .padding(.top, 10)
            if vm.type == .welfare {
                ImageContainer()
                    .padding(10)
                    .environmentObject(vm)
            } else {
                List(vm.feeds) { feed in
                    NavigationLink(destination: FeedDetail(feed: feed)) {
                        FeedView(feed: feed)
                    }
                }
                .listRowInsets(EdgeInsets())
            }
        }
        .navigationBarTitle("Category", displayMode: .inline)
    }
}
```

- Mac截图
![](/ScreenShots/Mac/1.png)

![](/ScreenShots/Mac/2.png)

![](/ScreenShots/Mac/3.png)

![](/ScreenShots/Mac/4.png)

- iPhone截图

![](/ScreenShots/iPhone/1.png)

![](/ScreenShots/iPhone/2.png)

![](/ScreenShots/iPhone/3.png)

![](/ScreenShots/iPhone/4.png)

![](/ScreenShots/iPhone/5.png)
