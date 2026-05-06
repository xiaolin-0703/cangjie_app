/*
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

    public func aboutToAppear(): Unit { if (!this.firstLoaded && !this.loading) { this.loadEvents() } }
    func goToHomePage() { Router.push(url: "HomePage") }
    func goToCirclesPage() { Router.push(url: "CirclesPage") }
    func goToProfilePage() { Router.push(url: "ProfilePage") }
    func goToCreateEventPage() { Router.push(url: "CreateEventPage") }
    func getRefreshButtonText(): String { return if (this.loading) { "刷新中..." } else { "刷新" } }
    func hasAnyEvent(): Bool { return this.event1Title != "" || this.event2Title != "" || this.event3Title != "" }

    func fillEvents(raw: String) {
        this.event1Id = EventService.extractEventField(raw, 0, "id")
        this.event1Title = EventService.extractEventField(raw, 0, "title")
        this.event1Time = EventService.extractEventField(raw, 0, "startTimeText")
        this.event1Location = EventService.extractEventField(raw, 0, "location")
        this.event1Status = if(EventService.extractEventField(raw, 0, "status")=="published"){"报名中"}else{"已结束"}
        this.event1Description = EventService.extractEventField(raw, 0, "description")
        this.event1CapacityText = "限 " + EventService.extractEventField(raw, 0, "capacity") + " 人"
        this.event1DeadlineText = "截止：" + EventService.extractEventField(raw, 0, "signupDeadline")

        this.event2Id = EventService.extractEventField(raw, 1, "id")
        this.event2Title = EventService.extractEventField(raw, 1, "title")
        this.event2Time = EventService.extractEventField(raw, 1, "startTimeText")
        this.event2Location = EventService.extractEventField(raw, 1, "location")
        this.event2Status = if(EventService.extractEventField(raw, 1, "status")=="published"){"报名中"}else{"已结束"}
        this.event2Description = EventService.extractEventField(raw, 1, "description")
        this.event2CapacityText = "限 " + EventService.extractEventField(raw, 1, "capacity") + " 人"
        this.event2DeadlineText = "截止：" + EventService.extractEventField(raw, 1, "signupDeadline")

        this.event3Id = EventService.extractEventField(raw, 2, "id")
        this.event3Title = EventService.extractEventField(raw, 2, "title")
        this.event3Time = EventService.extractEventField(raw, 2, "startTimeText")
        this.event3Location = EventService.extractEventField(raw, 2, "location")
        this.event3Status = if(EventService.extractEventField(raw, 2, "status")=="published"){"报名中"}else{"已结束"}
        this.event3Description = EventService.extractEventField(raw, 2, "description")
        this.event3CapacityText = "限 " + EventService.extractEventField(raw, 2, "capacity") + " 人"
        this.event3DeadlineText = "截止：" + EventService.extractEventField(raw, 2, "signupDeadline")
    }

    func loadEvents() {
        this.loading = true; this.errorMsg = ""
        EventService.getFeaturedEvents(
            { raw: String => this.fillEvents(raw); this.loading = false; this.firstLoaded = true },
            { msg: String => this.loading = false; this.firstLoaded = true; this.errorMsg = msg }
        )
    }

    func openEventDetail(id: String, title: String, time: String, location: String, status: String, description: String, capacityText: String, deadlineText: String) {
        EventService.setCurrentEventDetail(id, title, time, location, status, description, capacityText, deadlineText)
        Router.push(url: "EventDetailPage")
    }

    func build() {
        Column {
            Scroll {
                Column {
                    Row { Text("活动推荐").fontSize(20).fontWeight(FontWeight.Bold).fontColor(0xFF24324A) }.width(100.percent).padding(left: 16, right: 16, top: 4, bottom: 8)

                    Swiper {
                        Stack { Row().width(100.percent).height(100.percent).backgroundColor(0xFF2F80FF); Column { Text("➕ 发起活动").fontSize(22).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF).margin(bottom: 6); Text("组织一场新局，发布后会出现在列表中").fontSize(13).fontColor(0xFFDDEBFF) }.alignItems(HorizontalAlign.Center) }.width(100.percent).height(100.percent).onClick({ _: ClickEvent => this.goToCreateEventPage() })
                        Stack { Row().width(100.percent).height(100.percent).backgroundColor(0xFF7FAEFF); Text("🔥 热门精选：点击查看热门活动").fontSize(18).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF) }.width(100.percent).height(100.percent).onClick({ _: ClickEvent => if (this.event1Id != "") { this.openEventDetail(this.event1Id, this.event1Title, this.event1Time, this.event1Location, this.event1Status, this.event1Description, this.event1CapacityText, this.event1DeadlineText) } })
                        Stack { Row().width(100.percent).height(100.percent).backgroundColor(0xFF9CC3FF); Text("✨ 本周推荐：校园精品局速递").fontSize(18).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF) }.width(100.percent).height(100.percent).onClick({ _: ClickEvent => if (this.event2Id != "") { this.openEventDetail(this.event2Id, this.event2Title, this.event2Time, this.event2Location, this.event2Status, this.event2Description, this.event2CapacityText, this.event2DeadlineText) } })
                    }.width(100.percent).height(180).autoPlay(true).interval(3000)

                    Row { Text("全部活动").fontSize(20).fontWeight(FontWeight.Bold).fontColor(0xFF24324A); Row { }.layoutWeight(1); Text(this.getRefreshButtonText()).fontSize(12).fontColor(0xFF2F80FF).backgroundColor(0xFFEAF2FF).padding(left: 12, right: 12, top: 7, bottom: 7).borderRadius(14).onClick({ _: ClickEvent => if (!this.loading) { this.loadEvents() } }) }.width(100.percent).padding(left: 16, right: 16, top: 20, bottom: 10).alignItems(VerticalAlign.Center)

                    if (this.errorMsg != "") { Column { Text("加载失败").fontSize(18).fontWeight(FontWeight.Bold).fontColor(0xFF24324A).margin(bottom: 8); Text(this.errorMsg).fontSize(13).fontColor(0xFFE96B6B) }.width(100.percent).padding(16).backgroundColor(0xFFFFFFFF).borderRadius(22).margin(left: 12, right: 12, bottom: 12) }

                    if (!this.firstLoaded && this.loading) {
                        Column { Text("正在加载活动...").fontSize(18).fontWeight(FontWeight.Bold).fontColor(0xFF24324A).margin(bottom: 8); Text("稍等一下，新的活动马上就来。").fontSize(13).fontColor(0xFF6D7B99) }.width(100.percent).padding(16).backgroundColor(0xFFFFFFFF).borderRadius(22).margin(left: 12, right: 12, bottom: 12)
                    } else if (!this.hasAnyEvent()) {
                        Column { Text("还没有活动").fontSize(18).fontWeight(FontWeight.Bold).fontColor(0xFF24324A).margin(bottom: 8); Text("你可以先发起一个活动，创建成功后就会显示在这里。").fontSize(13).fontColor(0xFF6D7B99).margin(bottom: 14); Text("去发起活动").fontSize(14).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF).width(100.percent).height(42).backgroundColor(0xFF2F80FF).borderRadius(14).textAlign(TextAlign.Center).onClick({ _: ClickEvent => this.goToCreateEventPage() }) }.width(100.percent).padding(16).backgroundColor(0xFFFFFFFF).borderRadius(22).margin(left: 12, right: 12, bottom: 12)
                    } else {
                        // 恢复全部 3 个活动的渲染
                        if (this.event1Title != "") {
                            Row {
                                Column { Text("活动").fontSize(18).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF) }.width(96).height(126).backgroundColor(0xFF7FAEFF).borderRadius(18).justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center).margin(right: 12)
                                Column {
                                    Row { Text(this.event1Status).fontSize(11).fontWeight(FontWeight.Bold).fontColor(0xFF2F80FF).backgroundColor(0xFFEAF2FF).padding(left: 8, right: 8, top: 4, bottom: 4).borderRadius(10); Row { }.layoutWeight(1); Text("查看").fontSize(12).fontColor(0xFF9AA6BD) }.width(100.percent).justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Center).margin(bottom: 8)
                                    Text(this.event1Title).fontSize(17).fontWeight(FontWeight.Bold).fontColor(0xFF24324A).margin(bottom: 6)
                                    Text(this.event1Description).fontSize(12).fontColor(0xFF6D7B99).lineHeight(18).maxLines(2).textOverflow(TextOverflow.Ellipsis).margin(bottom: 8)
                                    Text(this.event1Time).fontSize(12).fontColor(0xFF4E5D78).margin(bottom: 4)
                                    Row { Text(this.event1CapacityText).fontSize(11).fontColor(0xFF7C879C).margin(right: 10) }.width(100.percent).alignItems(VerticalAlign.Center)
                                }.layoutWeight(1).alignItems(HorizontalAlign.Start)
                            }.width(100.percent).padding(left: 12, right: 12, top: 12, bottom: 12).backgroundColor(0xFFFFFFFF).borderRadius(22).margin(left: 12, right: 12, bottom: 12)
                            .onClick({ _: ClickEvent => this.openEventDetail(this.event1Id, this.event1Title, this.event1Time, this.event1Location, this.event1Status, this.event1Description, this.event1CapacityText, this.event1DeadlineText) })
                        }
                        if (this.event2Title != "") {
                            Row {
                                Column { Text("局").fontSize(18).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF) }.width(96).height(126).backgroundColor(0xFF9CC3FF).borderRadius(18).justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center).margin(right: 12)
                                Column {
                                    Row { Text(this.event2Status).fontSize(11).fontWeight(FontWeight.Bold).fontColor(0xFF2F80FF).backgroundColor(0xFFEAF2FF).padding(left: 8, right: 8, top: 4, bottom: 4).borderRadius(10); Row { }.layoutWeight(1); Text("查看").fontSize(12).fontColor(0xFF9AA6BD) }.width(100.percent).justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Center).margin(bottom: 8)
                                    Text(this.event2Title).fontSize(17).fontWeight(FontWeight.Bold).fontColor(0xFF24324A).margin(bottom: 6)
                                    Text(this.event2Description).fontSize(12).fontColor(0xFF6D7B99).lineHeight(18).maxLines(2).textOverflow(TextOverflow.Ellipsis).margin(bottom: 8)
                                    Text(this.event2Time).fontSize(12).fontColor(0xFF4E5D78).margin(bottom: 4)
                                    Row { Text(this.event2CapacityText).fontSize(11).fontColor(0xFF7C879C).margin(right: 10) }.width(100.percent).alignItems(VerticalAlign.Center)
                                }.layoutWeight(1).alignItems(HorizontalAlign.Start)
                            }.width(100.percent).padding(left: 12, right: 12, top: 12, bottom: 12).backgroundColor(0xFFFFFFFF).borderRadius(22).margin(left: 12, right: 12, bottom: 12)
                            .onClick({ _: ClickEvent => this.openEventDetail(this.event2Id, this.event2Title, this.event2Time, this.event2Location, this.event2Status, this.event2Description, this.event2CapacityText, this.event2DeadlineText) })
                        }
                        if (this.event3Title != "") {
                            Row {
                                Column { Text("约").fontSize(18).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF) }.width(96).height(126).backgroundColor(0xFF5F9BFF).borderRadius(18).justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center).margin(right: 12)
                                Column {
                                    Row { Text(this.event3Status).fontSize(11).fontWeight(FontWeight.Bold).fontColor(0xFF2F80FF).backgroundColor(0xFFEAF2FF).padding(left: 8, right: 8, top: 4, bottom: 4).borderRadius(10); Row { }.layoutWeight(1); Text("查看").fontSize(12).fontColor(0xFF9AA6BD) }.width(100.percent).justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Center).margin(bottom: 8)
                                    Text(this.event3Title).fontSize(17).fontWeight(FontWeight.Bold).fontColor(0xFF24324A).margin(bottom: 6)
                                    Text(this.event3Description).fontSize(12).fontColor(0xFF6D7B99).lineHeight(18).maxLines(2).textOverflow(TextOverflow.Ellipsis).margin(bottom: 8)
                                    Text(this.event3Time).fontSize(12).fontColor(0xFF4E5D78).margin(bottom: 4)
                                    Row { Text(this.event3CapacityText).fontSize(11).fontColor(0xFF7C879C).margin(right: 10) }.width(100.percent).alignItems(VerticalAlign.Center)
                                }.layoutWeight(1).alignItems(HorizontalAlign.Start)
                            }.width(100.percent).padding(left: 12, right: 12, top: 12, bottom: 12).backgroundColor(0xFFFFFFFF).borderRadius(22).margin(left: 12, right: 12, bottom: 12)
                            .onClick({ _: ClickEvent => this.openEventDetail(this.event3Id, this.event3Title, this.event3Time, this.event3Location, this.event3Status, this.event3Description, this.event3CapacityText, this.event3DeadlineText) })
                        }
                    }
                }.width(100.percent).padding(left: 16, right: 16, top: 16, bottom: 96)
            }.layoutWeight(1)

            Row {
                Text("广场").layoutWeight(1).height(40).textAlign(TextAlign.Center).fontSize(14).fontColor(0xFF5E6C84).onClick({ _: ClickEvent => this.goToHomePage() })
                Text("圈子").layoutWeight(1).height(40).textAlign(TextAlign.Center).fontSize(14).fontColor(0xFF5E6C84).onClick({ _: ClickEvent => this.goToCirclesPage() })
                Text("+").width(52).height(52).backgroundColor(0xFF2F80FF).fontColor(0xFFFFFFFF).fontSize(28).fontWeight(FontWeight.Bold).borderRadius(26).textAlign(TextAlign.Center).margin(left: 6, right: 6).onClick({ _: ClickEvent => this.goToCreateEventPage() })
                Text("活动").layoutWeight(1).height(40).textAlign(TextAlign.Center).fontSize(14).fontWeight(FontWeight.Bold).fontColor(0xFF2F80FF)
                Text("我的").layoutWeight(1).height(40).textAlign(TextAlign.Center).fontSize(14).fontColor(0xFF5E6C84).onClick({ _: ClickEvent => this.goToProfilePage() })
            }.width(100.percent).padding(left: 10, right: 10, top: 10, bottom: 16).backgroundColor(0xFFFFFFFF)
        }.width(100.percent).height(100.percent).backgroundColor(0xFFF4F8FF)
    }
}
    */

