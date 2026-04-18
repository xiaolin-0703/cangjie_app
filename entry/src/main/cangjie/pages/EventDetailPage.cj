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
class EventDetailPage {
    @State var eventId: String = ""
    @State var title: String = "活动详情"
    @State var timeText: String = "时间待定"
    @State var location: String = "地点待定"
    @State var statusText: String = "正在报名中"
    @State var description: String = "暂无活动描述"
    @State var capacityText: String = "人数待定"
    @State var deadlineText: String = "截止时间待定"

    @State var loading: Bool = false
    @State var registerSuccess: Bool = false
    @State var errorMsg: String = ""

    public func aboutToAppear(): Unit {
        this.eventId = EventService.getCurrentEventId()
        this.title = EventService.getCurrentEventTitle()
        this.timeText = EventService.getCurrentEventTimeText()
        this.location = EventService.getCurrentEventLocation()
        this.statusText = EventService.getCurrentEventStatusText()
        this.description = EventService.getCurrentEventDescription()
        this.capacityText = EventService.getCurrentEventCapacityText()
        this.deadlineText = EventService.getCurrentEventDeadlineText()
    }

    func getRegisterButtonText(): String {
        if (this.loading) {
            return "报名中..."
        }
        if (this.registerSuccess) {
            return "已报名"
        }
        return "立即报名"
    }

    func build() {
        Column {
            Column {
                Row {
                    Column {
                        Text("活动详情")
                            .fontSize(28)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFF222222)
                            .margin(bottom: 6)

                        Text("查看活动信息，决定是否报名参加")
                            .fontSize(14)
                            .fontColor(0xFF666666)
                    }
                    .layoutWeight(1)

                    Text("详情")
                        .fontSize(13)
                        .fontColor(0xFFFF7A45)
                        .backgroundColor(0xFFFFFFFF)
                        .padding(left: 14, right: 14, top: 8, bottom: 8)
                        .borderRadius(18)
                }
                .width(100.percent)
                .margin(bottom: 16)

                Row {
                    Button("返回广场")
                        .layoutWeight(1)
                        .height(40)
                        .backgroundColor(0xFFFFFFFF)
                        .fontColor(0xFFFF7A45)
                        .borderRadius(20)
                        .margin(right: 8)
                        .onClick({ =>
                            Router.push(url: "EventsPage")
                        })

                    Button("发起活动")
                        .layoutWeight(1)
                        .height(40)
                        .backgroundColor(0xFFFF7A45)
                        .fontColor(0xFFFFFFFF)
                        .borderRadius(20)
                        .onClick({ =>
                            Router.push(url: "CreateEventPage")
                        })
                }
                .width(100.percent)
            }
            .width(100.percent)
            .padding(left: 16, right: 16, top: 24, bottom: 20)
            .backgroundColor(0xFFFFF3EE)

            Scroll {
                Column {
                    Column {
                        Row {
                            Column {
                                Text(this.title)
                                    .fontSize(22)
                                    .fontWeight(FontWeight.Bold)
                                    .fontColor(0xFF222222)
                                    .margin(bottom: 8)

                                Text(this.timeText)
                                    .fontSize(14)
                                    .fontColor(0xFF666666)
                                    .margin(bottom: 4)

                                Text(this.location)
                                    .fontSize(14)
                                    .fontColor(0xFF666666)
                            }
                            .layoutWeight(1)

                            Text("活动")
                                .fontSize(11)
                                .fontColor(0xFFFFFFFF)
                                .backgroundColor(0xFFFF7A45)
                                .padding(left: 10, right: 10, top: 6, bottom: 6)
                                .borderRadius(12)
                        }
                        .width(100.percent)
                        .margin(bottom: 12)

                        Text(this.statusText)
                            .fontSize(12)
                            .fontColor(0xFFFF7A45)
                            .margin(bottom: 16)

                        Row {
                            Column {
                                Text("人数上限")
                                    .fontSize(12)
                                    .fontColor(0xFF999999)
                                    .margin(bottom: 6)

                                Text(this.capacityText)
                                    .fontSize(16)
                                    .fontWeight(FontWeight.Bold)
                                    .fontColor(0xFF222222)
                            }
                            .layoutWeight(1)

                            Column {
                                Text("报名截止")
                                    .fontSize(12)
                                    .fontColor(0xFF999999)
                                    .margin(bottom: 6)

                                Text(this.deadlineText)
                                    .fontSize(16)
                                    .fontWeight(FontWeight.Bold)
                                    .fontColor(0xFF222222)
                            }
                            .layoutWeight(1)
                        }
                        .width(100.percent)
                        .margin(bottom: 16)

                        Text("活动介绍")
                            .fontSize(18)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFF222222)
                            .margin(bottom: 10)

                        Text(this.description)
                            .fontSize(14)
                            .fontColor(0xFF666666)
                            .lineHeight(22)
                            .margin(bottom: 20)

                        Button(this.getRegisterButtonText())
                            .width(100.percent)
                            .height(42)
                            .enabled(!this.loading && !this.registerSuccess)
                            .backgroundColor(0xFFFF7A45)
                            .fontColor(0xFFFFFFFF)
                            .borderRadius(14)
                            .onClick({ =>
                                if (this.eventId == "") {
                                    this.errorMsg = "活动 ID 缺失，无法报名"
                                    return
                                }

                                this.loading = true
                                this.errorMsg = ""

                                EventService.registerEvent(
                                    this.eventId,
                                    { _: String =>
                                        this.loading = false
                                        this.registerSuccess = true
                                        this.statusText = "报名成功"
                                    },
                                    { msg: String =>
                                        this.loading = false
                                        this.errorMsg = msg
                                    }
                                )
                            })
                    }
                    .width(100.percent)
                    .padding(18)
                    .backgroundColor(0xFFFFFFFF)
                    .borderRadius(18)
                    .margin(bottom: 12)
                    Button("查看报名名单")
    .width(100.percent)
    .height(42)
    .backgroundColor(0xFFFFF1EA)
    .fontColor(0xFFFF7A45)
    .borderRadius(14)
    .margin(top: 12)
    .onClick({ =>
        Router.push(url: "RegistrationListPage")
    })

                    if (this.registerSuccess) {
                        Column {
                            Text("报名成功")
                                .fontSize(18)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF2E9B4B)
                                .margin(bottom: 8)

                            Text("你已经成功报名这个活动，后续可以在活动广场查看。")
                                .fontSize(13)
                                .fontColor(0xFF666666)
                        }
                        .width(100.percent)
                        .padding(16)
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