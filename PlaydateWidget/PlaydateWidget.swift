//
//  PlaydateWidget.swift
//  PlaydateWidget
//
//  Created by Alfine on 02/05/23.
//

import WidgetKit
import SwiftUI
//import Intents

struct PlaydateTimelineProvider: TimelineProvider {
    func placeholder(in context: Context) -> PlaydateTimelineEntry {
        PlaydateTimelineEntry(date: Date(), image: UIImage(named: "dummyPhoto")!)
    }

    func getSnapshot(in context: Context, completion: @escaping (PlaydateTimelineEntry) -> ()) {
        let entry = PlaydateTimelineEntry(date: Date(), image: UIImage(named: "dummyPhoto")!)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [PlaydateTimelineEntry] = []
        let policy: TimelineReloadPolicy = .atEnd

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let entry = PlaydateTimelineEntry(date: Date(), image: UIImage(named: "dummyPhoto")!)
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: policy )
        completion(timeline)
    }
}

struct PlaydateTimelineEntry: TimelineEntry {
    let date: Date
    let image: UIImage
}

struct PlaydateWidgetEntryView : View {
    var entry: PlaydateTimelineProvider.Entry
    @StateObject var memoryViewModel = MemoryViewModel()

    var body: some View {
        Image(uiImage: entry.image)
            .resizable()
            .scaledToFill()
//        if let challenge = memoryViewModel.memories[memoryViewModel.memories.count-1].challenge {
//            Text(challenge.name ?? "no")
//        }
    }
}

struct PlaydateWidget: Widget {
    let kind: String = "PlaydateWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: PlaydateTimelineProvider()) { entry in
            PlaydateWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Your Memory")
        .description("Based on current time")
    }
}

struct PlaydateWidget_Previews: PreviewProvider {
    static var previews: some View {
        PlaydateWidgetEntryView(entry: PlaydateTimelineEntry(date: Date(), image: UIImage(named: "dummyPhoto")!))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}