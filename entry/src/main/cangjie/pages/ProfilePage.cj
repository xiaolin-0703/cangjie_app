package ohos_app_cangjie_entry.pages

internal import ohos.base.LengthProp
import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.router.*
import ohos_app_cangjie_entry.common.ApiConfig
import ohos_app_cangjie_entry.service.UserService
import ohos_app_cangjie_entry.service.EventService
import ohos_app_cangjie_entry.service.ImageUploadService

@Entry
@Component
class ProfilePage {
    @State var loading: Bool = false
    @State var saving: Bool = false
    @State var firstLoaded: Bool = false
    @State var errorMsg: String = ""
    @State var successMsg: String = ""

    @State var nickname: String = ""
    @State var grade: String = ""
    @State var department: String = ""
    @State var bio: String = ""
    @State var email: String = ""
    @State var avatarUrl: String = ""
    @State var avatarPreviewUri: String = ""

    @State var inputNickname: String = ""
    @State var inputGrade: String = ""
    @State var inputDepartment: String = ""
    @State var inputAvatarUrl: String = ""
    @State var inputBio: String = ""
    @State var uploadingAvatar: Bool = false

    @State var joined1Id: String = ""
    @State var joined1Title: String = ""
    @State var joined1Time: String = ""
    @State var joined1Location: String = ""
    @State var joined1Status: String = ""

    @State var joined2Id: String = ""
    @State var joined2Title: String = ""
    @State var joined2Time: String = ""
    @State var joined2Location: String = ""
    @State var joined2Status: String = ""

    @State var joined3Id: String = ""
    @State var joined3Title: String = ""
    @State var joined3Time: String = ""
    @State var joined3Location: String = ""
    @State var joined3Status: String = ""

    public func aboutToAppear(): Unit {
        if (!this.firstLoaded && !this.loading) {
            this.loadPageData()
        }
    }

    func getSaveButtonText(): String {
        if (this.saving) {
            return "保存中..."
        }
        return "保存资料"
    }

    func normalizeStatusText(status: String): String {
        if (status == "published") {
            return "正在报名中"
        }
        if (status == "finished") {
            return "已结束"
        }
        if (status == "cancelled") {
            return "已取消"
        }
        if (status == "") {
            return "状态待定"
        }
        return status
    }

    func clearJoinedEvents() {
        this.joined1Id = ""
        this.joined1Title = ""
        this.joined1Time = ""
        this.joined1Location = ""
        this.joined1Status = ""

        this.joined2Id = ""
        this.joined2Title = ""
        this.joined2Time = ""
        this.joined2Location = ""
        this.joined2Status = ""

        this.joined3Id = ""
        this.joined3Title = ""
        this.joined3Time = ""
        this.joined3Location = ""
        this.joined3Status = ""
    }

    func hasAnyJoinedEvent(): Bool {
        return this.joined1Title != "" || this.joined2Title != "" || this.joined3Title != ""
    }

    func pickValue(newValue: String, oldValue: String): String {
        if (newValue != "") {
            return newValue
        }
        return oldValue
    }

    func fillProfile(raw: String) {
        this.nickname = UserService.extractProfileField(raw, "nickname")
        this.grade = UserService.extractProfileField(raw, "grade")
        this.department = UserService.extractProfileField(raw, "department")
        this.bio = UserService.extractProfileField(raw, "bio")
        this.email = UserService.extractProfileField(raw, "email")
        this.avatarUrl = UserService.extractProfileField(raw, "avatarUrl")
        this.avatarPreviewUri = this.avatarUrl
    }

