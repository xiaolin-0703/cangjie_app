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
    @State var step: String = "email"
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
                                this.step = "code" // 成功后切换到验证码视图
                                this.sending = false
                            },
                            { msg: String =>
                                this.errorMsg = msg
                                this.sending = false
                            }
                        )
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
                        // 1. 清理错误状态并校验
                        this.errorMsg = ""
                        if (this.code == "") {
                            this.errorMsg = "请输入验证码"
                            return
                        }

                        // 2. 锁定按钮状态
                        this.verifying = true

                        // 3. 执行跳转（加上防卡死的 try-catch 保护）
                        try {
                            // 【核心修复】：和你的 index.cj 保持绝对一致，不要带 "pages/" 前缀！
                            Router.push(url: "ProfileSetupPage")
                        } catch (e: Exception) {
                            // 如果真的跳转失败了，至少把错误信息打印在屏幕上，而不是静默卡死
                            this.errorMsg = "跳转失败，请检查 main_pages.json"
                        }

                        // 4. 无论跳转成功还是失败，都必须释放按钮锁定状态
                        this.verifying = false
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