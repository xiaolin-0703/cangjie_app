package ohos_app_cangjie_entry.pages

internal import ohos.base.LengthProp
import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.router.*
import ohos_app_cangjie_entry.service.CircleService
import ohos_app_cangjie_entry.service.EventService

@Entry
@Component
class HomePage {
    @State var currentTab: String = "recommend"
    @State var loadingPosts: Bool = false
    @State var loadingEvents: Bool = false
    @State var firstLoaded: Bool = false
    @State var errorMsg: String = ""

    @State var post1Id: String = ""
    @State var post1CircleId: String = ""
    @State var post1CircleName: String = ""
    @State var post1Title: String = ""
    @State var post1Content: String = ""
    @State var post1Author: String = ""
    @State var post1Time: String = ""
    @State var post1ImageUrl: String = ""

    @State var post2Id: String = ""
    @State var post2CircleId: String = ""
    @State var post2CircleName: String = ""
    @State var post2Title: String = ""
    @State var post2Content: String = ""
    @State var post2Author: String = ""
    @State var post2Time: String = ""
    @State var post2ImageUrl: String = ""

    @State var post3Id: String = ""
    @State var post3CircleId: String = ""
    @State var post3CircleName: String = ""
    @State var post3Title: String = ""
    @State var post3Content: String = ""
    @State var post3Author: String = ""
    @State var post3Time: String = ""
    @State var post3ImageUrl: String = ""

    @State var post4Id: String = ""
    @State var post4CircleId: String = ""
    @State var post4CircleName: String = ""
    @State var post4Title: String = ""
    @State var post4Content: String = ""
    @State var post4Author: String = ""
    @State var post4Time: String = ""
    @State var post4ImageUrl: String = ""