    func fillJoinedEvents(raw: String) {
        this.clearJoinedEvents()

        this.joined1Id = UserService.extractEventField(raw, 0, "id")
        this.joined1Title = UserService.extractEventField(raw, 0, "title")
        this.joined1Time = UserService.extractEventField(raw, 0, "startTimeText")
        this.joined1Location = UserService.extractEventField(raw, 0, "location")
        this.joined1Status = this.normalizeStatusText(
            UserService.extractEventField(raw, 0, "status")
        )

        this.joined2Id = UserService.extractEventField(raw, 1, "id")
        this.joined2Title = UserService.extractEventField(raw, 1, "title")
        this.joined2Time = UserService.extractEventField(raw, 1, "startTimeText")
        this.joined2Location = UserService.extractEventField(raw, 1, "location")
        this.joined2Status = this.normalizeStatusText(
            UserService.extractEventField(raw, 1, "status")
        )

        this.joined3Id = UserService.extractEventField(raw, 2, "id")
        this.joined3Title = UserService.extractEventField(raw, 2, "title")
        this.joined3Time = UserService.extractEventField(raw, 2, "startTimeText")
        this.joined3Location = UserService.extractEventField(raw, 2, "location")
        this.joined3Status = this.normalizeStatusText(
            UserService.extractEventField(raw, 2, "status")
        )
    }

    func loadPageData() {
        this.loading = true
        this.errorMsg = ""
        this.successMsg = ""

        UserService.getMyProfile(
            { raw: String =>
                this.fillProfile(raw)

                UserService.getMyJoinedEvents(
                    { raw2: String =>
                        this.fillJoinedEvents(raw2)
                        this.loading = false
                        this.firstLoaded = true
                    },
                    { msg2: String =>
                        this.loading = false
                        this.firstLoaded = true
                        this.errorMsg = msg2
                    }
                )
            },
            { msg: String =>
                this.loading = false
                this.firstLoaded = true
                this.errorMsg = msg
            }
        )
    }

    func saveProfile() {
        this.saving = true
        this.errorMsg = ""
        this.successMsg = ""

        let finalNickname = this.pickValue(this.inputNickname, this.nickname)
        let finalGrade = this.pickValue(this.inputGrade, this.grade)
        let finalDepartment = this.pickValue(this.inputDepartment, this.department)
        let finalAvatarUrl = this.pickValue(this.inputAvatarUrl, this.avatarUrl)
        let finalBio = this.pickValue(this.inputBio, this.bio)

        UserService.updateMyProfile(
            finalNickname,
            finalGrade,
            finalDepartment,
            finalAvatarUrl,
            finalBio,
            { _: String =>
                this.nickname = finalNickname
                this.grade = finalGrade
                this.department = finalDepartment
                this.avatarUrl = finalAvatarUrl
                this.bio = finalBio

                this.inputNickname = ""
                this.inputGrade = ""
                this.inputDepartment = ""
                this.inputAvatarUrl = ""
                this.inputBio = ""

                this.saving = false
                this.successMsg = "资料已保存"
            },
            { msg: String =>
                this.saving = false
                this.errorMsg = msg
            }
        )
    }

    func getAvatarButtonText(): String {
        if (this.uploadingAvatar) {
            return "头像上传中..."
        }
        return "从相册更换头像"
    }

    func chooseAvatar() {
        this.errorMsg = ""
        this.successMsg = ""
        this.uploadingAvatar = true
        ImageUploadService.pickAndUploadImage(
            { localUri: String =>
                this.avatarPreviewUri = localUri
            },
            { imageUrl: String =>
                this.avatarUrl = imageUrl
                this.avatarPreviewUri = imageUrl
                this.inputAvatarUrl = imageUrl
                this.uploadingAvatar = false
                this.successMsg = "头像已上传，点击保存资料后生效"
            },
            { msg: String =>
                this.errorMsg = msg
                this.uploadingAvatar = false
            }
        )
    }

    func goToEventDetail(eventId: String, title: String, timeText: String, location: String, statusText: String) {
        EventService.setCurrentEventDetail(
            eventId,
            title,
            timeText,
            location,
            statusText,
            "",
            "",
            ""
        )
        Router.push(url: "EventDetailPage")
    }

