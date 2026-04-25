package ohos_app_cangjie_entry.pages

internal import ohos.base.LengthProp
import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.router.*
import ohos_app_cangjie_entry.service.EventService

@Entry
@Component
class RegistrationListPage {
    @State var eventId: String = ""
    @State var eventTitle: String = "报名名单"

    @State var loading: Bool = false
    @State var firstLoaded: Bool = false
    @State var errorMsg: String = ""

    @State var reg1Name: String = ""
    @State var reg1Meta: String = ""
    @State var reg1Email: String = ""

    @State var reg2Name: String = ""
    @State var reg2Meta: String = ""
    @State var reg2Email: String = ""

    @State var reg3Name: String = ""
    @State var reg3Meta: String = ""
    @State var reg3Email: String = ""

    @State var reg4Name: String = ""
    @State var reg4Meta: String = ""
    @State var reg4Email: String = ""

    @State var reg5Name: String = ""
    @State var reg5Meta: String = ""
    @State var reg5Email: String = ""

    public func aboutToAppear(): Unit {
        this.eventId = EventService.getCurrentEventId()
        this.eventTitle = EventService.getCurrentEventTitle()

        if (!this.firstLoaded && !this.loading) {
            this.loadRegistrations()
        }
    }

    func getRefreshButtonText(): String {
        if (this.loading) {
            return "刷新中..."
        }
        return "刷新名单"
    }

    func clearList() {
        this.reg1Name = ""
        this.reg1Meta = ""
        this.reg1Email = ""

        this.reg2Name = ""
        this.reg2Meta = ""
        this.reg2Email = ""

        this.reg3Name = ""
        this.reg3Meta = ""
        this.reg3Email = ""

        this.reg4Name = ""
        this.reg4Meta = ""
        this.reg4Email = ""

        this.reg5Name = ""
        this.reg5Meta = ""
        this.reg5Email = ""
    }

    func hasAnyRegistration(): Bool {
        return this.reg1Name != "" ||
            this.reg2Name != "" ||
            this.reg3Name != "" ||
            this.reg4Name != "" ||
            this.reg5Name != ""
    }

    func buildMeta(grade: String, department: String): String {
        if (grade != "" && department != "") {
            return "${department} · ${grade}"
        }
        if (department != "") {
            return department
        }
        if (grade != "") {
            return grade
        }
        return "暂未填写"
    }

    func pickName(nickname: String, realName: String, email: String): String {
        if (nickname != "") {
            return nickname
        }
        if (realName != "") {
            return realName
        }
        if (email != "") {
            return email
        }
        return "匿名用户"
    }

    func fillRegistrations(raw: String) {
        this.clearList()

        this.reg1Name = this.pickName(
            EventService.extractRegistrationField(raw, 0, "nickname"),
            EventService.extractRegistrationField(raw, 0, "realName"),
            EventService.extractRegistrationField(raw, 0, "email")
        )
        this.reg1Meta = this.buildMeta(
            EventService.extractRegistrationField(raw, 0, "grade"),
            EventService.extractRegistrationField(raw, 0, "department")
        )
        this.reg1Email = EventService.extractRegistrationField(raw, 0, "email")

        this.reg2Name = this.pickName(
            EventService.extractRegistrationField(raw, 1, "nickname"),
            EventService.extractRegistrationField(raw, 1, "realName"),
            EventService.extractRegistrationField(raw, 1, "email")
        )
        this.reg2Meta = this.buildMeta(
            EventService.extractRegistrationField(raw, 1, "grade"),
            EventService.extractRegistrationField(raw, 1, "department")
        )
        this.reg2Email = EventService.extractRegistrationField(raw, 1, "email")

        this.reg3Name = this.pickName(
            EventService.extractRegistrationField(raw, 2, "nickname"),
            EventService.extractRegistrationField(raw, 2, "realName"),
            EventService.extractRegistrationField(raw, 2, "email")
        )
        this.reg3Meta = this.buildMeta(
            EventService.extractRegistrationField(raw, 2, "grade"),
            EventService.extractRegistrationField(raw, 2, "department")
        )
        this.reg3Email = EventService.extractRegistrationField(raw, 2, "email")

        this.reg4Name = this.pickName(
            EventService.extractRegistrationField(raw, 3, "nickname"),
            EventService.extractRegistrationField(raw, 3, "realName"),
            EventService.extractRegistrationField(raw, 3, "email")
        )
        this.reg4Meta = this.buildMeta(
            EventService.extractRegistrationField(raw, 3, "grade"),
            EventService.extractRegistrationField(raw, 3, "department")
        )
        this.reg4Email = EventService.extractRegistrationField(raw, 3, "email")

        this.reg5Name = this.pickName(
            EventService.extractRegistrationField(raw, 4, "nickname"),
            EventService.extractRegistrationField(raw, 4, "realName"),
            EventService.extractRegistrationField(raw, 4, "email")
        )
        this.reg5Meta = this.buildMeta(
            EventService.extractRegistrationField(raw, 4, "grade"),
            EventService.extractRegistrationField(raw, 4, "department")
        )
        this.reg5Email = EventService.extractRegistrationField(raw, 4, "email")
    }

