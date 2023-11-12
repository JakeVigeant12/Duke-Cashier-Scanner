//
//  Departments.swift
//  eDepositBag
//
//  Created by Jake Vigeant on 11/5/23.
//

import Foundation
enum Department : String, CaseIterable{
    static var allCases: [Department] {return [.Dining, .SchoolOfNursing, .Parking, .Other]}
    
    case Dining
    case SchoolOfNursing = "School Of Nursing"
    case DukeStores
    case DukeCard
    case Parking
    case Other
}


enum DiningOption : String, CaseIterable{
    static var allCases: [DiningOption] {
        return [
            .BellaUnion,
            .BeyuBlue,
            .BseisuCoffeeBar,
            .CafeAtDukeLaw,
            .ChefsKitchen,
            .Commons,
            .DevilsKrafthouse,
            .DivinityCafe,
            .DolceVita,
            .Farmstead,
            .FreemanCenter,
            .GingerAndSoy,
            .Gyotaku,
            .IlForno,
            .JBS,
            .Loop,
            .MarketplaceALaCarte,
            .MarketplaceBoardAUCE,
            .McDonalds,
            .NasherCafe,
            .PandaExpress,
            .Panera,
            .Perk,
            .PitchforkProvisions,
            .Quenchers,
            .RedMango,
            .SanfordDeli,
            .Sazon,
            .Skillet,
            .Sprout,
            .Tandor,
            .TerraceCafe,
            .TheCafe,
            .ThriveKitchenAndCatering,
            .TrinityCafe,
            .Twinnies
        ]
    }
    
    case BellaUnion = "Bella Union"
    case BeyuBlue = "Beyu Blue"
    case BseisuCoffeeBar = "Bseisu Coffee Bar"
    case CafeAtDukeLaw = "Cafe at Duke Law"
    case ChefsKitchen = "Chefs Kitchen"
    case Commons = "Commons"
    case DevilsKrafthouse = "Devils Krafthouse"
    case DivinityCafe = "Divinity Cafe"
    case DolceVita = "Dolce Vita"
    case Farmstead = "Farmstead"
    case FreemanCenter = "Freeman Center"
    case GingerAndSoy = "Ginger And Soy"
    case Gyotaku = "Gyotaku"
    case IlForno = "Il Forno"
    case JBS = "JBS"
    case Loop = "Loop"
    case MarketplaceALaCarte = "Marketplace A La Carte"
    case MarketplaceBoardAUCE = "Marketplace Board AUCE"
    case McDonalds = "McDonald's"
    case NasherCafe = "Nasher Cafe"
    case PandaExpress = "Panda Express"
    case Panera = "Panera"
    case Perk = "Perk"
    case PitchforkProvisions = "Pitchfork Provisions"
    case Quenchers = "Quenchers"
    case RedMango = "Red Mango"
    case SanfordDeli = "Sanford Deli"
    case Sazon = "Sazon"
    case Skillet = "Skillet"
    case Sprout = "Sprout"
    case Tandor = "Tandor"
    case TerraceCafe = "Terrace Cafe"
    case TheCafe = "The Cafe"
    case ThriveKitchenAndCatering = "Thrive Kitchen And Catering"
    case TrinityCafe = "Trinity Cafe"
    case Twinnies = "Twinnies"
}

enum SchoolOfNursingOption : String, CaseIterable{
    case SoNCafe = "School of Nursing Cafe"
    case Other
}

enum DukeStoresOption : String, CaseIterable{
    case DivinityStore = "Divinity Store"
        case PG1 = "PG1"
        case MedicalOffice = "Medical Office"
        case PG2 = "PG2"
        case DukeChildrensHospital = "Duke Children's Hospital"
        case PG3 = "PG3"
        case DukeSouthClinics = "Duke South Clinics"
        case PG4 = "PG4"
        case DukeMedicalPavilion = "Duke Medical Pavilion"
        case PG5 = "PG5"
        case DukeNorthHospital = "Duke North Hospital"
        case PG7 = "PG7"
        case EastStore = "East Store"
        case GothicBookstore = "Gothic Bookstore"
        case LobbyShop = "Lobby Shop"
        case eStoreFormerlyMailOrder = "eStore (Formerly Mail Order)"
        case MerchandiseMailOrderConcessions = "Merchandise Mail Order Concessions"
        case MedicalStore = "Medical Store"
        case NasherStore = "Nasher Store"
        case OfficeProducts = "Office Products"
        case TeamStore = "Team Store"
        case TechnologyCenter = "Technology Center"
        case TerraceShop = "Terrace Shop"
        case TextbookStore = "Textbook Store"
        case UniversityStore = "University Store"
        case Warehouse = "Warehouse"

}

enum ParkingOption : String, CaseIterable{
    case ParkingOffice = "Parking Office"
}

enum DukeCardOption : String, CaseIterable{
    case CampusOffice = "Campus Office"
    case MedicalOffice = "Medical Office"
    case TheLink = "The Link"
}