    func build() {
        Column {
            Column {
                Row {
                    Column {
                        Text("个人中心")
                            .fontSize(28)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFF222222)
                            .margin(bottom: 6)

                        Text("查看并修改你的资料，以及你报名的活动")
                            .fontSize(14)
                            .fontColor(0xFF666666)
                    }
                    .layoutWeight(1)

                    Text("我的")
                        .fontSize(13)
                        .fontColor(0xFFFF7A45)
                        .backgroundColor(0xFFFFFFFF)
                        .padding(left: 14, right: 14, top: 8, bottom: 8)
                        .borderRadius(18)
                }
                .width(100.percent)
                .margin(bottom: 16)

                Row {
                    Button("返回首页")
                        .layoutWeight(1)
                        .height(40)
                        .backgroundColor(0xFFFFFFFF)
                        .fontColor(0xFFFF7A45)
                        .borderRadius(20)
                        .margin(right: 8)
                        .onClick({ =>
                            Router.push(url: "HomePage")
                        })

                    Button("退出登录")
                        .layoutWeight(1)
                        .height(40)
                        .backgroundColor(0xFFFF7A45)
                        .fontColor(0xFFFFFFFF)
                        .borderRadius(20)
                        .onClick({ =>
                            ApiConfig.clearAccessToken()
                            Router.push(url: "LoginPage")
                        })
                }
                .width(100.percent)
            }
            .width(100.percent)
            .padding(left: 16, right: 16, top: 24, bottom: 20)
            .backgroundColor(0xFFFFF3EE)

            Scroll {
                Column {
                    if (this.loading) {
                        Column {
                            Text("正在加载个人资料...")
                                .fontSize(18)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF222222)
                                .margin(bottom: 8)

                            Text("稍等一下，你的资料和活动马上就来。")
                                .fontSize(13)
                                .fontColor(0xFF777777)
                        }
                        .width(100.percent)
                        .padding(18)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 12)
                    }

                    if (this.errorMsg != "") {
                        Column {
                            Text("操作失败")
                                .fontSize(18)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF222222)
                                .margin(bottom: 8)

                            Text(this.errorMsg)
                                .fontSize(13)
                                .fontColor(0xFFFF0000)
                        }
                        .width(100.percent)
                        .padding(16)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 12)
                    }

                    if (this.successMsg != "") {
                        Column {
                            Text("保存成功")
                                .fontSize(18)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF2E9B4B)
                                .margin(bottom: 8)

                            Text(this.successMsg)
                                .fontSize(13)
                                .fontColor(0xFF666666)
                        }
                        .width(100.percent)
                        .padding(16)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 12)
                    }

                    Column {
                        Text("基本资料")
                            .fontSize(20)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFF222222)
                            .margin(bottom: 14)

                        Row {
                            if (this.avatarPreviewUri != "") {
                                Image(this.avatarPreviewUri)
                                    .width(72)
                                    .height(72)
                                    .borderRadius(36)
                                    .margin(right: 14)
                            } else {
                                Text("头像")
                                    .width(72)
                                    .height(72)
                                    .fontSize(16)
                                    .fontColor(0xFFFF7A45)
                                    .backgroundColor(0xFFFFF1EA)
                                    .borderRadius(36)
                                    .margin(right: 14)
                            }

                            Column {
                                Text(this.nickname)
                                    .fontSize(18)
                                    .fontWeight(FontWeight.Bold)
                                    .fontColor(0xFF222222)
                                    .margin(bottom: 6)

                                Text(this.department)
                                    .fontSize(13)
                                    .fontColor(0xFF777777)
                            }
                            .layoutWeight(1)
                        }
                        .width(100.percent)
                        .margin(bottom: 18)

                        Text("校园邮箱")
                            .fontSize(13)
                            .fontColor(0xFF777777)
                            .margin(bottom: 6)

                        Text(this.email)
                            .fontSize(14)
                            .fontColor(0xFF222222)
                            .margin(bottom: 16)

                        Text("当前昵称")
                            .fontSize(13)
                            .fontColor(0xFF777777)
                            .margin(bottom: 6)

                        Text(this.nickname)
                            .fontSize(14)
                            .fontColor(0xFF222222)
                            .margin(bottom: 12)

                        TextInput(placeholder: "输入新昵称")
                            .width(100.percent)
                            .margin(bottom: 14)
                            .onChange({ v: String =>
                                this.inputNickname = v
                            })

                        Text("当前年级")
                            .fontSize(13)
                            .fontColor(0xFF777777)
                            .margin(bottom: 6)

                        Text(this.grade)
                            .fontSize(14)
                            .fontColor(0xFF222222)
                            .margin(bottom: 12)

                        TextInput(placeholder: "输入新年级")
                            .width(100.percent)
                            .margin(bottom: 14)
                            .onChange({ v: String =>
                                this.inputGrade = v
                            })

                        Text("当前院系")
                            .fontSize(13)
                            .fontColor(0xFF777777)
                            .margin(bottom: 6)

                        Text(this.department)
                            .fontSize(14)
                            .fontColor(0xFF222222)
                            .margin(bottom: 12)

                        TextInput(placeholder: "输入新院系")
                            .width(100.percent)
                            .margin(bottom: 14)
                            .onChange({ v: String =>
                                this.inputDepartment = v
                            })

                        Text("当前头像")
                            .fontSize(13)
                            .fontColor(0xFF777777)
                            .margin(bottom: 6)

                        if (this.avatarUrl != "") {
                            Text("已设置头像")
                                .fontSize(14)
                                .fontColor(0xFF222222)
                                .margin(bottom: 12)
                        } else {
                            Text("未设置头像")
                                .fontSize(14)
                                .fontColor(0xFF777777)
                                .margin(bottom: 12)
                        }

                        Button(this.getAvatarButtonText())
                            .width(100.percent)
                            .height(42)
                            .enabled(!this.uploadingAvatar && !this.saving)
                            .backgroundColor(0xFFFFF1EA)
                            .fontColor(0xFFFF7A45)
                            .borderRadius(14)
                            .margin(bottom: 14)
                            .onClick({ =>
                                this.chooseAvatar()
                            })

                        Text("当前简介")
                            .fontSize(13)
                            .fontColor(0xFF777777)
                            .margin(bottom: 6)

                        Text(this.bio)
                            .fontSize(14)
                            .fontColor(0xFF222222)
                            .margin(bottom: 12)

                        TextInput(placeholder: "输入新简介")
                            .width(100.percent)
                            .margin(bottom: 16)
                            .onChange({ v: String =>
                                this.inputBio = v
                            })

                        Button(this.getSaveButtonText())
                            .width(100.percent)
                            .height(42)
                            .enabled(!this.saving && !this.uploadingAvatar)
                            .backgroundColor(0xFFFF7A45)
                            .fontColor(0xFFFFFFFF)
                            .borderRadius(14)
                            .onClick({ =>
                                this.saveProfile()
                            })
                    }
                    .width(100.percent)
                    .padding(18)
                    .backgroundColor(0xFFFFFFFF)
                    .borderRadius(18)
                    .margin(bottom: 12)

                    Column {
                        Text("我报名的活动")
                            .fontSize(20)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFF222222)
                            .margin(bottom: 14)

                        if (!this.hasAnyJoinedEvent()) {
                            Text("你暂时还没有报名活动")
                                .fontSize(14)
                                .fontColor(0xFF777777)
                        } else {
                            if (this.joined1Title != "") {
                                Column {
                                    Text(this.joined1Title)
                                        .fontSize(18)
                                        .fontWeight(FontWeight.Bold)
                                        .fontColor(0xFF222222)
                                        .margin(bottom: 8)

                                    Text(this.joined1Time)
                                        .fontSize(13)
                                        .fontColor(0xFF666666)
                                        .margin(bottom: 4)

                                    Text(this.joined1Location)
                                        .fontSize(13)
                                        .fontColor(0xFF666666)
                                        .margin(bottom: 8)

                                    Text(this.joined1Status)
                                        .fontSize(12)
                                        .fontColor(0xFFFF7A45)
                                        .margin(bottom: 12)

                                    Button("查看详情")
                                        .width(100.percent)
                                        .height(42)
                                        .backgroundColor(0xFFFF7A45)
                                        .fontColor(0xFFFFFFFF)
                                        .borderRadius(14)
                                        .onClick({ =>
                                            this.goToEventDetail(
                                                this.joined1Id,
                                                this.joined1Title,
                                                this.joined1Time,
                                                this.joined1Location,
                                                this.joined1Status
                                            )
                                        })
                                }
                                .width(100.percent)
                                .padding(16)
                                .backgroundColor(0xFFF7F8FA)
                                .borderRadius(18)
                                .margin(bottom: 12)
                            }

                            if (this.joined2Title != "") {
                                Column {
                                    Text(this.joined2Title)
                                        .fontSize(18)
                                        .fontWeight(FontWeight.Bold)
                                        .fontColor(0xFF222222)
                                        .margin(bottom: 8)

                                    Text(this.joined2Time)
                                        .fontSize(13)
                                        .fontColor(0xFF666666)
                                        .margin(bottom: 4)

                                    Text(this.joined2Location)
                                        .fontSize(13)
                                        .fontColor(0xFF666666)
                                        .margin(bottom: 8)

                                    Text(this.joined2Status)
                                        .fontSize(12)
                                        .fontColor(0xFFFF7A45)
                                        .margin(bottom: 12)

                                    Button("查看详情")
                                        .width(100.percent)
                                        .height(42)
                                        .backgroundColor(0xFFFF7A45)
                                        .fontColor(0xFFFFFFFF)
                                        .borderRadius(14)
                                        .onClick({ =>
                                            this.goToEventDetail(
                                                this.joined2Id,
                                                this.joined2Title,
                                                this.joined2Time,
                                                this.joined2Location,
                                                this.joined2Status
                                            )
                                        })
                                }
                                .width(100.percent)
                                .padding(16)
                                .backgroundColor(0xFFF7F8FA)
                                .borderRadius(18)
                                .margin(bottom: 12)
                            }

                            if (this.joined3Title != "") {
                                Column {
                                    Text(this.joined3Title)
                                        .fontSize(18)
                                        .fontWeight(FontWeight.Bold)
                                        .fontColor(0xFF222222)
                                        .margin(bottom: 8)

                                    Text(this.joined3Time)
                                        .fontSize(13)
                                        .fontColor(0xFF666666)
                                        .margin(bottom: 4)

                                    Text(this.joined3Location)
                                        .fontSize(13)
                                        .fontColor(0xFF666666)
                                        .margin(bottom: 8)

                                    Text(this.joined3Status)
                                        .fontSize(12)
                                        .fontColor(0xFFFF7A45)
                                        .margin(bottom: 12)

                                    Button("查看详情")
                                        .width(100.percent)
                                        .height(42)
                                        .backgroundColor(0xFFFF7A45)
                                        .fontColor(0xFFFFFFFF)
                                        .borderRadius(14)
                                        .onClick({ =>
                                            this.goToEventDetail(
                                                this.joined3Id,
                                                this.joined3Title,
                                                this.joined3Time,
                                                this.joined3Location,
                                                this.joined3Status
                                            )
                                        })
                                }
                                .width(100.percent)
                                .padding(16)
                                .backgroundColor(0xFFF7F8FA)
                                .borderRadius(18)
                                .margin(bottom: 12)
                            }
                        }
                    }
                    .width(100.percent)
                    .padding(18)
                    .backgroundColor(0xFFFFFFFF)
                    .borderRadius(18)
                    .margin(bottom: 12)
                }
                .width(100.percent)
                .padding(left: 16, right: 16, top: 16, bottom: 20)
            }
            .layoutWeight(1)
        }
        .width(100.percent)
        .height(100.percent)
        .backgroundColor(0xFFF7F8FA)
    }
}
