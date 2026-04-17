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
    @State var errorMsg: String = ""

    @State var event1Title: String = ""
    @State var event1Time: String = ""
    @State var event1Location: String = ""
    @State var event1Status: String = ""

    @State var event2Title: String = ""
    @State var event2Time: String = ""
    @State var event2Location: String = ""
    @State var event2Status: String = ""

    @State var event3Title: String = ""
    @State var event3Time: String = ""
    @State var event3Location: String = ""
    @State var event3Status: String = ""

    func getRefreshButtonText(): String {
        if (this.loading) {
            return "刷新中..."
        }
        return "刷新活动"
    }

    func clearEvents() {
        this.event1Title = ""
        this.event1Time = ""
        this.event1Location = ""
        this.event1Status = ""

        this.event2Title = ""
        this.event2Time = ""
        this.event2Location = ""
        this.event2Status = ""

        this.event3Title = ""
        this.event3Time = ""
        this.event3Location = ""
        this.event3Status = ""
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

    func fillEvents(raw: String) {
        this.clearEvents()

        this.event1Title = EventService.extractEventField(raw, 0, "title")
        this.event1Time = EventService.extractEventField(raw, 0, "startTimeText")
        this.event1Location = EventService.extractEventField(raw, 0, "location")
        this.event1Status = this.normalizeStatusText(
            EventService.extractEventField(raw, 0, "status")
        )

        this.event2Title = EventService.extractEventField(raw, 1, "title")
        this.event2Time = EventService.extractEventField(raw, 1, "startTimeText")
        this.event2Location = EventService.extractEventField(raw, 1, "location")
        this.event2Status = this.normalizeStatusText(
            EventService.extractEventField(raw, 1, "status")
        )

        this.event3Title = EventService.extractEventField(raw, 2, "title")
        this.event3Time = EventService.extractEventField(raw, 2, "startTimeText")
        this.event3Location = EventService.extractEventField(raw, 2, "location")
        this.event3Status = this.normalizeStatusText(
            EventService.extractEventField(raw, 2, "status")
        )
    }

    func loadEvents() {
        this.loading = true
        this.errorMsg = ""

        EventService.getFeaturedEvents(
            { raw: String =>
                print(raw)
                this.fillEvents(raw)
                this.loading = false
            },
            { msg: String =>
                this.loading = false
                this.errorMsg = msg
            }
        )
    }

    func build() {
        Column {
            Text("活动广场")
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
                .margin(bottom: 16)

            Row {
                Button("返回首页")
                    .width(42.percent)
                    .margin(right: 8)
                    .onClick({ =>
                        Router.push(url: "HomePage")
                    })

                Button("发起活动")
                    .width(42.percent)
                    .onClick({ =>
                        Router.push(url: "CreateEventPage")
                    })
            }
            .width(100.percent)
            .margin(bottom: 16)

            Button(this.getRefreshButtonText())
                .width(88.percent)
                .enabled(!this.loading)
                .margin(bottom: 16)
                .onClick({ =>
                    this.loadEvents()
                })

            if (this.errorMsg != "") {
                Text(this.errorMsg)
                    .fontColor(0xFFFF0000)
                    .margin(bottom: 16)
            }

            if (
                this.event1Title == "" &&
                this.event2Title == "" &&
                this.event3Title == ""
            ) {
                Text("暂时还没有活动")
                    .fontSize(18)
                    .fontColor(0xFF666666)
                    .margin(bottom: 16)

                Button("去发起活动")
                    .width(88.percent)
                    .onClick({ =>
                        Router.push(url: "CreateEventPage")
                    })
            } else {
                if (this.event1Title != "") {
                    Column {
                        Text(this.event1Title)
                            .fontSize(18)
                            .fontWeight(FontWeight.Bold)
                            .margin(bottom: 8)

                        Text(this.event1Time)
                            .fontSize(13)
                            .margin(bottom: 4)

                        Text(this.event1Location)
                            .fontSize(13)
                            .margin(bottom: 8)

                        Text(this.event1Status)
                            .fontSize(12)
                            .fontColor(0xFFFF7A45)
                            .margin(bottom: 12)
                    }
                    .width(100.percent)
                    .padding(16)
                    .backgroundColor(0xFFFFFFFF)
                    .borderRadius(18)
                    .margin(bottom: 12)
                }

                if (this.event2Title != "") {
                    Column {
                        Text(this.event2Title)
                            .fontSize(18)
                            .fontWeight(FontWeight.Bold)
                            .margin(bottom: 8)

                        Text(this.event2Time)
                            .fontSize(13)
                            .margin(bottom: 4)

                        Text(this.event2Location)
                            .fontSize(13)
                            .margin(bottom: 8)

                        Text(this.event2Status)
                            .fontSize(12)
                            .fontColor(0xFFFF7A45)
                            .margin(bottom: 12)
                    }
                    .width(100.percent)
                    .padding(16)
                    .backgroundColor(0xFFFFFFFF)
                    .borderRadius(18)
                    .margin(bottom: 12)
                }

                if (this.event3Title != "") {
                    Column {
                        Text(this.event3Title)
                            .fontSize(18)
                            .fontWeight(FontWeight.Bold)
                            .margin(bottom: 8)

                        Text(this.event3Time)
                            .fontSize(13)
                            .margin(bottom: 4)

                        Text(this.event3Location)
                            .fontSize(13)
                            .margin(bottom: 8)

                        Text(this.event3Status)
                            .fontSize(12)
                            .fontColor(0xFFFF7A45)
                            .margin(bottom: 12)
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
        .height(100.percent)
        .justifyContent(FlexAlign.Center)
        .backgroundColor(0xFFF7F8FA)
    }
}