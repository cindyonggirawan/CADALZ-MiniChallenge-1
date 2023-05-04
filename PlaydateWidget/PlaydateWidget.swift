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
        var policy: TimelineReloadPolicy = .atEnd
        
        var dayMemories: [Memory] = []
        var nightMemories: [Memory] = []
        
        do {
            let memories = try getMemoriesData()
            
            print(memories)
            
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
            
            print("dayMemories \(dayMemories)")
            print("nightMemories \(nightMemories)")
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
                print("randoming: \(randMemory)")
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
//            policy = .after(Calendar.current.date(bySettingHour: 22, minute: 58, second: 59, of: Date())!)
            policy = .after(Calendar.current.date(bySettingHour: 5, minute: 59, second: 59, of: Calendar.current.date(byAdding: .day, value: 1, to: Date())!)!)
            break
        default:
            policy = .after(Calendar.current.date(bySettingHour: 5, minute: 59, second: 59, of: Date())!)
            break
        }
        
        print("policy \(policy)")
        
//        var entry = PlaydateTimelineEntry(date: Date(), image: UIImage(named: "dummyPhoto")!)
        //        entries.append(entry)
        
        if randMemory != nil {
            let entry = PlaydateTimelineEntry(date: (randMemory?.date!)!, image: (randMemory?.photo!)!)
            entries.append(entry)
            print("entries \(entries)")
        }
        
        //TODO: Policy nya udah bener tapi data yang diambil setiap reload sama
        let timeline = Timeline(entries: entries, policy: policy )
        completion(timeline)
    }
    
    private func getMemoriesData() throws -> [Memory]{
        print("in \(memoryViewModel.memories)")
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
    let dateFormater = DateFormatter()
//    dateFormater.dateFormat = "d MMMM yyyy"

    var body: some View {
        ZStack(alignment: .bottomLeading){
            //TODO: TAMPILAN DATE MASIH BEDA DARI FIGMA
            let test = true
            if test {
//                Image(uiImage: entry.image)
                Rectangle()
                    .frame(width: .infinity, height: .infinity)
                    .foregroundColor(.primaryDarkBlue)
                    .opacity(0.25)
                    .background(
                        Image("dummyPhoto")
                            .resizable()
                            .scaledToFill()
                    )
                Text(entry.date.formatted())
//               TODO: sementara pakai yang atas untuk testing Text(entry.date.formatted(.dateTime.day().month(.wide).year()))
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
