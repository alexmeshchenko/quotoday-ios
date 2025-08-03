//
//  QuoteTheme.swift
//  Quotoday
//
//  Created by Aleksandr Meshchenko on 03.08.25.
//

enum QuoteTheme: String, CaseIterable, Identifiable {
    case life
    case inspiration
    case philosophy
    case business
    case art
    case people
    case fun
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .life: return "Life & Emotions"
        case .inspiration: return "Inspiration"
        case .philosophy: return "Philosophy"
        case .business: return "Business & Work"
        case .art: return "Art & Creativity"
        case .people: return "People & Family"
        case .fun: return "Fun & Random"
        }
    }
    
    var localizedTitle: String {
        switch self {
        case .life: return "Жизнь и эмоции"
        case .inspiration: return "Вдохновение"
        case .philosophy: return "Философия"
        case .business: return "Бизнес и работа"
        case .art: return "Творчество и искусство"
        case .people: return "Люди и семья"
        case .fun: return "Юмор и случайное"
        }
    }
    
    var emoji: String {
        switch self {
        case .life: return "🌱"
        case .inspiration: return "✨"
        case .philosophy: return "🧠"
        case .business: return "💼"
        case .art: return "🎨"
        case .people: return "👨‍👩‍👧"
        case .fun: return "🎉"
        }
    }
    
    var categories: Set<APICategory> {
        switch self {
        case .life:
            return [.life, .love, .happiness, .friendship, .family, .hope, .humor, .attitude, .experience, .failure, .forgiveness, .dreams]
        case .inspiration:
            return [.inspirational, .success, .courage, .leadership, .faith, .learning, .future, .imagination]
        case .philosophy:
            return [.god, .freedom, .intelligence, .knowledge, .jealousy, .fear, .alone, .death, .change, .age, .good]
        case .business:
            return [.business, .money, .education, .fitness, .graduation, .morning, .legal, .government]
        case .art:
            return [.art, .beauty, .design, .architecture, .computers, .cool, .movies]
        case .people:
            return [.dad, .mom, .men, .marriage, .dating, .medical, .health, .environmental, .equality]
        case .fun:
            return [.funny, .amazing, .food, .car, .history, .great, .best, .famous, .birthday]
        }
    }
}
