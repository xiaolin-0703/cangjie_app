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
class EventsPage {
    @State var loading: Bool = false
    @State var firstLoaded: Bool = false
    @State var errorMsg: String = ""

    @State var event1Id: String = ""
    @State var event1Title: String = ""
    @State var event1Time: String = ""
    @State var event1Location: String = ""
    @State var event1Status: String = ""
    @State var event1Description: String = ""
    @State var event1CapacityText: String = ""
    @State var event1DeadlineText: String = ""

    @State var event2Id: String = ""
    @State var event2Title: String = ""
    @State var event2Time: String = ""
    @State var event2Location: String = ""
    @State var event2Status: String = ""
    @State var event2Description: String = ""
    @State var event2CapacityText: String = ""
    @State var event2DeadlineText: String = ""

    @State var event3Id: String = ""
    @State var event3Title: String = ""
    @State var event3Time: String = ""
    @State var event3Location: String = ""
    @State var event3Status: String = ""
    @State var event3Description: String = ""
    @State var event3CapacityText: String = ""
    @State var event3DeadlineText: String = ""

    public func aboutToAppear(): Unit {
        if (!this.firstLoaded && !this.loading) {
            this.loadEvents()
        }
    }

    func getRefreshButtonText(): String {
        if (this.loading) {
            return "刷新中..."
        }
        return "刷新活动"
    }

    func hasAnyEvent(): Bool {
        return this.event1Title != "" || this.event2Title != "" || this.event3Title != ""
    }

