//
//  PlaydateWidget.swift
//  PlaydateWidget
//
//  Created by Alfine on 02/05/23.
//

import WidgetKit
import SwiftUI

struct PlaydateTimelineProvider: TimelineProvider {
    @StateObject var memoryViewModel = MemoryViewModel()
    
    func placeholder(in context: Context) -> PlaydateTimelineEntry {
        PlaydateTimelineEntry(date: Date(), image: UIImage(named: "dummyPhoto")!)
    }

    func getSnapshot(in context: Context, completion: @escaping (PlaydateTimelineEntry) -> ()) {
        let entry = PlaydateTimelineEntry(date: Date(), image: UIImage(named: "dummyPhoto")!)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [PlaydateTimelineEntry] = []
        var policy: TimelineReloadPolicy = .atEnd
        
        var dayMemories: [Memory] = []
        var nightMemories: [Memory] = []
        
        do {
            let memories = try getMemoriesData()
            for memory in memories {
                if memory.status != "ongoing"{
                    
                    let hour = Calendar.current.component(.hour, from: memory.date!)
                    
                    switch(hour){
                    case 0..<6:
                        nightMemories.append(memory)
                        break
                    case 6..<18:
                        dayMemories.append(memory)
                        break
                    case 18..<24:
                        nightMemories.append(memory)
                        break
                    default:
                        break
                    }
                }
            }
        }catch {
            print(error)
        }
        
        var randMemory: Memory? = nil
        
        if dayMemories.count == 0 && nightMemories.count == 0 {
            //nothing happen
        } else if dayMemories.count == 0{
            randMemory = nightMemories.randomElement()!
        } else if nightMemories.count == 0{
            randMemory = dayMemories.randomElement()!
        } else {
            let currentHour = Calendar.current.component(.hour, from: Date())
            switch(currentHour){
            case 0..<6:
                randMemory = nightMemories.randomElement()!
                break
            case 6..<18:
                randMemory = dayMemories.randomElement()!
                break
            case 18..<24:
                randMemory = nightMemories.randomElement()!
                break
            default:
                randMemory = nightMemories.randomElement()!
                break
            }
        }
        
        let currentHour = Calendar.current.component(.hour, from: Date())
        switch(currentHour){
        case 0..<6:
            policy = .after(Calendar.current.date(bySettingHour: 5, minute: 59, second: 59, of: Date())!)
            break
        case 6..<18:
            policy = .after(Calendar.current.date(bySettingHour: 17, minute: 59, second: 59, of: Date())!)
            break
        case 18..<24:
            policy = .after(Calendar.current.date(bySettingHour: 5, minute: 59, second: 59, of: Calendar.current.date(byAdding: .day, value: 1, to: Date())!)!)
            break
        default:
            policy = .after(Calendar.current.date(bySettingHour: 5, minute: 59, second: 59, of: Date())!)
            break
        }
        
        print(policy)
        
        if randMemory != nil {
            let entry = PlaydateTimelineEntry(date: (randMemory?.date!)!, image: (randMemory?.photo!)!)
            entries.append(entry)
        }else {
            let entry = PlaydateTimelineEntry(date: Date(), image: UIImage(named: "dummyPhoto")!)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: policy )
        completion(timeline)
    }
    
    private func getMemoriesData() throws -> [Memory]{
        return memoryViewModel.memories
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
        ZStack(alignment: .bottomLeading){
            if memoryViewModel.memories.count > 0 {
                if memoryViewModel.memories.count == 1 && memoryViewModel.memories[memoryViewModel.memories.count-1].status == "ongoing"{
                    widgetEmptyState()
                }else {
                    Rectangle()
                        .frame(width: .infinity, height: .infinity)
                        .foregroundColor(.primaryDarkBlue)
                        .opacity(0.25)
                        .background(
                            Image(uiImage: entry.image.resized(toWidth: 800)!)
                                .resizable()
                                .scaledToFill()
                        )
                    Text(entry.date.formatted(.dateTime.day().month(.wide).year()))
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .fontWidth(.condensed)
                        .fontWeight(.semibold)
                        .padding()
                }
            } else {
                widgetEmptyState()
            }
        }
    }
}

struct widgetEmptyState: View {
    var body: some View {
        VStack(spacing: 2){
            Image(systemName: "photo.on.rectangle.angled")
                .font(.system(size: 40))
                .foregroundColor(.primaryPurple)
                .padding(.bottom, 8)
            
            Text("Oops, no memories!")
//                        .font(.custom("Poppins-SemiBold", size: 11))
                .font(.system(size: 12))
                .fontWeight(.semibold)
                .foregroundColor(.primaryDarkBlue)
            Text("Let's do a challenge")
                .font(.custom("Poppins-Regular", size: 11))
//                        .font(.system(size: 11))
                .foregroundColor(.primaryDarkBlue)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear(perform: {
            print("yes")
        })
        .background(
            Image("doodle-food")
                .resizable()
                .scaledToFill()
                .opacity(0.12)
                .background(.white)
                .frame(width: 250, height: 250)
            )
            .clipped()
            .contentShape(Rectangle())
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
        .supportedFamilies([.systemSmall])
    }
}

struct PlaydateWidget_Previews: PreviewProvider {
    static var previews: some View {
        PlaydateWidgetEntryView(entry: PlaydateTimelineEntry(date: Date(), image: UIImage(named: "dummyPhoto")!))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}


extension UIImage {
  func resized(toWidth width: CGFloat, isOpaque: Bool = true) -> UIImage? {
    let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
    let format = imageRendererFormat
    format.opaque = isOpaque
    return UIGraphicsImageRenderer(size: canvas, format: format).image {
      _ in draw(in: CGRect(origin: .zero, size: canvas))
    }
  }
}
