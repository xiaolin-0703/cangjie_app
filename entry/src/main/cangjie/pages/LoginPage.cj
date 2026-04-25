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
    @State var successMsg: String = ""
    @State var sending: Bool = false
    @State var verifying: Bool = false
    @State var loginReady: Bool = false
    @State var nextPageTarget: String = ""

    func resetLoginResult() {
        this.loginReady = false
        this.nextPageTarget = ""
        this.successMsg = ""
    }

    func getLoginButtonText(): String {
        if (this.loginReady) {
            if (this.nextPageTarget == "HomePage") {
                return "进入主页"
            }
            return "完善资料"
        }
        if (this.verifying) {
            return "验证中..."
        }
        return "登录 / 注册"
    }

    func goNextPage() {
        if (this.nextPageTarget == "") {
            this.errorMsg = "跳转页面缺失"
            return
        }

        try {
            Router.push(url: this.nextPageTarget)
            this.isShow = false
        } catch (e: Exception) {
            this.errorMsg = "跳转失败"
        }
    }

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
                .onChange({ v: String =>
                    this.email = v
                    this.resetLoginResult()
                })

            // 输入验证码 & 获取验证码
            Row {
                TextInput(placeholder: "输入验证码")
                    .width(55.percent)
                    .height(48)
                    .onChange({ v: String =>
                        this.code = v
                        this.resetLoginResult()
                    })

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
                        this.errorMsg = ""
                        this.resetLoginResult()
                        this.sending = true
                        AuthService.sendCode(
                            this.email,
                            { _: String =>
                                this.successMsg = "验证码已发送，请查看邮箱"
                                this.sending = false
                            },
                            { msg: String =>
                                this.errorMsg = msg
                                this.sending = false
                            }
                        )
                    })
            }
            .width(85.percent)
            .margin(bottom: 32)

            // 登录 / 注册按钮
            Button(this.getLoginButtonText())
                .width(85.percent)
                .height(48)
                .backgroundColor(0xFF0055FF)
                .fontColor(0xFFFFFFFF)
                .enabled(!this.verifying)
                .onClick({ event: ClickEvent =>
                    if (this.loginReady) {
                        this.goNextPage()
                        return
                    }

                    if (this.email == "" || this.code == "") {
                        this.errorMsg = "请完整填写邮箱和验证码"
                        return
                    }
                    this.verifying = true
                    this.errorMsg = ""
                    this.successMsg = ""
                    AuthService.verify(this.email, this.code, { nextPage: String =>
                        this.verifying = false
                        this.nextPageTarget = if (nextPage == "home") { "HomePage" } else { "ProfileSetupPage" }
                        this.loginReady = true
                        this.successMsg = "验证成功，请继续"
                    }, { msg: String => this.errorMsg = msg; this.verifying = false })
                })

            if (this.successMsg != "") {
                Text(this.successMsg).fontColor(0xFF2E9B4B).margin(top: 16)
            }

            if (this.errorMsg != "") {
                Text(this.errorMsg).fontColor(0xFFE96B6B).margin(top: 16)
            }
        }
        .width(100.percent)
        .height(100.percent)
        .backgroundColor(0xFFFFFFFF)
        .borderRadius(24)
    }
}
