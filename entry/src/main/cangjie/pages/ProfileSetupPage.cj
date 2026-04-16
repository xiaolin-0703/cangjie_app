package ohos_app_cangjie_entry.pages

internal import ohos.base.LengthProp
import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.router.*
import ohos_app_cangjie_entry.service.UserService

@Entry
@Component
class ProfileSetupPage {
    @State var nickname: String = ""
    @State var grade: String = ""
    @State var department: String = ""
    @State var avatarUrl: String = ""
    @State var mode: String = "real"
    @State var errorMsg: String = ""
    @State var saving: Bool = false

    // 🌟 新增：控制页面是否展示“成功状态”的标志位
    @State var isSuccess: Bool = false

    func validate(): Bool {
        if (this.nickname == "") {
            this.errorMsg = "请输入昵称"
            return false
        }
        if (this.grade == "") {
            this.errorMsg = "请输入年级"
            return false
        }
        if (this.department == "") {
            this.errorMsg = "请输入院系"
            return false
        }
        return true
    }

    func getRealModeText(): String {
        if (this.mode == "real") {
            return "✓ 实名模式"
        }
        return "实名模式"
    }

    func getAnonymousModeText(): String {
        if (this.mode == "anonymous") {
            return "✓ 匿名模式"
        }
        return "匿名模式"
    }

    func getModeHintText(): String {
        if (this.mode == "real") {
            return "实名模式下会展示院系信息"
        }
        return "匿名模式下仅展示随机昵称"
    }

    func getSaveButtonText(): String {
        if (this.saving) {
            return "保存中..."
        }
        return "保存并继续"
    }

    func build() {
        Column {
            if (this.isSuccess) {
                // ==================== 成功状态视图（安全跳转区） ====================
                Text("✓ 资料保存成功！")
                    .fontSize(24)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(0xFF00AA00)
                    .margin(bottom: 32)

                Button("进入主页")
                    .width(85.percent)
                    .onClick({ =>
                        // 🌟 纯正的 UI 主线程同步点击，绝对安全！
                        try {
                            Router.push(url: "HomePage")
                        } catch (e: Exception) {
                            this.errorMsg = "跳转失败，请检查 main_pages.json 是否注册了 HomePage"
                            this.isSuccess = false // 退回表单页显示错误
                        }
                    })

                if (this.errorMsg != "") {
                    Text(this.errorMsg)
                        .fontColor(0xFFFF0000)
                        .margin(top: 16)
                }
            } else {
                // ==================== 原始表单视图 ====================
                Text("完善资料")
                    .fontSize(28)
                    .fontWeight(FontWeight.Bold)
                    .margin(bottom: 12)

                Text("首次登录请先完善基础信息")
                    .fontSize(14)
                    .fontColor(0xFF888888)
                    .margin(bottom: 32)

                TextInput(placeholder: "请输入昵称")
                    .width(85.percent)
                    .margin(bottom: 16)
                    .onChange({ val: String =>
                        this.nickname = val
                    })

                TextInput(placeholder: "请输入年级，例如：2023级")
                    .width(85.percent)
                    .margin(bottom: 16)
                    .onChange({ val: String =>
                        this.grade = val
                    })

                TextInput(placeholder: "请输入院系，例如：计算机学院")
                    .width(85.percent)
                    .margin(bottom: 16)
                    .onChange({ val: String =>
                        this.department = val
                    })

                TextInput(placeholder: "头像 URL（可选）")
                    .width(85.percent)
                    .margin(bottom: 24)
                    .onChange({ val: String =>
                        this.avatarUrl = val
                    })

                Text("默认身份模式")
                    .width(85.percent)
                    .fontSize(16)
                    .margin(bottom: 12)

                Row {
                    Button(this.getRealModeText())
                        .width(40.percent)
                        .margin(right: 12)
                        .onClick({ =>
                            this.mode = "real"
                        })

                    Button(this.getAnonymousModeText())
                        .width(40.percent)
                        .onClick({ =>
                            this.mode = "anonymous"
                        })
                }
                .width(85.percent)
                .margin(bottom: 16)

                Text(this.getModeHintText())
                    .width(85.percent)
                    .fontSize(13)
                    .fontColor(0xFF888888)
                    .margin(bottom: 24)

                if (this.errorMsg != "") {
                    Text(this.errorMsg)
                        .width(85.percent)
                        .fontColor(0xFFFF0000)
                        .margin(bottom: 16)
                }

                Button(this.getSaveButtonText())
                    .width(85.percent)
                    .enabled(!this.saving)
                    .onClick({ =>
                        this.errorMsg = ""
                        if (!this.validate()) {
                            return
                        }

                        this.saving = true
                        UserService.updateProfile(
                            this.nickname,
                            this.grade,
                            this.department,
                            this.avatarUrl,
                            this.mode,
                            { nextPage: String =>
                                // 🌟 核心改动：异步回调里只改状态，绝不写 Router.push
                                this.saving = false
                                this.isSuccess = true
                            },
                            { msg: String =>
                                this.errorMsg = msg
                                this.saving = false
                            }
                        )
                    })
            }
        }
        .width(100.percent)
        .height(100.percent)
        .justifyContent(FlexAlign.Center)
    }
}