    @State var post5Id: String = ""
    @State var post5CircleId: String = ""
    @State var post5CircleName: String = ""
    @State var post5Title: String = ""
    @State var post5Content: String = ""
    @State var post5Author: String = ""
    @State var post5Time: String = ""
    @State var post5ImageUrl: String = ""

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
        if (!this.firstLoaded && !this.loadingPosts && !this.loadingEvents) {
            this.loadHomeData()
        }
    }

    func goToEventsPage() {
        Router.push(url: "EventsPage")
    }

    func goToCirclesPage() {
        Router.push(url: "CirclesPage")
    }

    func goToProfilePage() {
        Router.push(url: "ProfilePage")
    }

    func goToCreatePostPage() {
        Router.push(url: "CreatePostPage")
    }

    func clearPosts() {
        this.post1Id = ""
        this.post1CircleId = ""
        this.post1CircleName = ""
        this.post1Title = ""
        this.post1Content = ""
        this.post1Author = ""
        this.post1Time = ""
        this.post1ImageUrl = ""

        this.post2Id = ""
        this.post2CircleId = ""
        this.post2CircleName = ""
        this.post2Title = ""
        this.post2Content = ""
        this.post2Author = ""
        this.post2Time = ""
        this.post2ImageUrl = ""

        this.post3Id = ""
        this.post3CircleId = ""
        this.post3CircleName = ""
        this.post3Title = ""
        this.post3Content = ""
        this.post3Author = ""
        this.post3Time = ""
        this.post3ImageUrl = ""

        this.post4Id = ""
        this.post4CircleId = ""
        this.post4CircleName = ""
        this.post4Title = ""
        this.post4Content = ""
        this.post4Author = ""
        this.post4Time = ""
        this.post4ImageUrl = ""

        this.post5Id = ""
        this.post5CircleId = ""
        this.post5CircleName = ""
        this.post5Title = ""
        this.post5Content = ""
        this.post5Author = ""
        this.post5Time = ""
        this.post5ImageUrl = ""
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

    func hasAnyPost(): Bool {
        return this.post1Title != "" ||
            this.post2Title != "" ||
            this.post3Title != "" ||
            this.post4Title != "" ||
            this.post5Title != ""
    }

    func hasAnyEvent(): Bool {
        return this.event1Title != "" || this.event2Title != "" || this.event3Title != ""
    }

    func normalizeStatusText(status: String): String {
        if (status == "published") {
            return "报名中"
        }
        if (status == "finished") {
            return "已结束"
        }
        if (status == "cancelled") {
            return "已取消"
        }
        if (status == "") {
            return "报名中"
        }
        return status
    }

    func formatCapacityText(raw: String): String {
        if (raw == "") {
            return "人数待定"
        }
        return "限 " + raw + " 人"
    }

    func formatDeadlineText(raw: String): String {
        if (raw == "") {
            return "截止时间待定"
        }
        return "报名截止：" + raw
    }

    func formatRegisteredText(raw: String): String {
        if (raw == "") {
            return "已报名 0 人"
        }
        return "已报名 " + raw + " 人"
    }

    func cardLabelText(value: String): String {
        if (value == "") {
            return "校园动态"
        }
        return value
    }

    func finishOneLoad() {
        if (!this.loadingPosts && !this.loadingEvents) {
            this.firstLoaded = true
        }
    }

    func fillPosts(raw: String) {
        this.clearPosts()

        this.post1Id = CircleService.extractPostField(raw, 0, "id")
        this.post1CircleId = CircleService.extractPostField(raw, 0, "circleId")
        this.post1CircleName = CircleService.extractPostField(raw, 0, "circleName")
        this.post1Title = CircleService.extractPostField(raw, 0, "title")
        this.post1Content = CircleService.extractPostField(raw, 0, "content")
        this.post1Author = CircleService.extractPostField(raw, 0, "nickname")
        this.post1Time = CircleService.extractPostField(raw, 0, "createdAt")
        this.post1ImageUrl = CircleService.extractPostField(raw, 0, "imageUrl")

        this.post2Id = CircleService.extractPostField(raw, 1, "id")
        this.post2CircleId = CircleService.extractPostField(raw, 1, "circleId")
        this.post2CircleName = CircleService.extractPostField(raw, 1, "circleName")
        this.post2Title = CircleService.extractPostField(raw, 1, "title")
        this.post2Content = CircleService.extractPostField(raw, 1, "content")
        this.post2Author = CircleService.extractPostField(raw, 1, "nickname")
        this.post2Time = CircleService.extractPostField(raw, 1, "createdAt")
        this.post2ImageUrl = CircleService.extractPostField(raw, 1, "imageUrl")

        this.post3Id = CircleService.extractPostField(raw, 2, "id")
        this.post3CircleId = CircleService.extractPostField(raw, 2, "circleId")
        this.post3CircleName = CircleService.extractPostField(raw, 2, "circleName")
        this.post3Title = CircleService.extractPostField(raw, 2, "title")
        this.post3Content = CircleService.extractPostField(raw, 2, "content")
        this.post3Author = CircleService.extractPostField(raw, 2, "nickname")
        this.post3Time = CircleService.extractPostField(raw, 2, "createdAt")
        this.post3ImageUrl = CircleService.extractPostField(raw, 2, "imageUrl")

        this.post4Id = CircleService.extractPostField(raw, 3, "id")
        this.post4CircleId = CircleService.extractPostField(raw, 3, "circleId")
        this.post4CircleName = CircleService.extractPostField(raw, 3, "circleName")
        this.post4Title = CircleService.extractPostField(raw, 3, "title")
        this.post4Content = CircleService.extractPostField(raw, 3, "content")
        this.post4Author = CircleService.extractPostField(raw, 3, "nickname")
        this.post4Time = CircleService.extractPostField(raw, 3, "createdAt")
        this.post4ImageUrl = CircleService.extractPostField(raw, 3, "imageUrl")

        this.post5Id = CircleService.extractPostField(raw, 4, "id")
        this.post5CircleId = CircleService.extractPostField(raw, 4, "circleId")
        this.post5CircleName = CircleService.extractPostField(raw, 4, "circleName")
        this.post5Title = CircleService.extractPostField(raw, 4, "title")
        this.post5Content = CircleService.extractPostField(raw, 4, "content")
        this.post5Author = CircleService.extractPostField(raw, 4, "nickname")
        this.post5Time = CircleService.extractPostField(raw, 4, "createdAt")
        this.post5ImageUrl = CircleService.extractPostField(raw, 4, "imageUrl")
    }

    func fillEvents(raw: String) {
        this.clearEvents()

        this.event1Id = EventService.extractEventField(raw, 0, "id")
        this.event1Title = EventService.extractEventField(raw, 0, "title")
        this.event1Time = EventService.extractEventField(raw, 0, "startTimeText")
        this.event1Location = EventService.extractEventField(raw, 0, "location")
        this.event1Status = this.normalizeStatusText(EventService.extractEventField(raw, 0, "status"))
        this.event1Description = EventService.extractEventField(raw, 0, "description")
        this.event1CapacityText = this.formatCapacityText(EventService.extractEventField(raw, 0, "capacity"))
        this.event1DeadlineText = this.formatDeadlineText(EventService.extractEventField(raw, 0, "signupDeadline"))
        this.event1RegisteredText = this.formatRegisteredText(EventService.extractEventField(raw, 0, "registeredCount"))

        this.event2Id = EventService.extractEventField(raw, 1, "id")
        this.event2Title = EventService.extractEventField(raw, 1, "title")
        this.event2Time = EventService.extractEventField(raw, 1, "startTimeText")
        this.event2Location = EventService.extractEventField(raw, 1, "location")
        this.event2Status = this.normalizeStatusText(EventService.extractEventField(raw, 1, "status"))
        this.event2Description = EventService.extractEventField(raw, 1, "description")
        this.event2CapacityText = this.formatCapacityText(EventService.extractEventField(raw, 1, "capacity"))
        this.event2DeadlineText = this.formatDeadlineText(EventService.extractEventField(raw, 1, "signupDeadline"))
        this.event2RegisteredText = this.formatRegisteredText(EventService.extractEventField(raw, 1, "registeredCount"))

        this.event3Id = EventService.extractEventField(raw, 2, "id")
        this.event3Title = EventService.extractEventField(raw, 2, "title")
        this.event3Time = EventService.extractEventField(raw, 2, "startTimeText")
        this.event3Location = EventService.extractEventField(raw, 2, "location")
        this.event3Status = this.normalizeStatusText(EventService.extractEventField(raw, 2, "status"))
        this.event3Description = EventService.extractEventField(raw, 2, "description")
        this.event3CapacityText = this.formatCapacityText(EventService.extractEventField(raw, 2, "capacity"))
        this.event3DeadlineText = this.formatDeadlineText(EventService.extractEventField(raw, 2, "signupDeadline"))
        this.event3RegisteredText = this.formatRegisteredText(EventService.extractEventField(raw, 2, "registeredCount"))
    }

    func loadHomeData() {
        this.errorMsg = ""
        this.loadingPosts = true
        this.loadingEvents = true

        CircleService.getLatestPosts(
            { raw: String =>
                this.fillPosts(raw)
                this.loadingPosts = false
                this.finishOneLoad()
            },
            { msg: String =>
                this.loadingPosts = false
                this.errorMsg = msg
                this.finishOneLoad()
            }
        )

        EventService.getFeaturedEvents(
            { raw: String =>
                this.fillEvents(raw)
                this.loadingEvents = false
                this.finishOneLoad()
            },
            { msg: String =>
                this.loadingEvents = false
                this.errorMsg = msg
                this.finishOneLoad()
            }
        )
    }

    func openCircle(circleId: String, circleName: String) {
        if (circleId == "") {
            return
        }
        CircleService.setCurrentCircleDetail(circleId, circleName, "", "", "false")
        Router.push(url: "CircleDetailPage")
    }

    func openEventDetail(id: String, title: String, time: String, location: String, status: String, description: String, capacityText: String, deadlineText: String) {
        if (id == "") {
            return
        }
        EventService.setCurrentEventDetail(
            id,
            title,
            time,
            location,
            status,
            description,
            capacityText,
            deadlineText
        )
        Router.push(url: "EventDetailPage")
    }

    func build() {
        Column {
            Column {
                Row {
                    Row {
                        if (this.currentTab == "recommend") {
                            Column {
                                Text("推荐")
                                    .fontColor(0xFF1D2B53)
                                    .fontSize(18)
                                    .fontWeight(FontWeight.Bold)
                                    .padding(top: 6, bottom: 6)
                                    .onClick({ _: ClickEvent =>
                                        this.currentTab = "recommend"
                                    })

                                Row {}
                                    .width(20)
                                    .height(3)
                                    .backgroundColor(0xFF2F80FF)
                                    .borderRadius(2)
                            }
                            .margin(right: 20)
                        } else {
                            Column {
                                Text("推荐")
                                    .fontColor(0xFF74829C)
                                    .fontSize(17)
                                    .padding(top: 6, bottom: 6)
                                    .onClick({ _: ClickEvent =>
                                        this.currentTab = "recommend"
                                    })

                                Row {}
                                    .width(20)
                                    .height(3)
                                    .backgroundColor(0x00000000)
                            }
                            .margin(right: 20)
                        }

                        if (this.currentTab == "latest") {
                            Column {
                                Text("最新")
                                    .fontColor(0xFF1D2B53)
                                    .fontSize(18)
                                    .fontWeight(FontWeight.Bold)
                                    .padding(top: 6, bottom: 6)
                                    .onClick({ _: ClickEvent =>
                                        this.currentTab = "latest"
                                    })

                                Row {}
                                    .width(20)
                                    .height(3)
                                    .backgroundColor(0xFF2F80FF)
                                    .borderRadius(2)
                            }
                        } else {
                            Column {
                                Text("最新")
                                    .fontColor(0xFF74829C)
                                    .fontSize(17)
                                    .padding(top: 6, bottom: 6)
                                    .onClick({ _: ClickEvent =>
                                        this.currentTab = "latest"
                                    })

                                Row {}
                                    .width(20)
                                    .height(3)
                                    .backgroundColor(0x00000000)
                            }
                        }
                    }
                    .layoutWeight(3)
                    .alignItems(VerticalAlign.Center)

                    Text("刷新")
                        .fontColor(0xFF2F80FF)
                        .fontSize(13)
                        .fontWeight(FontWeight.Bold)
                        .padding(left: 12, right: 12, top: 7, bottom: 7)
                        .backgroundColor(0xFFEAF2FF)
                        .borderRadius(14)
                        .onClick({ _: ClickEvent =>
                            this.loadHomeData()
                        })
                }
                .width(100.percent)
                .alignItems(VerticalAlign.Center)
            }
            .width(100.percent)
            .padding(left: 12, right: 12, top: 10, bottom: 10)
            .backgroundColor(0xFFFFFFFF)

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

                    if ((this.loadingPosts || this.loadingEvents) && !this.firstLoaded) {
                        Column {
                            Text("正在加载首页内容...")
                                .fontSize(18)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF24324A)
                                .margin(bottom: 8)

                            Text("活动和帖子会从数据库实时读取。")
                                .fontSize(13)
                                .fontColor(0xFF6D7B99)
                        }
                        .width(100.percent)
                        .padding(16)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 12)
                    } else if (!this.hasAnyPost() && !this.hasAnyEvent()) {
                        Column {
                            Text("还没有内容")
                                .fontSize(18)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF24324A)
                                .margin(bottom: 8)

                            Text("发起活动或在圈子里发布帖子后，这里会自动显示真实数据。")
                                .fontSize(13)
                                .fontColor(0xFF6D7B99)
                                .lineHeight(20)
                        }
                        .width(100.percent)
                        .padding(16)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 12)
                    } else if (this.currentTab == "recommend") {
                        Row {
                            Column {
                                if (this.post1Title != "") {
                                    Column {
                                        if (this.post1ImageUrl != "") {
                                            Image(this.post1ImageUrl)
                                                .width(100.percent)
                                                .height(148)
                                                .borderRadius(14)
                                                .margin(bottom: 8)
                                        } else {
                                            Row {
                                                Text(this.cardLabelText(this.post1CircleName))
                                                    .fontSize(17)
                                                    .fontWeight(FontWeight.Bold)
                                                    .fontColor(0xFF2F80FF)
                                            }
                                            .width(100.percent)
                                            .height(148)
                                            .justifyContent(FlexAlign.Center)
                                            .alignItems(VerticalAlign.Center)
                                            .backgroundColor(0xFFDDEBFF)
                                            .borderRadius(14)
                                            .margin(bottom: 8)
                                        }

                                        Text(this.post1Title)
                                            .fontSize(14)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFF24324A)
                                            .maxLines(2)
                                            .textOverflow(TextOverflow.Ellipsis)
                                            .margin(bottom: 6)

                                        Text(this.post1Content)
                                            .fontSize(12)
                                            .fontColor(0xFF6D7B99)
                                            .lineHeight(18)
                                            .maxLines(3)
                                            .textOverflow(TextOverflow.Ellipsis)
                                            .margin(bottom: 10)

                                        Row {
                                            Column {
                                                Text(this.post1Author)
                                                    .fontSize(12)
                                                    .fontColor(0xFF42526B)
                                                    .margin(bottom: 4)

                                                Text(this.cardLabelText(this.post1CircleName))
                                                    .fontSize(10)
                                                    .fontColor(0xFF2F80FF)
                                                    .backgroundColor(0xFFEAF2FF)
                                                    .padding(left: 7, right: 7, top: 3, bottom: 3)
                                                    .borderRadius(9)
                                            }
                                            .layoutWeight(1)
                                            .alignItems(HorizontalAlign.Start)

                                            Text(this.post1Time)
                                                .fontSize(10)
                                                .fontColor(0xFF7E8CA8)
                                        }
                                        .width(100.percent)
                                        .alignItems(VerticalAlign.Bottom)
                                    }
                                    .width(100.percent)
                                    .padding(left: 8, right: 8, top: 8, bottom: 10)
                                    .backgroundColor(0xFFFFFFFF)
                                    .borderRadius(16)
                                    .margin(bottom: 10)
                                    .onClick({ _: ClickEvent =>
                                        this.openCircle(this.post1CircleId, this.post1CircleName)
                                    })
                                }

                                if (this.event1Title != "") {
                                    Column {
                                        Row {
                                            Text("活动")
                                                .fontSize(11)
                                                .fontColor(0xFF2F80FF)
                                                .backgroundColor(0xFFEAF2FF)
                                                .padding(left: 8, right: 8, top: 4, bottom: 4)
                                                .borderRadius(10)
                                        }
                                        .margin(bottom: 8)

                                        Row {
                                            Text(this.event1Title)
                                                .fontSize(17)
                                                .fontWeight(FontWeight.Bold)
                                                .fontColor(0xFF2F80FF)
                                                .maxLines(2)
                                                .textOverflow(TextOverflow.Ellipsis)
                                        }
                                        .width(100.percent)
                                        .height(102)
                                        .justifyContent(FlexAlign.Center)
                                        .alignItems(VerticalAlign.Center)
                                        .backgroundColor(0xFFE8F5FF)
                                        .borderRadius(14)
                                        .margin(bottom: 8)

                                        Text(this.event1Time)
                                            .fontSize(14)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFF24324A)
                                            .maxLines(1)
                                            .textOverflow(TextOverflow.Ellipsis)
                                            .margin(bottom: 6)

                                        Text(this.event1Description)
                                            .fontSize(12)
                                            .fontColor(0xFF6D7B99)
                                            .lineHeight(18)
                                            .maxLines(3)
                                            .textOverflow(TextOverflow.Ellipsis)
                                            .margin(bottom: 10)

                                        Column {
                                            Text(this.event1DeadlineText)
                                                .fontSize(11)
                                                .fontColor(0xFF6D7B99)
                                                .margin(bottom: 4)

                                            Text(this.event1CapacityText + " · " + this.event1RegisteredText)
                                                .fontSize(11)
                                                .fontColor(0xFF6D7B99)
                                                .margin(bottom: 4)

                                            Text(this.event1Status)
                                                .fontSize(11)
                                                .fontColor(0xFF2F80FF)
                                        }
                                        .alignItems(HorizontalAlign.Start)
                                    }
                                    .width(100.percent)
                                    .padding(left: 8, right: 8, top: 8, bottom: 10)
                                    .backgroundColor(0xFFFFFFFF)
                                    .borderRadius(16)
                                    .margin(bottom: 10)
                                    .onClick({ _: ClickEvent =>
                                        this.openEventDetail(
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

                                if (this.post3Title != "") {
                                    Column {
                                        if (this.post3ImageUrl != "") {
                                            Image(this.post3ImageUrl)
                                                .width(100.percent)
                                                .height(126)
                                                .borderRadius(14)
                                                .margin(bottom: 8)
                                        } else {
                                            Row {
                                                Text(this.cardLabelText(this.post3CircleName))
                                                    .fontSize(17)
                                                    .fontWeight(FontWeight.Bold)
                                                    .fontColor(0xFF2F80FF)
                                            }
                                            .width(100.percent)
                                            .height(126)
                                            .justifyContent(FlexAlign.Center)
                                            .alignItems(VerticalAlign.Center)
                                            .backgroundColor(0xFFE8F5FF)
                                            .borderRadius(14)
                                            .margin(bottom: 8)
                                        }

                                        Text(this.post3Title)
                                            .fontSize(14)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFF24324A)
                                            .maxLines(2)
                                            .textOverflow(TextOverflow.Ellipsis)
                                            .margin(bottom: 6)

                                        Text(this.post3Content)
                                            .fontSize(12)
                                            .fontColor(0xFF6D7B99)
                                            .lineHeight(18)
                                            .maxLines(3)
                                            .textOverflow(TextOverflow.Ellipsis)
                                            .margin(bottom: 10)

                                        Text(this.post3Author + " · " + this.cardLabelText(this.post3CircleName))
                                            .fontSize(12)
                                            .fontColor(0xFF2F80FF)
                                    }
                                    .width(100.percent)
                                    .padding(left: 8, right: 8, top: 8, bottom: 10)
                                    .backgroundColor(0xFFFFFFFF)
                                    .borderRadius(16)
                                    .margin(bottom: 10)
                                    .onClick({ _: ClickEvent =>
                                        this.openCircle(this.post3CircleId, this.post3CircleName)
                                    })
                                }
                            }
                            .layoutWeight(1)
                            .margin(right: 6)

                            Column {
                                if (this.post2Title != "") {
                                    Column {
                                        if (this.post2ImageUrl != "") {
                                            Image(this.post2ImageUrl)
                                                .width(100.percent)
                                                .height(116)
                                                .borderRadius(14)
                                                .margin(bottom: 8)
                                        } else {
                                            Row {
                                                Text(this.cardLabelText(this.post2CircleName))
                                                    .fontSize(17)
                                                    .fontWeight(FontWeight.Bold)
                                                    .fontColor(0xFF2F80FF)
                                            }
                                            .width(100.percent)
                                            .height(116)
                                            .justifyContent(FlexAlign.Center)
                                            .alignItems(VerticalAlign.Center)
                                            .backgroundColor(0xFFEAF2FF)
                                            .borderRadius(14)
                                            .margin(bottom: 8)
                                        }

                                        Text(this.post2Title)
                                            .fontSize(14)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFF24324A)
                                            .maxLines(2)
                                            .textOverflow(TextOverflow.Ellipsis)
                                            .margin(bottom: 6)

                                        Text(this.post2Content)
                                            .fontSize(12)
                                            .fontColor(0xFF6D7B99)
                                            .lineHeight(18)
                                            .maxLines(3)
                                            .textOverflow(TextOverflow.Ellipsis)
                                            .margin(bottom: 10)

                                        Text(this.post2Author + " · " + this.cardLabelText(this.post2CircleName))
                                            .fontSize(12)
                                            .fontColor(0xFF2F80FF)
                                    }
                                    .width(100.percent)
                                    .padding(left: 8, right: 8, top: 8, bottom: 10)
                                    .backgroundColor(0xFFFFFFFF)
                                    .borderRadius(16)
                                    .margin(bottom: 10)
                                    .onClick({ _: ClickEvent =>
                                        this.openCircle(this.post2CircleId, this.post2CircleName)
                                    })
                                }

                                if (this.event2Title != "") {
                                    Column {
                                        Row {
                                            Text("活动")
                                                .fontSize(11)
                                                .fontColor(0xFF2F80FF)
                                                .backgroundColor(0xFFEAF2FF)
                                                .padding(left: 8, right: 8, top: 4, bottom: 4)
                                                .borderRadius(10)
                                        }
                                        .margin(bottom: 8)

                                        Row {
                                            Text(this.event2Title)
                                                .fontSize(17)
                                                .fontWeight(FontWeight.Bold)
                                                .fontColor(0xFF2F80FF)
                                                .maxLines(2)
                                                .textOverflow(TextOverflow.Ellipsis)
                                        }
                                        .width(100.percent)
                                        .height(164)
                                        .justifyContent(FlexAlign.Center)
                                        .alignItems(VerticalAlign.Center)
                                        .backgroundColor(0xFFD9EAFF)
                                        .borderRadius(14)
                                        .margin(bottom: 8)

                                        Text(this.event2Time)
                                            .fontSize(14)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFF24324A)
                                            .maxLines(1)
                                            .textOverflow(TextOverflow.Ellipsis)
                                            .margin(bottom: 6)

                                        Text(this.event2Description)
                                            .fontSize(12)
                                            .fontColor(0xFF6D7B99)
                                            .lineHeight(18)
                                            .maxLines(3)
                                            .textOverflow(TextOverflow.Ellipsis)
                                            .margin(bottom: 10)

                                        Text(this.event2Status + " · " + this.event2RegisteredText)
                                            .fontSize(11)
                                            .fontColor(0xFF2F80FF)
                                    }
                                    .width(100.percent)
                                    .padding(left: 8, right: 8, top: 8, bottom: 10)
                                    .backgroundColor(0xFFFFFFFF)
                                    .borderRadius(16)
                                    .margin(bottom: 10)
                                    .onClick({ _: ClickEvent =>
                                        this.openEventDetail(
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

                                if (this.post4Title != "") {
                                    Column {
                                        if (this.post4ImageUrl != "") {
                                            Image(this.post4ImageUrl)
                                                .width(100.percent)
                                                .height(132)
                                                .borderRadius(14)
                                                .margin(bottom: 8)
                                        } else {
                                            Row {
                                                Text(this.cardLabelText(this.post4CircleName))
                                                    .fontSize(17)
                                                    .fontWeight(FontWeight.Bold)
                                                    .fontColor(0xFF2F80FF)
                                            }
                                            .width(100.percent)
                                            .height(132)
                                            .justifyContent(FlexAlign.Center)
                                            .alignItems(VerticalAlign.Center)
                                            .backgroundColor(0xFFE3EEFF)
                                            .borderRadius(14)
                                            .margin(bottom: 8)
                                        }

                                        Text(this.post4Title)
                                            .fontSize(14)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFF24324A)
                                            .maxLines(2)
                                            .textOverflow(TextOverflow.Ellipsis)
                                            .margin(bottom: 6)

                                        Text(this.post4Content)
                                            .fontSize(12)
                                            .fontColor(0xFF6D7B99)
                                            .lineHeight(18)
                                            .maxLines(3)
                                            .textOverflow(TextOverflow.Ellipsis)
                                            .margin(bottom: 10)

                                        Text(this.post4Author + " · " + this.cardLabelText(this.post4CircleName))
                                            .fontSize(12)
                                            .fontColor(0xFF2F80FF)
                                    }
                                    .width(100.percent)
                                    .padding(left: 8, right: 8, top: 8, bottom: 10)
                                    .backgroundColor(0xFFFFFFFF)
                                    .borderRadius(16)
                                    .margin(bottom: 10)
                                    .onClick({ _: ClickEvent =>
                                        this.openCircle(this.post4CircleId, this.post4CircleName)
                                    })
                                }
                            }
                            .layoutWeight(1)
                        }
                        .width(100.percent)
                    } else {
                        Column {
                            Text("最新帖子")
                                .fontSize(20)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF24324A)
                                .margin(bottom: 12)

                            if (!this.hasAnyPost()) {
                                Column {
                                    Text("还没有帖子")
                                        .fontSize(18)
                                        .fontWeight(FontWeight.Bold)
                                        .fontColor(0xFF24324A)
                                        .margin(bottom: 8)

                                    Text("去圈子里发布第一条动态吧。")
                                        .fontSize(13)
                                        .fontColor(0xFF6D7B99)
                                }
                                .width(100.percent)
                                .padding(16)
                                .backgroundColor(0xFFFFFFFF)
                                .borderRadius(18)
                                .margin(bottom: 12)
                            }

                            if (this.post1Title != "") {
                                Column {
                                    Text(this.post1Title)
                                        .fontSize(18)
                                        .fontWeight(FontWeight.Bold)
                                        .fontColor(0xFF24324A)
                                        .margin(bottom: 8)

                                    Text(this.post1Content)
                                        .fontSize(13)
                                        .fontColor(0xFF6D7B99)
                                        .lineHeight(20)
                                        .maxLines(3)
                                        .textOverflow(TextOverflow.Ellipsis)
                                        .margin(bottom: 10)

                                    if (this.post1ImageUrl != "") {
                                        Image(this.post1ImageUrl)
                                            .width(100.percent)
                                            .height(168)
                                            .borderRadius(14)
                                            .margin(bottom: 10)
                                    }

                                    Text(this.post1Author + " · " + this.cardLabelText(this.post1CircleName) + " · " + this.post1Time)
                                        .fontSize(12)
                                        .fontColor(0xFF2F80FF)
                                }
                                .width(100.percent)
                                .padding(16)
                                .backgroundColor(0xFFFFFFFF)
                                .borderRadius(18)
                                .margin(bottom: 12)
                                .onClick({ _: ClickEvent =>
                                    this.openCircle(this.post1CircleId, this.post1CircleName)
                                })
                            }

                            if (this.post2Title != "") {
                                Column {
                                    Text(this.post2Title)
                                        .fontSize(18)
                                        .fontWeight(FontWeight.Bold)
                                        .fontColor(0xFF24324A)
                                        .margin(bottom: 8)

                                    Text(this.post2Content)
                                        .fontSize(13)
                                        .fontColor(0xFF6D7B99)
                                        .lineHeight(20)
                                        .maxLines(3)
                                        .textOverflow(TextOverflow.Ellipsis)
                                        .margin(bottom: 10)

                                    if (this.post2ImageUrl != "") {
                                        Image(this.post2ImageUrl)
                                            .width(100.percent)
                                            .height(168)
                                            .borderRadius(14)
                                            .margin(bottom: 10)
                                    }

                                    Text(this.post2Author + " · " + this.cardLabelText(this.post2CircleName) + " · " + this.post2Time)
                                        .fontSize(12)
                                        .fontColor(0xFF2F80FF)
                                }
                                .width(100.percent)
                                .padding(16)
                                .backgroundColor(0xFFFFFFFF)
                                .borderRadius(18)
                                .margin(bottom: 12)
                                .onClick({ _: ClickEvent =>
                                    this.openCircle(this.post2CircleId, this.post2CircleName)
                                })
                            }

                            if (this.post3Title != "") {
                                Column {
                                    Text(this.post3Title)
                                        .fontSize(18)
                                        .fontWeight(FontWeight.Bold)
                                        .fontColor(0xFF24324A)
                                        .margin(bottom: 8)

                                    Text(this.post3Content)
                                        .fontSize(13)
                                        .fontColor(0xFF6D7B99)
                                        .lineHeight(20)
                                        .maxLines(3)
                                        .textOverflow(TextOverflow.Ellipsis)
                                        .margin(bottom: 10)

                                    if (this.post3ImageUrl != "") {
                                        Image(this.post3ImageUrl)
                                            .width(100.percent)
                                            .height(168)
                                            .borderRadius(14)
                                            .margin(bottom: 10)
                                    }

                                    Text(this.post3Author + " · " + this.cardLabelText(this.post3CircleName) + " · " + this.post3Time)
                                        .fontSize(12)
                                        .fontColor(0xFF2F80FF)
                                }
                                .width(100.percent)
                                .padding(16)
                                .backgroundColor(0xFFFFFFFF)
                                .borderRadius(18)
                                .margin(bottom: 12)
                                .onClick({ _: ClickEvent =>
                                    this.openCircle(this.post3CircleId, this.post3CircleName)
                                })
                            }

                            Text("最新活动")
                                .fontSize(20)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF24324A)
                                .margin(top: 6, bottom: 12)

                            if (!this.hasAnyEvent()) {
                                Column {
                                    Text("还没有活动")
                                        .fontSize(18)
                                        .fontWeight(FontWeight.Bold)
                                        .fontColor(0xFF24324A)
                                        .margin(bottom: 8)

                                    Text("创建活动后会出现在这里。")
                                        .fontSize(13)
                                        .fontColor(0xFF6D7B99)
                                }
                                .width(100.percent)
                                .padding(16)
                                .backgroundColor(0xFFFFFFFF)
                                .borderRadius(18)
                                .margin(bottom: 12)
                            }

                            if (this.event1Title != "") {
                                Column {
                                    Row {
                                        Text(this.event1Status)
                                            .fontSize(11)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFF2F80FF)
                                            .backgroundColor(0xFFEAF2FF)
                                            .padding(left: 8, right: 8, top: 4, bottom: 4)
                                            .borderRadius(10)

                                        Row {}
                                            .layoutWeight(1)

                                        Text("查看")
                                            .fontSize(12)
                                            .fontColor(0xFF9AA6BD)
                                    }
                                    .width(100.percent)
                                    .alignItems(VerticalAlign.Center)
                                    .margin(bottom: 8)

                                    Text(this.event1Title)
                                        .fontSize(18)
                                        .fontWeight(FontWeight.Bold)
                                        .fontColor(0xFF24324A)
                                        .margin(bottom: 8)

                                    Text(this.event1Description)
                                        .fontSize(13)
                                        .fontColor(0xFF6D7B99)
                                        .lineHeight(20)
                                        .maxLines(2)
                                        .textOverflow(TextOverflow.Ellipsis)
                                        .margin(bottom: 10)

                                    Text(this.event1Time + " · " + this.event1Location)
                                        .fontSize(12)
                                        .fontColor(0xFF4E5D78)
                                        .margin(bottom: 4)

                                    Text(this.event1DeadlineText + " · " + this.event1RegisteredText)
                                        .fontSize(11)
                                        .fontColor(0xFF7C879C)
                                }
                                .width(100.percent)
                                .padding(16)
                                .backgroundColor(0xFFFFFFFF)
                                .borderRadius(18)
                                .margin(bottom: 12)
                                .onClick({ _: ClickEvent =>
                                    this.openEventDetail(
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

                            if (this.event2Title != "") {
                                Column {
                                    Row {
                                        Text(this.event2Status)
                                            .fontSize(11)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFF2F80FF)
                                            .backgroundColor(0xFFEAF2FF)
                                            .padding(left: 8, right: 8, top: 4, bottom: 4)
                                            .borderRadius(10)

                                        Row {}
                                            .layoutWeight(1)

                                        Text("查看")
                                            .fontSize(12)
                                            .fontColor(0xFF9AA6BD)
                                    }
                                    .width(100.percent)
                                    .alignItems(VerticalAlign.Center)
                                    .margin(bottom: 8)

                                    Text(this.event2Title)
                                        .fontSize(18)
                                        .fontWeight(FontWeight.Bold)
                                        .fontColor(0xFF24324A)
                                        .margin(bottom: 8)

                                    Text(this.event2Description)
                                        .fontSize(13)
                                        .fontColor(0xFF6D7B99)
                                        .lineHeight(20)
                                        .maxLines(2)
                                        .textOverflow(TextOverflow.Ellipsis)
                                        .margin(bottom: 10)

                                    Text(this.event2Time + " · " + this.event2Location)
                                        .fontSize(12)
                                        .fontColor(0xFF4E5D78)
                                        .margin(bottom: 4)

                                    Text(this.event2DeadlineText + " · " + this.event2RegisteredText)
                                        .fontSize(11)
                                        .fontColor(0xFF7C879C)
                                }
                                .width(100.percent)
                                .padding(16)
                                .backgroundColor(0xFFFFFFFF)
                                .borderRadius(18)
                                .margin(bottom: 12)
                                .onClick({ _: ClickEvent =>
                                    this.openEventDetail(
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
                        }
                        .width(100.percent)
                    }
                }
                .width(100.percent)
                .padding(left: 12, right: 12, top: 8, bottom: 96)
            }
            .layoutWeight(1)

            Row {
                Row {
                    Text("广场")
                        .fontColor(0xFF2F80FF)
                        .fontWeight(FontWeight.Bold)
                        .fontSize(15)
                }
                .layoutWeight(1)
                .height(40)
                .justifyContent(FlexAlign.Center)
                .alignItems(VerticalAlign.Center)

                Row {
                    Text("圈子")
                        .fontColor(0xFF5E6C84)
                        .fontSize(15)
                        .onClick({ _: ClickEvent =>
                            this.goToCirclesPage()
                        })
                }
                .layoutWeight(1)
                .height(40)
                .justifyContent(FlexAlign.Center)
                .alignItems(VerticalAlign.Center)

                Button("+")
                    .width(52)
                    .height(52)
                    .backgroundColor(0xFF2F80FF)
                    .fontColor(0xFFFFFFFF)
                    .fontSize(28)
                    .fontWeight(FontWeight.Bold)
                    .borderRadius(26)
                    .margin(left: 6, right: 6)
                    .onClick({ _: ClickEvent =>
                        this.goToCreatePostPage()
                    })

                Row {
                    Text("活动")
                        .fontColor(0xFF5E6C84)
                        .fontSize(15)
                        .onClick({ _: ClickEvent =>
                            this.goToEventsPage()
                        })
                }
                .layoutWeight(1)
                .height(40)
                .justifyContent(FlexAlign.Center)
                .alignItems(VerticalAlign.Center)

                Row {
                    Text("我的")
                        .fontColor(0xFF5E6C84)
                        .fontSize(15)
                        .onClick({ _: ClickEvent =>
                            this.goToProfilePage()
                        })
                }
                .layoutWeight(1)
                .height(40)
                .justifyContent(FlexAlign.Center)
                .alignItems(VerticalAlign.Center)
            }
            .alignItems(VerticalAlign.Center)
            .width(100.percent)
            .padding(left: 10, right: 10, top: 10, bottom: 16)
            .backgroundColor(0xFFFFFFFF)
        }
        .width(100.percent)
        .height(100.percent)
        .backgroundColor(0xFFF4F8FF)
    }
}