    func loadRegistrations() {
        if (this.eventId == "") {
            this.errorMsg = "活动 ID 缺失，无法查看报名名单"
            this.firstLoaded = true
            return
        }

        this.loading = true
        this.errorMsg = ""

        EventService.getEventRegistrations(
            this.eventId,
            { raw: String =>
                print(raw)
                this.fillRegistrations(raw)
                this.loading = false
                this.firstLoaded = true
            },
            { msg: String =>
                this.loading = false
                this.firstLoaded = true
                this.errorMsg = msg
            }
        )
    }

    func build() {
        Column {
            Column {
                Row {
                    Column {
                        Text("报名名单")
                            .fontSize(28)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFF24324A)
                            .margin(bottom: 6)

                        Text(this.eventTitle)
                            .fontSize(14)
                            .fontColor(0xFF6D7B99)
                    }
                    .layoutWeight(1)

                    Text("名单")
                        .fontSize(13)
                        .fontColor(0xFF2F80FF)
                        .backgroundColor(0xFFFFFFFF)
                        .padding(left: 14, right: 14, top: 8, bottom: 8)
                        .borderRadius(18)
                }
                .width(100.percent)
                .margin(bottom: 16)

                Row {
                    Button("返回详情")
                        .layoutWeight(1)
                        .height(40)
                        .backgroundColor(0xFFFFFFFF)
                        .fontColor(0xFF2F80FF)
                        .borderRadius(20)
                        .margin(right: 8)
                        .onClick({ =>
                            Router.push(url: "EventDetailPage")
                        })

                    Button(this.getRefreshButtonText())
                        .layoutWeight(1)
                        .height(40)
                        .backgroundColor(0xFF2F80FF)
                        .fontColor(0xFFFFFFFF)
                        .borderRadius(20)
                        .enabled(!this.loading)
                        .onClick({ =>
                            this.loadRegistrations()
                        })
                }
                .width(100.percent)
            }
            .width(100.percent)
            .padding(left: 16, right: 16, top: 24, bottom: 20)
            .backgroundColor(0xFFEAF2FF)

            Scroll {
                Column {
                    if (this.errorMsg != "") {
                        Column {
                            Text("加载失败")
                                .fontSize(18)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF24324A)
                                .margin(bottom: 8)

                            Text(this.errorMsg)
                                .fontSize(13)
                                .fontColor(0xFFE96B6B)
                        }
                        .width(100.percent)
                        .padding(16)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 12)
                    }

                    if (!this.firstLoaded && this.loading) {
                        Column {
                            Text("正在加载名单...")
                                .fontSize(18)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF24324A)
                                .margin(bottom: 10)

                            Text("稍等一下，报名名单马上就来。")
                                .fontSize(13)
                                .fontColor(0xFF7E8CA8)
                        }
                        .width(100.percent)
                        .padding(18)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 12)
                    } else if (!this.hasAnyRegistration()) {
                        Column {
                            Text("暂时还没有报名用户")
                                .fontSize(20)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF24324A)
                                .margin(bottom: 10)

                            Text("当前还没有人报名这个活动。")
                                .fontSize(13)
                                .fontColor(0xFF7E8CA8)
                        }
                        .width(100.percent)
                        .padding(18)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 12)
                    } else {
                        if (this.reg1Name != "") {
                            Column {
                                Text(this.reg1Name)
                                    .fontSize(18)
                                    .fontWeight(FontWeight.Bold)
                                    .fontColor(0xFF24324A)
                                    .margin(bottom: 6)

                                Text(this.reg1Meta)
                                    .fontSize(13)
                                    .fontColor(0xFF7E8CA8)
                                    .margin(bottom: 6)

                                Text(this.reg1Email)
                                    .fontSize(12)
                                    .fontColor(0xFF2F80FF)
                            }
                            .width(100.percent)
                            .padding(16)
                            .backgroundColor(0xFFFFFFFF)
                            .borderRadius(18)
                            .margin(bottom: 12)
                        }

                        if (this.reg2Name != "") {
                            Column {
                                Text(this.reg2Name)
                                    .fontSize(18)
                                    .fontWeight(FontWeight.Bold)
                                    .fontColor(0xFF24324A)
                                    .margin(bottom: 6)

                                Text(this.reg2Meta)
                                    .fontSize(13)
                                    .fontColor(0xFF7E8CA8)
                                    .margin(bottom: 6)

                                Text(this.reg2Email)
                                    .fontSize(12)
                                    .fontColor(0xFF2F80FF)
                            }
                            .width(100.percent)
                            .padding(16)
                            .backgroundColor(0xFFFFFFFF)
                            .borderRadius(18)
                            .margin(bottom: 12)
                        }

                        if (this.reg3Name != "") {
                            Column {
                                Text(this.reg3Name)
                                    .fontSize(18)
                                    .fontWeight(FontWeight.Bold)
                                    .fontColor(0xFF24324A)
                                    .margin(bottom: 6)

                                Text(this.reg3Meta)
                                    .fontSize(13)
                                    .fontColor(0xFF7E8CA8)
                                    .margin(bottom: 6)

                                Text(this.reg3Email)
                                    .fontSize(12)
                                    .fontColor(0xFF2F80FF)
                            }
                            .width(100.percent)
                            .padding(16)
                            .backgroundColor(0xFFFFFFFF)
                            .borderRadius(18)
                            .margin(bottom: 12)
                        }

                        if (this.reg4Name != "") {
                            Column {
                                Text(this.reg4Name)
                                    .fontSize(18)
                                    .fontWeight(FontWeight.Bold)
                                    .fontColor(0xFF24324A)
                                    .margin(bottom: 6)

                                Text(this.reg4Meta)
                                    .fontSize(13)
                                    .fontColor(0xFF7E8CA8)
                                    .margin(bottom: 6)

                                Text(this.reg4Email)
                                    .fontSize(12)
                                    .fontColor(0xFF2F80FF)
                            }
                            .width(100.percent)
                            .padding(16)
                            .backgroundColor(0xFFFFFFFF)
                            .borderRadius(18)
                            .margin(bottom: 12)
                        }

                        if (this.reg5Name != "") {
                            Column {
                                Text(this.reg5Name)
                                    .fontSize(18)
                                    .fontWeight(FontWeight.Bold)
                                    .fontColor(0xFF24324A)
                                    .margin(bottom: 6)

                                Text(this.reg5Meta)
                                    .fontSize(13)
                                    .fontColor(0xFF7E8CA8)
                                    .margin(bottom: 6)

                                Text(this.reg5Email)
                                    .fontSize(12)
                                    .fontColor(0xFF2F80FF)
                            }
                            .width(100.percent)
                            .padding(16)
                            .backgroundColor(0xFFFFFFFF)
                            .borderRadius(18)
                            .margin(bottom: 12)
                        }
                    }
                }
                .width(100.percent)
                .padding(left: 16, right: 16, top: 16, bottom: 20)
            }
            .layoutWeight(1)
        }
        .width(100.percent)
        .height(100.percent)
        .backgroundColor(0xFFF4F8FF)
    }
}