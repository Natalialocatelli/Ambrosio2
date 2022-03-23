import Foundation
import EventKit

print("Oi, aqui é o seu bloco de notas inteligente, meu nome é Ambrósio └(∵)┘ ")

print("Qual o seu nome?")

let name = readLine()!

print("Prazer em conhecer você \(name). O que posso anotar para lhe ajudar?🧐")

print("Aqui vai um exemplo de como você  pode inserir informações para eu lembrar para você depois🤯")

print("""

💬Titulo: Apresentação Ambrosio
📝Descrição: Apresentação no Apple Developer Academy
📆Data e Horário: 28/03/22 08:30

""")

print("Agora insira o que você deseja anotar")

print("💬", terminator: "")
let title = readLine()!

print("📝", terminator: "")
let description = readLine()!

print("📆", terminator:"")
let dateString = readLine()!

let dateFormatter = DateFormatter()

dateFormatter.dateFormat = "dd/MM/yy HH:mm"

guard let eventDate = dateFormatter.date(from: dateString) else {
  fatalError("A ENTRADA NÃO É UMA DATA VÁLIDA")
}

print("Anotado!😉")

//-----------------------------------------------


let eventStore = EKEventStore()

eventStore.requestAccess(to: .event) { (granted, error) in
    if granted {
        
        guard let calendar = eventStore.defaultCalendarForNewEvents else { exit(0)}
        let event = EKEvent(eventStore: eventStore)

        event.title = title
        event.notes = description
        event.startDate = eventDate
//        event.isAllDay = true
        event.endDate = event.startDate

        event.calendar = calendar

        do {
            try eventStore.save(event, span: .thisEvent, commit: true)
            print("DEU CERTO")
        } catch {
            print(error)
        }
    } else {
        print("NÃO AUTORIZADO")
    }
}

RunLoop.main.run()


