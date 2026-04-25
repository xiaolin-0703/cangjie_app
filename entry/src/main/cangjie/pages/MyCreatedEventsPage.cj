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
class MyCreatedEventsPage {
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
    @State var event1RegisteredText: String = ""

    @State var event2Id: String = ""
    @State var event2Title: String = ""
    @State var event2Time: String = ""
    @State var event2Location: String = ""
    @State var event2Status: String = ""
    @State var event2Description: String = ""
    @State var event2CapacityText: String = ""
    @State var event2DeadlineText: String = ""
    @State var event2RegisteredText: String = ""

    @State var event3Id: String = ""
    @State var event3Title: String = ""
    @State var event3Time: String = ""
    @State var event3Location: String = ""
    @State var event3Status: String = ""
    @State var event3Description: String = ""
    @State var event3CapacityText: String = ""
    @State var event3DeadlineText: String = ""
    @State var event3RegisteredText: String = ""

    public func aboutToAppear(): Unit {
        if (!this.firstLoaded && !this.loading) {
            this.loadCreatedEvents()
        }
    }

    func getRefreshButtonText(): String {
        if (this.loading) {
            return "刷新中..."
        }
        return "刷新列表"
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
        this.event1RegisteredText = ""

        this.event2Id = ""
        this.event2Title = ""
        this.event2Time = ""
        this.event2Location = ""
        this.event2Status = ""
        this.event2Description = ""
        this.event2CapacityText = ""
        this.event2DeadlineText = ""
        this.event2RegisteredText = ""

        this.event3Id = ""
        this.event3Title = ""
        this.event3Time = ""
        this.event3Location = ""
        this.event3Status = ""
        this.event3Description = ""
        this.event3CapacityText = ""
        this.event3DeadlineText = ""
        this.event3RegisteredText = ""
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

    func formatRegisteredText(raw: String): String {
        if (raw == "") {
            return "已报名 0 人"
        }
        return "已报名 ${raw} 人"
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
        this.event1RegisteredText = this.formatRegisteredText(
            EventService.extractEventField(raw, 0, "registeredCount")
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
        this.event2RegisteredText = this.formatRegisteredText(
            EventService.extractEventField(raw, 1, "registeredCount")
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
        this.event3RegisteredText = this.formatRegisteredText(
            EventService.extractEventField(raw, 2, "registeredCount")
        )
    }

    func loadCreatedEvents() {
        this.loading = true
        this.errorMsg = ""

        EventService.getCreatedByMeEvents(
            { raw: String =>
                print(raw)
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

    func goToDetail(
        eventId: String,
        title: String,
        timeText: String,
        location: String,
        statusText: String,
        description: String,
        capacityText: String,
        deadlineText: String
    ) {
        EventService.setCurrentEventDetail(
            eventId,
            title,
            timeText,
            location,
            statusText,
            description,
            capacityText,
            deadlineText
        )
        Router.push(url: "EventDetailPage")
    }

    func build() {
        Column {
            // 顶部区域
            Column {
                Row {
                    Column {
                        Text("我发起的活动")
                            .fontSize(28)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFF24324A)
                            .margin(bottom: 6)

                        Text("查看你创建的活动，以及当前报名人数")
                            .fontSize(14)
                            .fontColor(0xFF6D7B99)
                    }
                    .layoutWeight(1)

                    Text("我的")
                        .fontSize(13)
                        .fontColor(0xFF2F80FF)
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
                        .fontColor(0xFF2F80FF)
                        .borderRadius(20)
                        .margin(right: 8)
                        .onClick({ =>
                            Router.push(url: "HomePage")
                        })

                    Button("发起活动")
                        .layoutWeight(1)
                        .height(40)
                        .backgroundColor(0xFF2F80FF)
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
            .backgroundColor(0xFFEAF2FF)

            Scroll {
                Column {
                    Row {
                        Text("我的活动")
                            .fontSize(20)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFF24324A)

                        Button(this.getRefreshButtonText())
                            .height(32)
                            .backgroundColor(0xFFEAF2FF)
                            .fontColor(0xFF2F80FF)
                            .borderRadius(16)
                            .enabled(!this.loading)
                            .onClick({ =>
                                this.loadCreatedEvents()
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
                            Text("正在加载活动...")
                                .fontSize(18)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF24324A)
                                .margin(bottom: 10)

                            Text("稍等一下，你创建的活动马上就来。")
                                .fontSize(13)
                                .fontColor(0xFF7E8CA8)
                        }
                        .width(100.percent)
                        .padding(18)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 12)
                    } else if (!this.hasAnyEvent()) {
                        Column {
                            Text("你还没有创建活动")
                                .fontSize(20)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF24324A)
                                .margin(bottom: 10)

                            Text("去发起你的第一个活动吧。")
                                .fontSize(13)
                                .fontColor(0xFF7E8CA8)
                                .margin(bottom: 16)

                            Button("去发起活动")
                                .width(100.percent)
                                .height(42)
                                .backgroundColor(0xFF2F80FF)
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
                                            .fontColor(0xFF24324A)
                                            .margin(bottom: 8)

                                        Text(this.event1Time)
                                            .fontSize(13)
                                            .fontColor(0xFF6D7B99)
                                            .margin(bottom: 4)

                                        Text(this.event1Location)
                                            .fontSize(13)
                                            .fontColor(0xFF6D7B99)
                                    }
                                    .layoutWeight(1)

                                    Text("我发起的")
                                        .fontSize(11)
                                        .fontColor(0xFFFFFFFF)
                                        .backgroundColor(0xFF2F80FF)
                                        .padding(left: 10, right: 10, top: 6, bottom: 6)
                                        .borderRadius(12)
                                }
                                .width(100.percent)
                                .margin(bottom: 10)

                                Text(this.event1Status)
                                    .fontSize(12)
                                    .fontColor(0xFF2F80FF)
                                    .margin(bottom: 6)

                                Text(this.event1RegisteredText)
                                    .fontSize(12)
                                    .fontColor(0xFF7E8CA8)
                                    .margin(bottom: 14)

                                Button("查看详情")
                                    .width(100.percent)
                                    .height(42)
                                    .backgroundColor(0xFF2F80FF)
                                    .fontColor(0xFFFFFFFF)
                                    .borderRadius(14)
                                    .onClick({ =>
                                        this.goToDetail(
                                            this.event1Id,
                                            this.event1Title,
                                            this.event1Time,
                                            this.event1Location,
                                            this.event1Status,
                                            this.event1Description,
                                            this.event1CapacityText,
                                            this.event1DeadlineText
                                        )
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
                                            .fontColor(0xFF24324A)
                                            .margin(bottom: 8)

                                        Text(this.event2Time)
                                            .fontSize(13)
                                            .fontColor(0xFF6D7B99)
                                            .margin(bottom: 4)

                                        Text(this.event2Location)
                                            .fontSize(13)
                                            .fontColor(0xFF6D7B99)
                                    }
                                    .layoutWeight(1)

                                    Text("我发起的")
                                        .fontSize(11)
                                        .fontColor(0xFFFFFFFF)
                                        .backgroundColor(0xFF2F80FF)
                                        .padding(left: 10, right: 10, top: 6, bottom: 6)
                                        .borderRadius(12)
                                }
                                .width(100.percent)
                                .margin(bottom: 10)

                                Text(this.event2Status)
                                    .fontSize(12)
                                    .fontColor(0xFF2F80FF)
                                    .margin(bottom: 6)

                                Text(this.event2RegisteredText)
                                    .fontSize(12)
                                    .fontColor(0xFF7E8CA8)
                                    .margin(bottom: 14)

                                Button("查看详情")
                                    .width(100.percent)
                                    .height(42)
                                    .backgroundColor(0xFF2F80FF)
                                    .fontColor(0xFFFFFFFF)
                                    .borderRadius(14)
                                    .onClick({ =>
                                        this.goToDetail(
                                            this.event2Id,
                                            this.event2Title,
                                            this.event2Time,
                                            this.event2Location,
                                            this.event2Status,
                                            this.event2Description,
                                            this.event2CapacityText,
                                            this.event2DeadlineText
                                        )
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
                                            .fontColor(0xFF24324A)
                                            .margin(bottom: 8)

                                        Text(this.event3Time)
                                            .fontSize(13)
                                            .fontColor(0xFF6D7B99)
                                            .margin(bottom: 4)

                                        Text(this.event3Location)
                                            .fontSize(13)
                                            .fontColor(0xFF6D7B99)
                                    }
                                    .layoutWeight(1)

                                    Text("我发起的")
                                        .fontSize(11)
                                        .fontColor(0xFFFFFFFF)
                                        .backgroundColor(0xFF2F80FF)
                                        .padding(left: 10, right: 10, top: 6, bottom: 6)
                                        .borderRadius(12)
                                }
                                .width(100.percent)
                                .margin(bottom: 10)

                                Text(this.event3Status)
                                    .fontSize(12)
                                    .fontColor(0xFF2F80FF)
                                    .margin(bottom: 6)

                                Text(this.event3RegisteredText)
                                    .fontSize(12)
                                    .fontColor(0xFF7E8CA8)
                                    .margin(bottom: 14)

                                Button("查看详情")
                                    .width(100.percent)
                                    .height(42)
                                    .backgroundColor(0xFF2F80FF)
                                    .fontColor(0xFFFFFFFF)
                                    .borderRadius(14)
                                    .onClick({ =>
                                        this.goToDetail(
                                            this.event3Id,
                                            this.event3Title,
                                            this.event3Time,
                                            this.event3Location,
                                            this.event3Status,
                                            this.event3Description,
                                            this.event3CapacityText,
                                            this.event3DeadlineText
                                        )
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
        .backgroundColor(0xFFF4F8FF)
    }
}