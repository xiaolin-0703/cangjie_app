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

@Entry
@Component
class ProfilePage {
    @State var loading: Bool = false
    @State var saving: Bool = false
    @State var firstLoaded: Bool = false
    @State var errorMsg: String = ""
    @State var successMsg: String = ""

    @State var isEditMode: Bool = false

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
        if (status == "published") { return "正在报名中" }
        if (status == "finished") { return "已结束" }
        if (status == "cancelled") { return "已取消" }
        if (status == "") { return "状态待定" }
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
        if (newValue != "") { return newValue }
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
        this.joined1Status = this.normalizeStatusText(UserService.extractEventField(raw, 0, "status"))

        this.joined2Id = UserService.extractEventField(raw, 1, "id")
        this.joined2Title = UserService.extractEventField(raw, 1, "title")
        this.joined2Time = UserService.extractEventField(raw, 1, "startTimeText")
        this.joined2Location = UserService.extractEventField(raw, 1, "location")
        this.joined2Status = this.normalizeStatusText(UserService.extractEventField(raw, 1, "status"))

        this.joined3Id = UserService.extractEventField(raw, 2, "id")
        this.joined3Title = UserService.extractEventField(raw, 2, "title")
        this.joined3Time = UserService.extractEventField(raw, 2, "startTimeText")
        this.joined3Location = UserService.extractEventField(raw, 2, "location")
        this.joined3Status = this.normalizeStatusText(UserService.extractEventField(raw, 2, "status"))
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
        let finalAvatarUrl = ApiConfig.normalizeImageUrl(this.pickValue(this.inputAvatarUrl, this.avatarUrl))
        let finalBio = this.pickValue(this.inputBio, this.bio)

