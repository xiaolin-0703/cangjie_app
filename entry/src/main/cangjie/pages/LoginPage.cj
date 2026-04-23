package ohos_app_cangjie_entry.pages

internal import ohos.base.LengthProp
import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.router.*
import ohos_app_cangjie_entry.service.AuthService

@Component
public class LoginPage {
    @Link var isShow: Bool

    @State var email: String = ""
    @State var code: String = ""
    @State var errorMsg: String = ""
    @State var sending: Bool = false
    @State var verifying: Bool = false

    func build() {
        Column {

            // 【问题 3 解决】：已将 Text("学生兴趣圈子") 彻底删除

            // 补充一点点顶部间距，让 UI 留白更舒服
            Text("欢迎来到B-Link !")
                .fontSize(24)
                .fontColor(0xFF0055FF)

            Column().height(30)

            // 输入邮箱
            TextInput(placeholder: "输入校园邮箱")
                .width(85.percent)
                .height(48)
                .margin(bottom: 16)
                .onChange({ v: String => this.email = v })

            // 输入验证码 & 获取验证码
            Row {
                TextInput(placeholder: "输入验证码")
                    .width(55.percent)
                    .height(48)
                    .onChange({ v: String => this.code = v })

                Blank()

                Button(if (this.sending) { "发送中..." } else { "获取验证码" })
                    .width(40.percent)
                    .height(48)
                    .backgroundColor(0xFFF0F5FF)
                    .fontColor(0xFF0055FF)
                    .enabled(!this.sending)
                    .onClick({ event: ClickEvent =>
                        if (this.email == "") {
                            this.errorMsg = "请先输入校园邮箱"
                            return
                        }
                        this.sending = true
                        AuthService.sendCode(this.email, { _: String => this.sending = false }, { msg: String => this.errorMsg = msg; this.sending = false })
                    })
            }
            .width(85.percent)
            .margin(bottom: 32)

            // 登录 / 注册按钮
            Button(if (this.verifying) { "验证中..." } else { "登录 / 注册" })
                .width(85.percent)
                .height(48)
                .backgroundColor(0xFF0055FF)
                .fontColor(0xFFFFFFFF)
                .enabled(!this.verifying)
                .onClick({ event: ClickEvent =>
                    if (this.email == "" || this.code == "") {
                        this.errorMsg = "请完整填写邮箱和验证码"
                        return
                    }
                    this.verifying = true
                    AuthService.verify(this.email, this.code, { nextPage: String =>
                        this.verifying = false
                        this.isShow = false // 验证成功，自动收起弹窗
                        let target = if (nextPage == "home") { "HomePage" } else { "ProfileSetupPage" }
                        try { Router.push(url: target) } catch (e: Exception) { this.errorMsg = "跳转失败" }
                    }, { msg: String => this.errorMsg = msg; this.verifying = false })
                })

            if (this.errorMsg != "") {
                Text(this.errorMsg).fontColor(0xFFFF0000).margin(top: 16)
            }
        }
        .width(100.percent)
        .height(100.percent)
        .backgroundColor(0xFFFFFFFF)
        .borderRadius(24)
    }
}