    func clearEvents() {
        this.event1Id = ""
        this.event1Title = ""
        this.event1Time = ""
        this.event1Location = ""
        this.event1Status = ""
        this.event1Description = ""
        this.event1CapacityText = ""
        this.event1DeadlineText = ""

        this.event2Id = ""
        this.event2Title = ""
        this.event2Time = ""
        this.event2Location = ""
        this.event2Status = ""
        this.event2Description = ""
        this.event2CapacityText = ""
        this.event2DeadlineText = ""

        this.event3Id = ""
        this.event3Title = ""
        this.event3Time = ""
        this.event3Location = ""
        this.event3Status = ""
        this.event3Description = ""
        this.event3CapacityText = ""
        this.event3DeadlineText = ""
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
            return "正在报名中"
        }
        return status
    }

    func formatCapacityText(raw: String): String {
        if (raw == "") {
            return "人数待定"
        }
        return "${raw}人"
    }

    func formatDeadlineText(raw: String): String {
        if (raw == "") {
            return "截止时间待定"
        }
        return raw
    }

    func fillEvents(raw: String) {
        this.clearEvents()

        this.event1Id = EventService.extractEventField(raw, 0, "id")
        this.event1Title = EventService.extractEventField(raw, 0, "title")
        this.event1Time = EventService.extractEventField(raw, 0, "startTimeText")
        this.event1Location = EventService.extractEventField(raw, 0, "location")
        this.event1Status = this.normalizeStatusText(
            EventService.extractEventField(raw, 0, "status")
        )
        this.event1Description = EventService.extractEventField(raw, 0, "description")
        this.event1CapacityText = this.formatCapacityText(
            EventService.extractEventField(raw, 0, "capacity")
        )
        this.event1DeadlineText = this.formatDeadlineText(
            EventService.extractEventField(raw, 0, "signupDeadline")
        )

        this.event2Id = EventService.extractEventField(raw, 1, "id")
        this.event2Title = EventService.extractEventField(raw, 1, "title")
        this.event2Time = EventService.extractEventField(raw, 1, "startTimeText")
        this.event2Location = EventService.extractEventField(raw, 1, "location")
        this.event2Status = this.normalizeStatusText(
            EventService.extractEventField(raw, 1, "status")
        )
        this.event2Description = EventService.extractEventField(raw, 1, "description")
        this.event2CapacityText = this.formatCapacityText(
            EventService.extractEventField(raw, 1, "capacity")
        )
        this.event2DeadlineText = this.formatDeadlineText(
            EventService.extractEventField(raw, 1, "signupDeadline")
        )

        this.event3Id = EventService.extractEventField(raw, 2, "id")
        this.event3Title = EventService.extractEventField(raw, 2, "title")
        this.event3Time = EventService.extractEventField(raw, 2, "startTimeText")
        this.event3Location = EventService.extractEventField(raw, 2, "location")
        this.event3Status = this.normalizeStatusText(
            EventService.extractEventField(raw, 2, "status")
        )
        this.event3Description = EventService.extractEventField(raw, 2, "description")
        this.event3CapacityText = this.formatCapacityText(
            EventService.extractEventField(raw, 2, "capacity")
        )
        this.event3DeadlineText = this.formatDeadlineText(
            EventService.extractEventField(raw, 2, "signupDeadline")
        )
    }

    func loadEvents() {
        this.loading = true
        this.errorMsg = ""

        EventService.getFeaturedEvents(
            { raw: String =>
                print(raw)
                print("event1Id after parse = " + EventService.extractEventField(raw, 0, "id"))
                this.fillEvents(raw)
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
                        Text("活动广场")
                            .fontSize(28)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFF222222)
                            .margin(bottom: 6)

                        Text("查看最新发布的活动，找到你感兴趣的局")
                            .fontSize(14)
                            .fontColor(0xFF666666)
                    }
                    .layoutWeight(1)

                    Text("广场")
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
                    Row {
                        Text("最新活动")
                            .fontSize(20)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFF222222)

                        Button(this.getRefreshButtonText())
                            .height(32)
                            .backgroundColor(0xFFFFF1EA)
                            .fontColor(0xFFFF7A45)
                            .borderRadius(16)
                            .enabled(!this.loading)
                            .onClick({ =>
                                this.loadEvents()
                            })
                    }
                    .width(100.percent)
                    .justifyContent(FlexAlign.SpaceBetween)
                    .alignItems(VerticalAlign.Center)
                    .margin(top: 4, bottom: 12)

                    if (this.errorMsg != "") {
                        Column {
                            Text("加载失败")
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

                    if (!this.firstLoaded && this.loading) {
                        Column {
                            Text("正在加载活动...")
                                .fontSize(18)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF222222)
                                .margin(bottom: 10)

                            Text("稍等一下，活动列表马上就来。")
                                .fontSize(13)
                                .fontColor(0xFF777777)
                        }
                        .width(100.percent)
                        .padding(18)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 12)
                    } else if (!this.hasAnyEvent()) {
                        Column {
                            Text("暂时还没有活动")
                                .fontSize(20)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF222222)
                                .margin(bottom: 10)

                            Text("你可以先发起一个活动，创建成功后它会显示在这里。")
                                .fontSize(13)
                                .fontColor(0xFF777777)
                                .margin(bottom: 16)

                            Button("去发起活动")
                                .width(100.percent)
                                .height(42)
                                .backgroundColor(0xFFFF7A45)
                                .fontColor(0xFFFFFFFF)
                                .borderRadius(14)
                                .onClick({ =>
                                    Router.push(url: "CreateEventPage")
                                })
                        }
                        .width(100.percent)
                        .padding(18)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 12)
                    } else {
                        if (this.event1Title != "") {
                            Column {
                                Row {
                                    Column {
                                        Text(this.event1Title)
                                            .fontSize(18)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFF222222)
                                            .margin(bottom: 8)

                                        Text(this.event1Time)
                                            .fontSize(13)
                                            .fontColor(0xFF666666)
                                            .margin(bottom: 4)

                                        Text(this.event1Location)
                                            .fontSize(13)
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
                                .margin(bottom: 10)

                                Text(this.event1Status)
                                    .fontSize(12)
                                    .fontColor(0xFFFF7A45)
                                    .margin(bottom: 14)

                                Button("查看详情")
                                    .width(100.percent)
                                    .height(42)
                                    .backgroundColor(0xFFFF7A45)
                                    .fontColor(0xFFFFFFFF)
                                    .borderRadius(14)
                                    .onClick({ =>
                                        print("event1Id before detail = " + this.event1Id)
                                        EventService.setCurrentEventDetail(
                                            this.event1Id,
                                            this.event1Title,
                                            this.event1Time,
                                            this.event1Location,
                                            this.event1Status,
                                            this.event1Description,
                                            this.event1CapacityText,
                                            this.event1DeadlineText
                                        )
                                        Router.push(url: "EventDetailPage")
                                    })
                            }
                            .width(100.percent)
                            .padding(16)
                            .backgroundColor(0xFFFFFFFF)
                            .borderRadius(18)
                            .margin(bottom: 12)
                        }

                        if (this.event2Title != "") {
                            Column {
                                Row {
                                    Column {
                                        Text(this.event2Title)
                                            .fontSize(18)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFF222222)
                                            .margin(bottom: 8)

                                        Text(this.event2Time)
                                            .fontSize(13)
                                            .fontColor(0xFF666666)
                                            .margin(bottom: 4)

                                        Text(this.event2Location)
                                            .fontSize(13)
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
                                .margin(bottom: 10)

                                Text(this.event2Status)
                                    .fontSize(12)
                                    .fontColor(0xFFFF7A45)
                                    .margin(bottom: 14)

                                Button("查看详情")
                                    .width(100.percent)
                                    .height(42)
                                    .backgroundColor(0xFFFF7A45)
                                    .fontColor(0xFFFFFFFF)
                                    .borderRadius(14)
                                    .onClick({ =>
                                        EventService.setCurrentEventDetail(
                                            this.event2Id,
                                            this.event2Title,
                                            this.event2Time,
                                            this.event2Location,
                                            this.event2Status,
                                            this.event2Description,
                                            this.event2CapacityText,
                                            this.event2DeadlineText
                                        )
                                        Router.push(url: "EventDetailPage")
                                    })
                            }
                            .width(100.percent)
                            .padding(16)
                            .backgroundColor(0xFFFFFFFF)
                            .borderRadius(18)
                            .margin(bottom: 12)
                        }

                        if (this.event3Title != "") {
                            Column {
                                Row {
                                    Column {
                                        Text(this.event3Title)
                                            .fontSize(18)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFF222222)
                                            .margin(bottom: 8)

                                        Text(this.event3Time)
                                            .fontSize(13)
                                            .fontColor(0xFF666666)
                                            .margin(bottom: 4)

                                        Text(this.event3Location)
                                            .fontSize(13)
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
                                .margin(bottom: 10)

                                Text(this.event3Status)
                                    .fontSize(12)
                                    .fontColor(0xFFFF7A45)
                                    .margin(bottom: 14)

                                Button("查看详情")
                                    .width(100.percent)
                                    .height(42)
                                    .backgroundColor(0xFFFF7A45)
                                    .fontColor(0xFFFFFFFF)
                                    .borderRadius(14)
                                    .onClick({ =>
                                        EventService.setCurrentEventDetail(
                                            this.event3Id,
                                            this.event3Title,
                                            this.event3Time,
                                            this.event3Location,
                                            this.event3Status,
                                            this.event3Description,
                                            this.event3CapacityText,
                                            this.event3DeadlineText
                                        )
                                        Router.push(url: "EventDetailPage")
                                    })
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
        .backgroundColor(0xFFF7F8FA)
    }
}