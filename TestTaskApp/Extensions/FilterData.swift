

import Foundation


extension DetailsCollectionViewController {

    func filterData<T: FilterProtocol>(array: [T], id: Int) -> [T] {
        var filteredArray: [T] = []
        for element in array {
            if element.idForFilter == id {
                filteredArray.append(element)
            }
        }
        return filteredArray
    }
}