package ohos_app_cangjie_entry.pages

internal import ohos.base.LengthProp
import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.router.*
import ohos_app_cangjie_entry.service.EventService
import cj_res_entry.app

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

    public func aboutToAppear(): Unit { if (!this.firstLoaded && !this.loading) { this.loadEvents() } }
    func goToHomePage() { Router.push(url: "HomePage") }
    func goToCirclesPage() { Router.push(url: "CirclesPage") }
    func goToProfilePage() { Router.push(url: "ProfilePage") }
    func goToCreateEventPage() { Router.push(url: "CreateEventPage") }
    func getRefreshButtonText(): String { return if (this.loading) { "刷新中..." } else { "刷新" } }
    func hasAnyEvent(): Bool { return this.event1Title != "" || this.event2Title != "" || this.event3Title != "" }

    func fillEvents(raw: String) {
        this.event1Id = EventService.extractEventField(raw, 0, "id")
        this.event1Title = EventService.extractEventField(raw, 0, "title")
        this.event1Time = EventService.extractEventField(raw, 0, "startTimeText")
        this.event1Location = EventService.extractEventField(raw, 0, "location")
        this.event1Status = if(EventService.extractEventField(raw, 0, "status")=="published"){"报名中"}else{"已结束"}
        this.event1Description = EventService.extractEventField(raw, 0, "description")
        this.event1CapacityText = "限 " + EventService.extractEventField(raw, 0, "capacity") + " 人"
        this.event1DeadlineText = "截止：" + EventService.extractEventField(raw, 0, "signupDeadline")

        this.event2Id = EventService.extractEventField(raw, 1, "id")
        this.event2Title = EventService.extractEventField(raw, 1, "title")
        this.event2Time = EventService.extractEventField(raw, 1, "startTimeText")
        this.event2Location = EventService.extractEventField(raw, 1, "location")
        this.event2Status = if(EventService.extractEventField(raw, 1, "status")=="published"){"报名中"}else{"已结束"}
        this.event2Description = EventService.extractEventField(raw, 1, "description")
        this.event2CapacityText = "限 " + EventService.extractEventField(raw, 1, "capacity") + " 人"
        this.event2DeadlineText = "截止：" + EventService.extractEventField(raw, 1, "signupDeadline")

        this.event3Id = EventService.extractEventField(raw, 2, "id")
        this.event3Title = EventService.extractEventField(raw, 2, "title")
        this.event3Time = EventService.extractEventField(raw, 2, "startTimeText")
        this.event3Location = EventService.extractEventField(raw, 2, "location")
        this.event3Status = if(EventService.extractEventField(raw, 2, "status")=="published"){"报名中"}else{"已结束"}
        this.event3Description = EventService.extractEventField(raw, 2, "description")
        this.event3CapacityText = "限 " + EventService.extractEventField(raw, 2, "capacity") + " 人"
        this.event3DeadlineText = "截止：" + EventService.extractEventField(raw, 2, "signupDeadline")
    }

    func loadEvents() {
        this.loading = true; this.errorMsg = ""
        EventService.getFeaturedEvents(
            { raw: String => this.fillEvents(raw); this.loading = false; this.firstLoaded = true },
            { msg: String => this.loading = false; this.firstLoaded = true; this.errorMsg = msg }
        )
    }

    func openEventDetail(id: String, title: String, time: String, location: String, status: String, description: String, capacityText: String, deadlineText: String) {
        EventService.setCurrentEventDetail(id, title, time, location, status, description, capacityText, deadlineText)
        Router.push(url: "EventDetailPage")
    }

    func build() {
        Column {
            Scroll {
                Column {
                    // --- 修改点1：将 Swiper 移到了最上方 ---
                    Swiper {
                        // --- 第1张照片：发起活动 ---
                        Stack {
                            Image(@r(app.media.activity)).width(100.percent).height(100.percent).objectFit(ImageFit.Cover)
                            Column {
                                Text("➕ 发起活动").fontSize(22).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF).margin(bottom: 6)
                                Text("组织一场新局，发布后会出现在列表中").fontSize(13).fontColor(0xFFDDEBFF)
                            }
                            .alignItems(HorizontalAlign.Center)
                            .backgroundColor(0x77000000) // 💡 替换为半透明黑底
                            .padding(left: 16, right: 16, top: 12, bottom: 12)
                            .borderRadius(12)
                        }.width(100.percent).height(100.percent).onClick({ _: ClickEvent => this.goToCreateEventPage() })

                        // --- 第2张照片：热门精选 ---
                        Stack {
                            Image(@r(app.media.earth)).width(100.percent).height(100.percent).objectFit(ImageFit.Cover)
                            Text("🔥 热门精选：点击查看热门活动")
                                .fontSize(18).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF)
                                .backgroundColor(0x77000000) // 💡 替换为半透明黑底
                                .padding(left: 16, right: 16, top: 10, bottom: 10)
                                .borderRadius(12)
                        }.width(100.percent).height(100.percent).onClick({ _: ClickEvent => if (this.event1Id != "") { this.openEventDetail(this.event1Id, this.event1Title, this.event1Time, this.event1Location, this.event1Status, this.event1Description, this.event1CapacityText, this.event1DeadlineText) } })

                        // --- 第3张照片：本周推荐 ---
                        Stack {
                            Image(@r(app.media.wolf)).width(100.percent).height(100.percent).objectFit(ImageFit.Cover)
                            Text("✨ 本周推荐：校园精品局速递")
                                .fontSize(18).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF)
                                .backgroundColor(0x77000000) // 💡 替换为半透明黑底
                                .padding(left: 16, right: 16, top: 10, bottom: 10)
                                .borderRadius(12)
                        }.width(100.percent).height(100.percent).onClick({ _: ClickEvent => if (this.event2Id != "") { this.openEventDetail(this.event2Id, this.event2Title, this.event2Time, this.event2Location, this.event2Status, this.event2Description, this.event2CapacityText, this.event2DeadlineText) } })
                    }.width(100.percent).height(180).autoPlay(true).interval(3000)

                    // 将原有的 "活动推荐" 标题下移至这里
                    Row { Text("活动推荐").fontSize(20).fontWeight(FontWeight.Bold).fontColor(0xFF24324A) }.width(100.percent).padding(left: 16, right: 16, top: 16, bottom: 8)

                    Row { Text("全部活动").fontSize(20).fontWeight(FontWeight.Bold).fontColor(0xFF24324A); Row { }.layoutWeight(1); Text(this.getRefreshButtonText()).fontSize(12).fontColor(0xFF2F80FF).backgroundColor(0xFFEAF2FF).padding(left: 12, right: 12, top: 7, bottom: 7).borderRadius(14).onClick({ _: ClickEvent => if (!this.loading) { this.loadEvents() } }) }.width(100.percent).padding(left: 16, right: 16, top: 12, bottom: 10).alignItems(VerticalAlign.Center)

                    if (this.errorMsg != "") { Column { Text("加载失败").fontSize(18).fontWeight(FontWeight.Bold).fontColor(0xFF24324A).margin(bottom: 8); Text(this.errorMsg).fontSize(13).fontColor(0xFFE96B6B) }.width(100.percent).padding(16).backgroundColor(0xFFFFFFFF).borderRadius(22).margin(left: 12, right: 12, bottom: 12) }

                    if (!this.firstLoaded && this.loading) {
                        Column { Text("正在加载活动...").fontSize(18).fontWeight(FontWeight.Bold).fontColor(0xFF24324A).margin(bottom: 8); Text("稍等一下，新的活动马上就来。").fontSize(13).fontColor(0xFF6D7B99) }.width(100.percent).padding(16).backgroundColor(0xFFFFFFFF).borderRadius(22).margin(left: 12, right: 12, bottom: 12)
                    } else if (!this.hasAnyEvent()) {
                        Column { Text("还没有活动").fontSize(18).fontWeight(FontWeight.Bold).fontColor(0xFF24324A).margin(bottom: 8); Text("你可以先发起一个活动，创建成功后就会显示在这里。").fontSize(13).fontColor(0xFF6D7B99).margin(bottom: 14); Text("去发起活动").fontSize(14).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF).width(100.percent).height(42).backgroundColor(0xFF2F80FF).borderRadius(14).textAlign(TextAlign.Center).onClick({ _: ClickEvent => this.goToCreateEventPage() }) }.width(100.percent).padding(16).backgroundColor(0xFFFFFFFF).borderRadius(22).margin(left: 12, right: 12, bottom: 12)
                    } else {
                        // 恢复全部 3 个活动的渲染
                        if (this.event1Title != "") {
                            Row {
                                Column { Text("活动").fontSize(18).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF) }.width(96).height(126).backgroundColor(0xFF7FAEFF).borderRadius(18).justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center).margin(right: 12)
                                Column {
                                    Row { Text(this.event1Status).fontSize(11).fontWeight(FontWeight.Bold).fontColor(0xFF2F80FF).backgroundColor(0xFFEAF2FF).padding(left: 8, right: 8, top: 4, bottom: 4).borderRadius(10); Row { }.layoutWeight(1); Text("查看").fontSize(12).fontColor(0xFF9AA6BD) }.width(100.percent).justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Center).margin(bottom: 8)
                                    Text(this.event1Title).fontSize(17).fontWeight(FontWeight.Bold).fontColor(0xFF24324A).margin(bottom: 6)
                                    Text(this.event1Description).fontSize(12).fontColor(0xFF6D7B99).lineHeight(18).maxLines(2).textOverflow(TextOverflow.Ellipsis).margin(bottom: 8)
                                    Text(this.event1Time).fontSize(12).fontColor(0xFF4E5D78).margin(bottom: 4)
                                    Row { Text(this.event1CapacityText).fontSize(11).fontColor(0xFF7C879C).margin(right: 10) }.width(100.percent).alignItems(VerticalAlign.Center)
                                }.layoutWeight(1).alignItems(HorizontalAlign.Start)
                            }.width(100.percent).padding(left: 12, right: 12, top: 12, bottom: 12).backgroundColor(0xFFFFFFFF).borderRadius(22).margin(left: 12, right: 12, bottom: 12)
                            .onClick({ _: ClickEvent => this.openEventDetail(this.event1Id, this.event1Title, this.event1Time, this.event1Location, this.event1Status, this.event1Description, this.event1CapacityText, this.event1DeadlineText) })
                        }
                        if (this.event2Title != "") {
                            Row {
                                Column { Text("局").fontSize(18).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF) }.width(96).height(126).backgroundColor(0xFF9CC3FF).borderRadius(18).justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center).margin(right: 12)
                                Column {
                                    Row { Text(this.event2Status).fontSize(11).fontWeight(FontWeight.Bold).fontColor(0xFF2F80FF).backgroundColor(0xFFEAF2FF).padding(left: 8, right: 8, top: 4, bottom: 4).borderRadius(10); Row { }.layoutWeight(1); Text("查看").fontSize(12).fontColor(0xFF9AA6BD) }.width(100.percent).justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Center).margin(bottom: 8)
                                    Text(this.event2Title).fontSize(17).fontWeight(FontWeight.Bold).fontColor(0xFF24324A).margin(bottom: 6)
                                    Text(this.event2Description).fontSize(12).fontColor(0xFF6D7B99).lineHeight(18).maxLines(2).textOverflow(TextOverflow.Ellipsis).margin(bottom: 8)
                                    Text(this.event2Time).fontSize(12).fontColor(0xFF4E5D78).margin(bottom: 4)
                                    Row { Text(this.event2CapacityText).fontSize(11).fontColor(0xFF7C879C).margin(right: 10) }.width(100.percent).alignItems(VerticalAlign.Center)
                                }.layoutWeight(1).alignItems(HorizontalAlign.Start)
                            }.width(100.percent).padding(left: 12, right: 12, top: 12, bottom: 12).backgroundColor(0xFFFFFFFF).borderRadius(22).margin(left: 12, right: 12, bottom: 12)
                            .onClick({ _: ClickEvent => this.openEventDetail(this.event2Id, this.event2Title, this.event2Time, this.event2Location, this.event2Status, this.event2Description, this.event2CapacityText, this.event2DeadlineText) })
                        }
                        if (this.event3Title != "") {
                            Row {
                                Column { Text("约").fontSize(18).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF) }.width(96).height(126).backgroundColor(0xFF5F9BFF).borderRadius(18).justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center).margin(right: 12)
                                Column {
                                    Row { Text(this.event3Status).fontSize(11).fontWeight(FontWeight.Bold).fontColor(0xFF2F80FF).backgroundColor(0xFFEAF2FF).padding(left: 8, right: 8, top: 4, bottom: 4).borderRadius(10); Row { }.layoutWeight(1); Text("查看").fontSize(12).fontColor(0xFF9AA6BD) }.width(100.percent).justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Center).margin(bottom: 8)
                                    Text(this.event3Title).fontSize(17).fontWeight(FontWeight.Bold).fontColor(0xFF24324A).margin(bottom: 6)
                                    Text(this.event3Description).fontSize(12).fontColor(0xFF6D7B99).lineHeight(18).maxLines(2).textOverflow(TextOverflow.Ellipsis).margin(bottom: 8)
                                    Text(this.event3Time).fontSize(12).fontColor(0xFF4E5D78).margin(bottom: 4)
                                    Row { Text(this.event3CapacityText).fontSize(11).fontColor(0xFF7C879C).margin(right: 10) }.width(100.percent).alignItems(VerticalAlign.Center)
                                }.layoutWeight(1).alignItems(HorizontalAlign.Start)
                            }.width(100.percent).padding(left: 12, right: 12, top: 12, bottom: 12).backgroundColor(0xFFFFFFFF).borderRadius(22).margin(left: 12, right: 12, bottom: 12)
                            .onClick({ _: ClickEvent => this.openEventDetail(this.event3Id, this.event3Title, this.event3Time, this.event3Location, this.event3Status, this.event3Description, this.event3CapacityText, this.event3DeadlineText) })
                        }
                    }
                // --- 修改点3：将原本的 top: 16 改为了 top: 0，确保推到画面最上方边界 ---
                }.width(100.percent).padding(left: 16, right: 16, top: 0, bottom: 96)
            }.layoutWeight(1)

            Row {
                Text("广场").layoutWeight(1).height(40).textAlign(TextAlign.Center).fontSize(14).fontColor(0xFF5E6C84).onClick({ _: ClickEvent => this.goToHomePage() })
                Text("圈子").layoutWeight(1).height(40).textAlign(TextAlign.Center).fontSize(14).fontColor(0xFF5E6C84).onClick({ _: ClickEvent => this.goToCirclesPage() })
                Text("+").width(52).height(52).backgroundColor(0xFF2F80FF).fontColor(0xFFFFFFFF).fontSize(28).fontWeight(FontWeight.Bold).borderRadius(26).textAlign(TextAlign.Center).margin(left: 6, right: 6).onClick({ _: ClickEvent => this.goToCreateEventPage() })
                Text("活动").layoutWeight(1).height(40).textAlign(TextAlign.Center).fontSize(14).fontWeight(FontWeight.Bold).fontColor(0xFF2F80FF)
                Text("我的").layoutWeight(1).height(40).textAlign(TextAlign.Center).fontSize(14).fontColor(0xFF5E6C84).onClick({ _: ClickEvent => this.goToProfilePage() })
            }.width(100.percent).padding(left: 10, right: 10, top: 10, bottom: 16).backgroundColor(0xFFFFFFFF)
        }.width(100.percent).height(100.percent).backgroundColor(0xFFF4F8FF)
    }
}