//
//  RaceDetailModel.swift
//  Doityourself
//

import Foundation
import Apollo
import RealmSwift

struct RaceDetailViewModel {
    
    func getRaceData(raceId: String?, completionHandler: @escaping (Error?, GetRaceDataQuery.Data.GetRace?) -> Void ) {
        
        Network.shared.apollo.fetch(query: GetRaceDataQuery(raceId: raceId ?? ""), cachePolicy: .fetchIgnoringCacheCompletely) { result in
            
            switch result {
                
                case .success:
                    
                    do {
                        let response = try result.get().data
                        
                        let responseData = response?.getRace
                        
                        completionHandler(nil, responseData)
                        
                    } catch {
                        
                        completionHandler(error, nil)
                        
                    }
                    
                case .failure(let error):
                    
                    completionHandler(error, nil)
                    
            }
            
        }

    }
    
    func joinRace(raceId: String?, completionHandler: @escaping (Error?, UserJoinRaceMutation.Data.JoinRace?) -> Void ) {
        
        
        Network.shared.apollo.perform(mutation: UserJoinRaceMutation(raceId: raceId ?? "")) { result in
            switch result {
                
                case .success:
                    
                    do {
                        let response = try result.get().data
                        
                        let responseData = response?.joinRace
                        
                        completionHandler(nil, responseData)
                        
                    } catch {
                        
                        completionHandler(error, nil)
                        
                    }
                    
                case .failure(let error):
                    
                    completionHandler(error, nil)
                    
            }
            
        }
        
    }
    
    
    func addRaceCoCreator(raceId: String?, userId: String?, completionHandler: @escaping (Error?, AddCoCreatorForRaceMutation.Data.AddCoCreatorForRace?) -> Void ) {
        
        let addCoCreatorInput = AddCoCreatorInput(raceId: raceId, coCreatorId: userId)
        
        Network.shared.apollo.perform(mutation: AddCoCreatorForRaceMutation(AddCoCreatorInput: addCoCreatorInput)) { result in
            switch result {
                
                case .success:
                    
                    do {
                        let response = try result.get().data
                        
                        let responseData = response?.addCoCreatorForRace
                        
                        completionHandler(nil, responseData)
                        
                    } catch {
                        
                        completionHandler(error, nil)
                        
                    }
                    
                case .failure(let error):
                    
                    completionHandler(error, nil)
                    
            }
            
        }
        
    }
    
    func removeRacer(raceId: String?, userId: String?, completionHandler: @escaping (Error?, DeleteRaceUserQuery.Data.DeleteRaceUser?) -> Void ) {
        
        let deleteRaceUserInput = DeleteRaceUserInput(raceId: raceId, userId: userId)
        
        Network.shared.apollo.fetch(query: DeleteRaceUserQuery(DeleteRaceUserInput: deleteRaceUserInput), cachePolicy: .fetchIgnoringCacheCompletely) { result in
            
            switch result {
                
                case .success:
                    
                    do {
                        
                        let response = try result.get().data
                        
                        let responseData = response?.deleteRaceUser
                        
                        completionHandler(nil, responseData)
                        
                    } catch {
                        
                        completionHandler(error, nil)
                        
                    }
                    
                case .failure(let error):
                    
                    completionHandler(error, nil)
                    
            }
            
        }
        
    }
    
    func addRaceToCalender(raceId: String, completionHandler: @escaping (Error?, AddToCalendarForRaceMutation.Data.AddToCalendarForRace?) -> Void ) {
        
        Network.shared.apollo.perform(mutation: AddToCalendarForRaceMutation(raceId: raceId)) { result in
            switch result {
                
                case .success:
                    
                    do {
                        let response = try result.get().data
                        
                        let responseData = response?.addToCalendarForRace
                        
                        completionHandler(nil, responseData)
                        
                    } catch {
                        
                        completionHandler(error, nil)
                        
                    }
                    
                case .failure(let error):
                    
                    completionHandler(error, nil)
                    
            }
            
        }
        
    }
    
}
