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
    @State var avatarPreviewUri: String = ""
    @State var mode: String = "real"
    @State var errorMsg: String = ""
    @State var saving: Bool = false
    @State var uploadingAvatar: Bool = false

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

    func getAvatarButtonText(): String {
        if (this.uploadingAvatar) {
            return "头像处理中..."
        }
        return "应用头像链接"
    }

    func chooseAvatar() {
        this.errorMsg = ""

        if (this.avatarUrl == "") {
            this.errorMsg = "请先粘贴头像图片链接"
            return
        }

        this.avatarPreviewUri = this.avatarUrl
    }

    func build() {
        Column {
            if (this.isSuccess) {
                Column {
                    Text("资料保存成功")
                        .fontSize(24)
                        .fontWeight(FontWeight.Bold)
                        .fontColor(0xFF24324A)
                        .margin(bottom: 8)

                    Text("你的校园身份已经准备好了")
                        .fontSize(14)
                        .fontColor(0xFF6D7B99)
                        .margin(bottom: 24)

                    Button("进入主页")
                        .width(100.percent)
                        .height(44)
                        .backgroundColor(0xFF2F80FF)
                        .fontColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .onClick({ =>
                            try {
                                Router.push(url: "HomePage")
                            } catch (e: Exception) {
                                this.errorMsg = "跳转失败，请检查 main_pages.json 是否注册了 HomePage"
                                this.isSuccess = false
                            }
                        })

                    if (this.errorMsg != "") {
                        Text(this.errorMsg)
                            .fontSize(13)
                            .fontColor(0xFFE96B6B)
                            .margin(top: 16)
                    }
                }
                .width(100.percent)
                .padding(20)
                .backgroundColor(0xFFFFFFFF)
                .borderRadius(22)
                .margin(left: 16, right: 16)
            } else {
                Column {
                    Row {
                        Column {
                            Text("完善资料")
                                .fontSize(28)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF24324A)
                                .margin(bottom: 6)

                            Text("首次登录请先补全你的校园身份")
                                .fontSize(14)
                                .fontColor(0xFF6D7B99)
                        }
                        .layoutWeight(1)

                        Text("资料")
                            .fontSize(13)
                            .fontColor(0xFF2F80FF)
                            .backgroundColor(0xFFFFFFFF)
                            .padding(left: 14, right: 14, top: 8, bottom: 8)
                            .borderRadius(18)
                    }
                    .width(100.percent)
                }
                .width(100.percent)
                .padding(left: 16, right: 16, top: 24, bottom: 20)
                .backgroundColor(0xFFEAF2FF)

                Scroll {
                    Column {
                        Column {
                            Text("昵称")
                                .fontSize(14)
                                .fontColor(0xFF7E8CA8)
                                .margin(bottom: 8)

                            TextInput(placeholder: "请输入昵称")
                                .width(100.percent)
                                .height(44)
                                .backgroundColor(0xFFF7FAFF)
                                .borderRadius(16)
                                .margin(bottom: 16)
                                .onChange({ val: String =>
                                    this.nickname = val
                                })

                            Text("年级")
                                .fontSize(14)
                                .fontColor(0xFF7E8CA8)
                                .margin(bottom: 8)

                            TextInput(placeholder: "例如：2023级")
                                .width(100.percent)
                                .height(44)
                                .backgroundColor(0xFFF7FAFF)
                                .borderRadius(16)
                                .margin(bottom: 16)
                                .onChange({ val: String =>
                                    this.grade = val
                                })

                            Text("院系")
                                .fontSize(14)
                                .fontColor(0xFF7E8CA8)
                                .margin(bottom: 8)

                            TextInput(placeholder: "例如：计算机学院")
                                .width(100.percent)
                                .height(44)
                                .backgroundColor(0xFFF7FAFF)
                                .borderRadius(16)
                                .margin(bottom: 16)
                                .onChange({ val: String =>
                                    this.department = val
                                })

                            Text("头像")
                                .fontSize(14)
                                .fontColor(0xFF7E8CA8)
                                .margin(bottom: 8)

                            TextInput(placeholder: "粘贴头像图片链接")
                                .width(100.percent)
                                .height(44)
                                .backgroundColor(0xFFF7FAFF)
                                .borderRadius(16)
                                .margin(bottom: 12)
                                .onChange({ val: String =>
                                    this.avatarUrl = val
                                    if (val != "") {
                                        this.avatarPreviewUri = val
                                    } else {
                                        this.avatarPreviewUri = ""
                                    }
                                })

                            Button(this.getAvatarButtonText())
                                .width(100.percent)
                                .height(44)
                                .enabled(!this.uploadingAvatar)
                                .backgroundColor(0xFFEAF2FF)
                                .fontColor(0xFF2F80FF)
                                .borderRadius(16)
                                .margin(bottom: 12)
                                .onClick({ =>
                                    this.chooseAvatar()
                                })

                            if (this.avatarPreviewUri != "") {
                                Image(this.avatarPreviewUri)
                                    .width(84)
                                    .height(84)
                                    .borderRadius(42)
                                    .margin(bottom: 18)
                            } else {
                                Text("未设置头像")
                                    .fontSize(13)
                                    .fontColor(0xFF7E8CA8)
                                    .margin(bottom: 18)
                            }

                            Text("默认身份模式")
                                .fontSize(14)
                                .fontColor(0xFF7E8CA8)
                                .margin(bottom: 10)

                            if (this.mode == "real") {
                                Row {
                                    Button(this.getRealModeText())
                                        .layoutWeight(1)
                                        .height(40)
                                        .backgroundColor(0xFF2F80FF)
                                        .fontColor(0xFFFFFFFF)
                                        .borderRadius(20)
                                        .margin(right: 8)
                                        .onClick({ =>
                                            this.mode = "real"
                                        })

                                    Button(this.getAnonymousModeText())
                                        .layoutWeight(1)
                                        .height(40)
                                        .backgroundColor(0xFFEAF2FF)
                                        .fontColor(0xFF2F80FF)
                                        .borderRadius(20)
                                        .onClick({ =>
                                            this.mode = "anonymous"
                                        })
                                }
                                .width(100.percent)
                                .margin(bottom: 12)
                            } else {
                                Row {
                                    Button(this.getRealModeText())
                                        .layoutWeight(1)
                                        .height(40)
                                        .backgroundColor(0xFFEAF2FF)
                                        .fontColor(0xFF2F80FF)
                                        .borderRadius(20)
                                        .margin(right: 8)
                                        .onClick({ =>
                                            this.mode = "real"
                                        })

                                    Button(this.getAnonymousModeText())
                                        .layoutWeight(1)
                                        .height(40)
                                        .backgroundColor(0xFF2F80FF)
                                        .fontColor(0xFFFFFFFF)
                                        .borderRadius(20)
                                        .onClick({ =>
                                            this.mode = "anonymous"
                                        })
                                }
                                .width(100.percent)
                                .margin(bottom: 12)
                            }

                            Text(this.getModeHintText())
                                .fontSize(13)
                                .fontColor(0xFF7E8CA8)
                                .margin(bottom: 18)

                            if (this.errorMsg != "") {
                                Text(this.errorMsg)
                                    .fontSize(14)
                                    .fontColor(0xFFE96B6B)
                                    .margin(bottom: 14)
                            }

                            Button(this.getSaveButtonText())
                                .width(100.percent)
                                .height(44)
                                .enabled(!this.saving && !this.uploadingAvatar)
                                .backgroundColor(0xFF2F80FF)
                                .fontColor(0xFFFFFFFF)
                                .borderRadius(18)
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
                        .width(100.percent)
                        .padding(18)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(20)
                    }
                    .width(100.percent)
                    .padding(left: 16, right: 16, top: 16, bottom: 24)
                }
                .layoutWeight(1)
            }
        }
        .width(100.percent)
        .height(100.percent)
        .backgroundColor(0xFFF4F8FF)
    }
}
