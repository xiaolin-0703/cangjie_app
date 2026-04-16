package ohos_app_cangjie_entry.pages

internal import ohos.base.LengthProp
import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.router.*
import ohos_app_cangjie_entry.service.AuthService

@Entry
@Component
class LoginPage {
    @State var email: String = ""
    @State var code: String = ""
    @State var step: String = "email" // "email" -> "code" -> "jump"
    @State var errorMsg: String = ""
    @State var sending: Bool = false
    @State var verifying: Bool = false

    // 🌟 核心：记录后端告诉我们要去哪个页面
    @State var targetPage: String = ""

    // 获取发送按钮文案
    func getSendButtonText(): String {
        if (this.sending) {
            return "发送中..."
        }
        return "发送验证码"
    }

    // 获取验证按钮文案
    func getVerifyButtonText(): String {
        if (this.verifying) {
            return "验证中..."
        }
        return "登录 / 注册"
    }

    // 获取跳转按钮文案
    func getJumpButtonText(): String {
        if (this.targetPage == "HomePage") {
            return "进入主页"
        }
        return "去完善资料"
    }

    func build() {
        Column {
            Text("学生兴趣圈子")
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
                .margin(bottom: 12)

            if (this.step == "email") {
                // ==================== 第一步：输入邮箱 ====================
                TextInput(placeholder: "输入校园邮箱")
                    .width(80.percent)
                    .margin(bottom: 16)
                    .onChange({ v: String =>
                        this.email = v
                    })

                Button(this.getSendButtonText())
                    .width(80.percent)
                    .enabled(!this.sending)
                    .onClick({ =>
                        if (this.email == "") {
                            this.errorMsg = "请输入邮箱"
                            return
                        }
                        this.sending = true
                        AuthService.sendCode(
                            this.email,
                            { _: String =>
                                this.step = "code"
                                this.sending = false
                            },
                            { msg: String =>
                                this.errorMsg = msg
                                this.sending = false
                            }
                        )
                    })

            } else if (this.step == "jump") {
                // ==================== 第三步：智能中转站 ====================
                Text("验证成功！")
                    .fontSize(20)
                    .fontColor(0xFF00AA00)
                    .margin(bottom: 20)

                Button(this.getJumpButtonText())
                    .width(80.percent)
                    .onClick({ =>
                        try {
                            // 🌟 这里是 UI 主线程，直接跳转
                            Router.push(url: this.targetPage)
                        } catch (e: Exception) {
                            this.errorMsg = "跳转失败，请确保 main_pages.json 注册了 " + this.targetPage
                        }
                    })

            } else {
                // ==================== 第二步：验证并获取目的地 ====================
                Text("验证码已发至 ${this.email}")
                    .fontSize(14)
                    .margin(bottom: 16)

                TextInput(placeholder: "输入验证码")
                    .width(80.percent)
                    .margin(bottom: 16)
                    .onChange({ v: String =>
                        this.code = v
                    })

                Button(this.getVerifyButtonText())
                    .width(80.percent)
                    .enabled(!this.verifying)
                    .onClick({ =>
                        if (this.code == "") {
                            this.errorMsg = "请输入验证码"
                            return
                        }
                        this.verifying = true
                        this.errorMsg = ""

                        AuthService.verify(
                            this.email,
                            this.code,
                            { nextPage: String =>
                                // 🌟 核心逻辑：后端会返回 "HomePage" 或 "ProfileSetupPage"
                                if ( nextPage == "HomePage") {
                                    this.targetPage = "HomePage"
                                } else {
                                    this.targetPage = "ProfileSetupPage"
                                }
                                this.step = "jump"
                                this.verifying = false
                            },
                            { msg: String =>
                                this.errorMsg = msg
                                this.verifying = false
                            }
                        )
                    })
            }

            if (this.errorMsg != "") {
                Text(this.errorMsg)
                    .fontColor(0xFFFF0000)
                    .margin(top: 16)
            }
        }
        .width(100.percent)
        .height(100.percent)
        .justifyContent(FlexAlign.Center)
    }
}