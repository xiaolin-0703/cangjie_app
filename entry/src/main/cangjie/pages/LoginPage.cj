package ohos_app_cangjie_entry.pages

import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos_app_cangjie_entry.service.AuthService// 引入时间模块以使用 Duration 和 sleep
import std.time.*
import std.sync.*


@Entry
@Component
class LoginPage { // 【修复】使用 struct 代替 class
    @State var email: String = ""
    @State var code: String = ""
    @State var step: String = "email"
    @State var errorMsg: String = ""
    @State var countdown: Int64 = 0
    @State var sending: Bool = false

    func build() {
        Column {
            Text("选课评价社区")
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
                .margin(bottom: 48)

            if (this.step == "email") {
                TextInput(placeholder: "输入校园邮箱")
                    .width(80.percent)
                    .margin(bottom: 16)
                    .onChange({ val: String => this.email = val }) // 建议显式声明参数类型

                // 【修复】使用 if-else 表达式代替三元运算符
                Button(if (this.sending) { "发送中..." } else { "发送验证码" })
                    .width(80.percent)
                    .enabled(!this.sending)
                    .onClick({  =>  // 【修复】onClick 需要显式忽略事件参数 _ =>
                        this.sending = true
                        this.errorMsg = ""
                        AuthService.sendCode(
                            this.email,
                            { => // 直接传闭包，删掉 onSuccess:
                                this.step = "code"
                                this.sending = false
                                this.startCountdown()
                            },
                            { msg: String => // 直接传闭包，删掉 onError:
                                this.errorMsg = msg
                                this.sending = false
                            }
                        )
                    })

            } else {
                Text("验证码已发至 ${this.email}")
                    .fontSize(14)
                    .fontColor(0xFF888888)
                    .margin(bottom: 16)

                TextInput(placeholder: "输入6位验证码")
                    .width(80.percent)
                    .margin(bottom: 16)
                    .onChange({ val: String => this.code = val })

                Button("登录 / 注册")
                    .width(80.percent)
                    .margin(bottom: 12)
                    .onClick({  => // 【修复】显式忽略事件参数 _ =>
                        this.errorMsg = ""
                        AuthService.verify(
                            this.email,
                            this.code,
                            { token => // 删掉 onSuccess:
                                // TODO: 存 token，跳转主页
                            },
                            { msg: String => // 删掉 onError:
                                this.errorMsg = msg
                            }
                        )
                    })

                // 【修复】使用 if-else 表达式代替三元运算符
                Button(if (this.countdown > 0) { "${this.countdown}秒后重发" } else { "重新发送" })
                    .width(80.percent)
                    .enabled(this.countdown == 0)
                    .onClick({ =>
                        this.sending = true
                        this.errorMsg = ""// 【修复】显式忽略事件参数 _ =>
                        AuthService.sendCode(
                            this.email,
                            { => this.startCountdown() }, // 删掉 onSuccess:
                            { _ => }                      // 删掉 onError:
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

    func startCountdown() {
        this.countdown = 60
        // 开启一个轻量级线程来处理倒计时
        spawn {
            while (this.countdown > 0) {
                sleep(Duration.second) // 线程休眠 1 秒
                this.countdown -= 1    // 更新 @State 变量，自动触发 UI 刷新
            }
        }
    }
}