//
//  LionView.swift
//  We Are
//
//  Created by jjh9 on 9/1/20.
//  Copyright © 2020 jjh9. All rights reserved.
//

import SwiftUI

struct LionView: View {
    @EnvironmentObject  var cheerViewModel : CheerViewModel
    
    var body: some View {
        VStack {
         
            Image(cheerViewModel.mascotImageName)  
                .resizable()
                .aspectRatio(contentMode: ContentMode.fit)
            
        }
    }
}


struct LionView_Previews: PreviewProvider {
    static var previews: some View {
        LionView().environmentObject(CheerViewModel())
    }
}
