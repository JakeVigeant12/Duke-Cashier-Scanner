//
//  Departments.swift
//  eDepositBag
//
//  Created by Jake Vigeant on 11/5/23.
//

import Foundation
enum Location {
    case Dining
    case SchoolOfNursing
    case DukeStores
    case DukeCard
    case Parking
    case Other(String)
}


enum LocationSelection {
    case Dining(DiningOption)
    case SchoolOfNursing(SchoolOfNursingOption)
    case DukeStores(DukeStoresOption)
    case Parking(ParkingOption)
    case DukeCard(DukeCardOption)
}

enum DiningOption {
    case BellaUnion
    case BeyuBlue
    case BseisuCoffeeBar
    case CafeAtDukeLaw
    case ChefsKitchen
    case Commons
    case DevilsKrafthouse
    case DivinityCafe
    case DolceVita
    case Farmstead
    case FreemanCenter
    case GingerAndSoy
    case Gyotaku
    case IlForno
    case JBS
    case Loop
    case MarketplaceALaCarte
    case MarketplaceBoardAUCE
    case McDonalds
    case NasherCafe
    case PandaExpress
    case Panera
    case Perk
    case PitchforkProvisions
    case Quenchers
    case RedMango
    case SanfordDeli
    case Sazon
    case Skillet
    case Sprout
    case Tandor
    case TerraceCafe
    case TheCafe
    case ThriveKitchenAndCatering
    case TrinityCafe
    case Twinnies
    case Other(String)
}

enum SchoolOfNursingOption {
    case SoNCafe
    case Other(String)
}

enum DukeStoresOption {
    case DivinityStore
    case PG1
    case MedicalOffice
    case PG2
    case DukeChildrensHospital
    case PG3
    case DukeSouthClinics
    case PG4
    case DukeMedicalPavilion
    case PG5
    case DukeNorthHospital
    case PG7
    case EastStore
    case GothicBookstore
    case LobbyShop
    case eStoreFormerlyMailOrder
    case MerchandiseMailOrderConcessions
    case MedicalStore
    case NasherStore
    case OfficeProducts
    case TeamStore
    case TechnologyCenter
    case TerraceShop
    case TextbookStore
    case UniversityStore
    case Warehouse
    case Other(String)

}

enum ParkingOption {
    case ParkingOffice
    case Other(String)
}

enum DukeCardOption {
    case CampusOffice
    case MedicalOffice
    case TheLink
    case Other(String)
}
