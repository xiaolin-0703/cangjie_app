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
    @State var step: String = "email" // 状态: "email" -> "code" -> "success"
    @State var errorMsg: String = ""
    @State var sending: Bool = false
    @State var verifying: Bool = false

    func getSendButtonText(): String {
        if (this.sending) {
            return "发送中..."
        }
        return "发送验证码"
    }

    func getVerifyButtonText(): String {
        if (this.verifying) {
            return "登录中..."
        }
        return "登录"
    }

    func build() {
        Column {
            Text("学生兴趣圈子")
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
                .margin(bottom: 12)

            Text("校园邮箱验证码登录")
                .fontSize(14)
                .fontColor(0xFF888888)
                .margin(bottom: 40)

            if (this.step == "email") {
                // ==================== 第一步：输入邮箱 ====================
                TextInput(placeholder: "输入校园邮箱，例如：name@buaa.edu.cn")
                    .width(80.percent)
                    .margin(bottom: 16)
                    .onChange({ value: String =>
                        this.email = value
                    })

                Button(this.getSendButtonText())
                    .width(80.percent)
                    .enabled(!this.sending)
                    .onClick({ =>
                        this.errorMsg = ""
                        if (this.email == "") {
                            this.errorMsg = "请输入校园邮箱"
                            return
                        }

                        this.sending = true

                        AuthService.sendCode(
                            this.email,
                            { normalizedEmail: String =>
                                this.email = normalizedEmail
                                this.code = ""
                                this.step = "code"
                                this.sending = false
                            },
                            { msg: String =>
                                this.errorMsg = msg
                                this.sending = false
                            }
                        )
                    })
            } else if (this.step == "success") {
                // ==================== 第三步：验证成功，安全跳转区 ====================
                Text("✓ 登录验证成功！")
                    .fontSize(20)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(0xFF00AA00) // 给个绿色的成功提示
                    .margin(bottom: 32)

                Button("进入完善资料页")
                    .width(80.percent)
                    .onClick({ =>
                        // 🌟 这里是纯正的 UI 主线程同步点击，绝对安全，不会再崩溃！
                        Router.push(url: "ProfileSetupPage")
                    })
            } else {
                // ==================== 第二步：输入验证码 ====================
                Text("验证码已发至 ${this.email}")
                    .fontSize(14)
                    .fontColor(0xFF888888)
                    .margin(bottom: 16)

                TextInput(placeholder: "输入6位验证码")
                    .width(80.percent)
                    .margin(bottom: 16)
                    .onChange({ value: String =>
                        this.code = value
                    })

                Button(this.getVerifyButtonText())
                    .width(80.percent)
                    .enabled(!this.verifying)
                    .margin(bottom: 12)
                    .onClick({ =>
                        this.errorMsg = ""
                        if (this.code == "") {
                            this.errorMsg = "请输入验证码"
                            return
                        }

                        this.verifying = true

                        AuthService.verify(
                            this.email,
                            this.code,
                            { nextPage: String =>
                                // 🌟 核心改动：异步回调里绝对不再执行 Router.push！
                                // 我们只更新页面状态，UI 引擎会自动帮我们切到第三步的界面。
                                this.step = "success"
                                this.verifying = false
                            },
                            { msg: String =>
                                this.errorMsg = msg
                                this.verifying = false
                            }
                        )
                    })

                Button("重新发送")
                    .width(80.percent)
                    .enabled(!this.sending)
                    .onClick({ =>
                        this.errorMsg = ""
                        this.sending = true
                        AuthService.sendCode(
                            this.email,
                            { normalizedEmail: String =>
                                this.email = normalizedEmail
                                this.code = ""
                                this.sending = false
                            },
                            { msg: String =>
                                this.errorMsg = msg
                                this.sending = false
                            }
                        )
                    })
            }

            // 全局错误提示区
            if (this.errorMsg != "") {
                Text(this.errorMsg)
                    .width(80.percent)
                    .fontColor(0xFFFF0000)
                    .margin(top: 16)
            }
        }
        .width(100.percent)
        .height(100.percent)
        .justifyContent(FlexAlign.Center)
    }
}