package ohos_app_cangjie_entry.pages

internal import ohos.base.LengthProp
import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.router.*
import ohos_app_cangjie_entry.common.ApiConfig

@Entry
@Component
class HomePage {
    func build() {
        Column {
            Text("聚了吗")
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
                .margin(bottom: 16)

            Text("主页面开发中")
                .fontSize(18)
                .margin(bottom: 12)

            Text("登录流程已经打通：老用户可直接进入这里，首次用户需先完善资料。")
                .width(85.percent)
                .fontSize(14)
                .fontColor(0xFF888888)
                .margin(bottom: 32)

            Button("退出登录")
                .width(70.percent)
                .onClick({ =>
                    ApiConfig.clearAccessToken()
                    Router.push(url: "LoginPage")
                })
        }
        .width(100.percent)
        .height(100.percent)
        .justifyContent(FlexAlign.Center)
    }
}
