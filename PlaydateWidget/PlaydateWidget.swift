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
        let policy: TimelineReloadPolicy = .atEnd

        do {
            
            let memories = try getMemoriesData()
            
            print(memories)
            
            var dayMemories: [Memory] = []
            var nightMemories: [Memory] = []

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
            
//            print(dayMemories)
//            print(nightMemories)
            
            //            let dayMemory = dayMemories.randomElement()
            //            let dayEntry = PlaydateTimelineEntry(date: (dayMemory?.date)!, image: UIImage(named: "dummyPhoto")!)
            //            entries.append(dayEntry)
            //
            //
            //            let nightMemory = nightMemories.randomElement()
            //            let nightEntry = PlaydateTimelineEntry(date: (nightMemory?.date)!, image: UIImage(named: "dummyPhoto2")!)
            //            entries.append(nightEntry)
            
        }catch {
            print(error)
        }
        
        
        
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let entry = PlaydateTimelineEntry(date: Date(), image: UIImage(named: "dummyPhoto")!)
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: policy )
        completion(timeline)
    }
    
    private func getMemoriesData() throws -> [Memory]{
        print("in \(memoryViewModel.memories)")
        return memoryViewModel.memories
        
        
//        let context = memoryViewModel.manager.context
//
//        let req = Memory.fetchRequest()
//        let result = try context.fetch(req)
//
//        print("result \(result)")
//        return result
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
            //TODO: TAMPILAN DATE MASIH BEDA DARI FIGMA
            let test = true
            if test {
                Image(uiImage: entry.image)
                    .resizable()
                    .scaledToFill()
                Rectangle()
                    .frame(width: .infinity, height: .infinity)
                    .foregroundColor(.primaryDarkBlue)
                    .opacity(0.25)
                Text("13 APRIL 2023")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .fontWidth(.condensed)
                    .fontWeight(.semibold)
                    .padding()
            }else {
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
                        .foregroundColor(.primaryDarkBlue)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
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
