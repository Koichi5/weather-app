//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Koichi Kishimoto on 2023/11/18.
//

import SwiftUI

struct WeatherView: View {
    //  天気情報
//    @State var resultMessage = ""
//    //  気温
//    @State var tempMessage = ""
//    //  湿度
//    @State var humidityMessage = ""
//    //  天気情報を取得する場所
//    //  true: 東京 false: 大阪
//    @State var bLocationFlag = false
//    
//    let tokyoLat = 34.0778755
//    let tokyoLon = 134.5615651
    
    //  キー情報
    //    var openWeatherApiKey = KeyManager().getValue(key: "openWeatherApiKey")
    
    //  天気情報取得用クラス
    @ObservedObject var obj = WeatherViewModel()
    
    //  取得した天気情報を処理するよ
//    func GetData(data: Temperatures){
//        DispatchQueue.main.async {
//            self.resultMessage = ""
//            //  温度をセット(摂氏)
//            self.tempMessage = "\(data.main.temp)°C"
//            //  湿度をセット
//            self.humidityMessage = "\(data.main.humidity)%"
//            //  天気情報のメッセージをセット
//            data.weather.forEach{
//                item in
//                if( self.resultMessage.count == 0 )
//                {
//                    self.resultMessage = "\n" +  item.weatherDescription + "\n"
//                }
//                else{
//                    self.resultMessage = self.resultMessage +  item.weatherDescription + "\n"
//                }
//            }
//        }
//    }
    var body: some View {
        VStack{
            Button(action: {
//                //  APIの仕様(https://openweathermap.org/current)
//                var invokeURL = ""
//                //  東京の場合
//                if(self.bLocationFlag){
//                    //                   invokeURL = "https://api.openweathermap.org/data/2.5/weather?lat=\(tokyoLat)&lon=\(tokyoLon)&appid=\(self.openWeatherApiKey)&lang=ja&units=metric"
//                    invokeURL = "https://api.openweathermap.org/data/2.5/weather?q=Tokyo,JP&appid=\(self.openWeatherApiKey)&lang=ja&units=metric"
//                    print("url: \(invokeURL)")
//                }
//                //  大阪の場合
//                else{
//                    invokeURL = "https://api.openweathermap.org/data/2.5/weather?q=Tokyo,JP&appid=\(self.openWeatherApiKey)&lang=ja&units=metric"
//                    print("url: \(invokeURL)")
//                }
                //  天気情報を取得(APIコール)
//                obj.getWeather()
            }, label: {
                Text("Push")
            })
            
//            HStack{
//                //  天気情報を取得するロケーション設定用トグル
//                //  シンプルに見せる為にトグルにしてます。
//                //  今回はAPIをコールするところがメインです。
//                Toggle(isOn: $bLocationFlag) {
//                    Text(self.bLocationFlag ? "東京" : "大阪")
//                }
//                .padding()
//                Text("今日の天気は?")
//                    .padding()
//                    .border(Color.black)
//            }
//            HStack{
//                Text("天気 ")
//                    .padding()
//                Text("\(resultMessage)")
//                    .padding()
//            }
//            HStack{
//                Text("気温 ")
//                    .padding()
//                Text("\(tempMessage)")
//                    .padding()
//            }
//            HStack{
//                Text("湿度 ")
//                    .padding()
//                Text("\(humidityMessage)")
//                    .padding()
//            }
        }
    }
}


struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