        UserService.updateMyProfileWithAvatar(
            finalNickname, finalGrade, finalDepartment, finalAvatarUrl, finalBio,
            { _: String =>
                this.nickname = finalNickname
                this.grade = finalGrade
                this.department = finalDepartment
                this.avatarUrl = finalAvatarUrl
                this.avatarPreviewUri = finalAvatarUrl
                this.bio = finalBio

                this.inputNickname = ""
                this.inputGrade = ""
                this.inputDepartment = ""
                this.inputAvatarUrl = ""
                this.inputBio = ""

                this.saving = false
                this.isEditMode = false // 保存成功后自动切回展示模式
                this.successMsg = "资料已保存"
            },
            { msg: String =>
                this.saving = false
                this.errorMsg = msg
            }
        )
    }

    func getAvatarButtonText(): String {
        if (this.uploadingAvatar) { return "头像处理中..." }
        return "应用预览"
    }

    func chooseAvatar() {
        this.errorMsg = ""
        this.successMsg = ""
        if (this.inputAvatarUrl == "") {
            this.errorMsg = "请先粘贴头像图片链接"
            return
        }


        let safeUrl = ApiConfig.normalizeImageUrl(this.inputAvatarUrl)
        this.inputAvatarUrl = safeUrl
        this.avatarPreviewUri = safeUrl
        this.successMsg = "头像链接已应用，点击保存资料后生效"
    }

    func goToEventDetail(eventId: String, title: String, timeText: String, location: String, statusText: String) {
        EventService.setCurrentEventDetail(eventId, title, timeText, location, statusText, "", "", "")
        Router.push(url: "EventDetailPage")
    }

    func build() {
        Column {
            Row {
                Text("我的主页")
                    .fontSize(22)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(0xFF24324A)
            }
            .width(100.percent)
            .padding(left: 16, right: 16, top: 12, bottom: 8)
            .backgroundColor(0xFFFFFFFF)

            Scroll {
                Column {
                    if (this.loading && !this.firstLoaded) {
                        Text("正在加载数据...")
                            .fontSize(13)
                            .fontColor(0xFF9AA6BD)
                            .margin(top: 20, bottom: 20)
                    }

                    if (this.errorMsg != "") {
                        Text(this.errorMsg)
                            .fontSize(13)
                            .fontColor(0xFFE96B6B)
                            .padding(16)
                    }

                    if (this.successMsg != "") {
                        Text(this.successMsg)
                            .fontSize(13)
                            .fontColor(0xFF2E9B4B)
                            .padding(16)
                    }

                    if (this.isEditMode) {
                        // --- 编辑模式 ---
                        Column {
                            Text("编辑资料")
                                .fontSize(20)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF24324A)
                                .margin(bottom: 20)

                            if (this.avatarPreviewUri != "") {
                                Image(this.avatarPreviewUri).width(80).height(80).borderRadius(40).margin(bottom: 12)
                            } else {
                                Text("头像").width(80).height(80).fontSize(16).fontColor(0xFF2F80FF).backgroundColor(0xFFEAF2FF).borderRadius(40).textAlign(TextAlign.Center).lineHeight(80).margin(bottom: 12)
                            }

                            TextInput(placeholder: "头像链接 (留空保持原样)")
                                .width(100.percent).height(44).backgroundColor(0xFFF7FAFF).borderRadius(16).margin(bottom: 8)
                                .onChange({ v: String =>
                                    this.inputAvatarUrl = v
                                    this.avatarPreviewUri = if (v != "") { v } else { this.avatarUrl }
                                })

                            Button(this.getAvatarButtonText())
                                .width(100.percent).height(38).backgroundColor(0xFFEAF2FF).fontColor(0xFF2F80FF).borderRadius(12).margin(bottom: 16)
                                .onClick({ _: ClickEvent => this.chooseAvatar() })

                            TextInput(placeholder: "昵称：目前为 " + this.nickname)
                                .width(100.percent).height(44).backgroundColor(0xFFF7FAFF).borderRadius(16).margin(bottom: 12)
                                .onChange({ v: String => this.inputNickname = v })

                            TextInput(placeholder: "年级：目前为 " + this.grade)
                                .width(100.percent).height(44).backgroundColor(0xFFF7FAFF).borderRadius(16).margin(bottom: 12)
                                .onChange({ v: String => this.inputGrade = v })

                            TextInput(placeholder: "院系：目前为 " + this.department)
                                .width(100.percent).height(44).backgroundColor(0xFFF7FAFF).borderRadius(16).margin(bottom: 12)
                                .onChange({ v: String => this.inputDepartment = v })

                            TextInput(placeholder: "个人简介...")
                                .width(100.percent).height(72).backgroundColor(0xFFF7FAFF).borderRadius(16).margin(bottom: 20)
                                .onChange({ v: String => this.inputBio = v })

                            Button(this.getSaveButtonText())
                                .width(100.percent).height(44).backgroundColor(0xFF2F80FF).fontColor(0xFFFFFFFF).borderRadius(16).margin(bottom: 12)
                                .enabled(!this.saving)
                                .onClick({ _: ClickEvent => this.saveProfile() })

                            Button("取消编辑")
                                .width(100.percent).height(44).backgroundColor(0xFFF1F4F8).fontColor(0xFF6D7B99).borderRadius(16).margin(bottom: 12)
                                .onClick({ _: ClickEvent =>
                                    this.isEditMode = false
                                    this.avatarPreviewUri = this.avatarUrl
                                })
                            Button("退出登录")
                                .width(100.percent).height(44).backgroundColor(0xFFFFEEEE).fontColor(0xFFE96B6B).borderRadius(16).margin(bottom: 12)
                                .onClick({ _: ClickEvent =>
                                    ApiConfig.clearAccessToken()
                                    Router.push(url: "LoginPage")
                                })
                        }
                        .width(100.percent)
                        .padding(20)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(24)
                        .margin(left: 12, right: 12, bottom: 16, top: 12)

                    } else {
                        Column {
                            if (this.avatarUrl != "") {
                                Image(this.avatarUrl).width(88).height(88).borderRadius(44).margin(bottom: 12)
                            } else {
                                Text("未设置").width(88).height(88).fontSize(16).fontColor(0xFF2F80FF).backgroundColor(0xFFEAF2FF).borderRadius(44).textAlign(TextAlign.Center).lineHeight(88).margin(bottom: 12)
                            }

                            Text(if (this.nickname != "") { this.nickname } else { "神秘同学" })
                                .fontSize(24)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF24324A)
                                .margin(bottom: 8)

                            Row {
                                if (this.department != "") {
                                    Text(this.department)
                                        .fontSize(12).fontColor(0xFF2F80FF).backgroundColor(0xFFEAF2FF).padding(left: 10, right: 10, top: 4, bottom: 4).borderRadius(12).margin(right: 8)
                                }
                                if (this.grade != "") {
                                    Text(this.grade)
                                        .fontSize(12).fontColor(0xFF2F80FF).backgroundColor(0xFFEAF2FF).padding(left: 10, right: 10, top: 4, bottom: 4).borderRadius(12)
                                }
                            }.margin(bottom: 16)

                            Text(if (this.bio != "") { this.bio } else { "这个人很懒，还没有写简介。" })
                                .fontSize(14)
                                .fontColor(0xFF6D7B99)
                                .margin(bottom: 8)

                            Text(this.email)
                                .fontSize(12)
                                .fontColor(0xFF9AA6BD)
                                .margin(bottom: 24)
                            Button("编辑资料")
                                .width(100.percent)
                                .height(44)
                                .backgroundColor(0xFF2F80FF)
                                .fontColor(0xFFFFFFFF)
                                .borderRadius(16)
                                .onClick({ _: ClickEvent =>
                                    this.successMsg = ""
                                    this.isEditMode = true
                                })
                        }
                        .width(100.percent)
                        .padding(24)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(24)
                        .margin(left: 12, right: 12, bottom: 16, top: 12)
                        .alignItems(HorizontalAlign.Center)

                        Column {
                            Text("我报名的活动")
                                .fontSize(18)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF24324A)
                                .margin(bottom: 14)

                            if (!this.hasAnyJoinedEvent()) {
                                Text("暂时还没有报名活动")
                                    .fontSize(13)
                                    .fontColor(0xFF9AA6BD)
                            } else {
                                if (this.joined1Title != "") {
                                    Column {
                                        Text(this.joined1Title).fontSize(16).fontWeight(FontWeight.Bold).fontColor(0xFF24324A).margin(bottom: 6)
                                        Text(this.joined1Time + " · " + this.joined1Location).fontSize(12).fontColor(0xFF6D7B99).margin(bottom: 10)
                                        Row {
                                            Text(this.joined1Status).fontSize(11).fontColor(0xFF2F80FF)
                                            Row().layoutWeight(1)
                                            Text("查看详情").fontSize(12).fontColor(0xFF9AA6BD)
                                        }.width(100.percent)
                                    }.width(100.percent).padding(16).backgroundColor(0xFFF4F8FF).borderRadius(18).margin(bottom: 10)
                                    .onClick({ _: ClickEvent => this.goToEventDetail(this.joined1Id, this.joined1Title, this.joined1Time, this.joined1Location, this.joined1Status) })
                                }

                                if (this.joined2Title != "") {
                                    Column {
                                        Text(this.joined2Title).fontSize(16).fontWeight(FontWeight.Bold).fontColor(0xFF24324A).margin(bottom: 6)
                                        Text(this.joined2Time + " · " + this.joined2Location).fontSize(12).fontColor(0xFF6D7B99).margin(bottom: 10)
                                        Row {
                                            Text(this.joined2Status).fontSize(11).fontColor(0xFF2F80FF)
                                            Row().layoutWeight(1)
                                            Text("查看详情").fontSize(12).fontColor(0xFF9AA6BD)
                                        }.width(100.percent)
                                    }.width(100.percent).padding(16).backgroundColor(0xFFF4F8FF).borderRadius(18).margin(bottom: 10)
                                    .onClick({ _: ClickEvent => this.goToEventDetail(this.joined2Id, this.joined2Title, this.joined2Time, this.joined2Location, this.joined2Status) })
                                }

                                if (this.joined3Title != "") {
                                    Column {
                                        Text(this.joined3Title).fontSize(16).fontWeight(FontWeight.Bold).fontColor(0xFF24324A).margin(bottom: 6)
                                        Text(this.joined3Time + " · " + this.joined3Location).fontSize(12).fontColor(0xFF6D7B99).margin(bottom: 10)
                                        Row {
                                            Text(this.joined3Status).fontSize(11).fontColor(0xFF2F80FF)
                                            Row().layoutWeight(1)
                                            Text("查看详情").fontSize(12).fontColor(0xFF9AA6BD)
                                        }.width(100.percent)
                                    }.width(100.percent).padding(16).backgroundColor(0xFFF4F8FF).borderRadius(18).margin(bottom: 10)
                                    .onClick({ _: ClickEvent => this.goToEventDetail(this.joined3Id, this.joined3Title, this.joined3Time, this.joined3Location, this.joined3Status) })
                                }
                            }
                        }
                        .width(100.percent)
                        .margin(bottom: 18)
                    }
                    Row {}.height(88)
                }
                .width(100.percent)
            }
            .layoutWeight(1)

            Row {
                Text("广场")
                    .layoutWeight(1).height(40).textAlign(TextAlign.Center).fontSize(14).fontColor(0xFF5E6C84)
                    .onClick({ _: ClickEvent => Router.push(url: "HomePage") })

                Text("圈子")
                    .layoutWeight(1).height(40).textAlign(TextAlign.Center).fontSize(14).fontColor(0xFF5E6C84)
                    .onClick({ _: ClickEvent => Router.push(url: "CirclesPage") })

                Text("+")
                    .width(52).height(52).backgroundColor(0xFF2F80FF).fontColor(0xFFFFFFFF).fontSize(28).fontWeight(FontWeight.Bold).borderRadius(26).textAlign(TextAlign.Center).margin(left: 6, right: 6)
                    .onClick({ _: ClickEvent => Router.push(url: "CreatePostPage") }) // 默认跳转发帖

                Text("活动")
                    .layoutWeight(1).height(40).textAlign(TextAlign.Center).fontSize(14).fontColor(0xFF5E6C84)
                    .onClick({ _: ClickEvent => Router.push(url: "EventsPage") })

                Text("我的")
                    .layoutWeight(1).height(40).textAlign(TextAlign.Center).fontSize(14).fontWeight(FontWeight.Bold).fontColor(0xFF2F80FF)
            }
            .width(100.percent)
            .padding(left: 10, right: 10, top: 10, bottom: 16)
            .backgroundColor(0xFFFFFFFF)
        }
        .width(100.percent)
        .height(100.percent)
        .backgroundColor(0xFFF4F8FF)
    }
}