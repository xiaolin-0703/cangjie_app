
package ohos_app_cangjie_entry.pages

internal import ohos.base.LengthProp
import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.router.*
import ohos_app_cangjie_entry.service.CircleService
// 💡 必须引入集合库，才能使用可以无限延长的 ArrayList
import std.collection.*

public class CircleData {
    public var id: String = ""
    public var name: String = ""
    public var desc: String = ""
    public var memberText: String = ""
    public var joined: String = "false"
    public var post1Image: String = ""
    public var post2Image: String = ""
    public var post3Image: String = ""

    public init(id: String, name: String, desc: String, memberText: String, joined: String, post1: String, post2: String, post3: String) {
        this.id = id
        this.name = name
        this.desc = desc
        this.memberText = memberText
        this.joined = joined
        this.post1Image = post1
        this.post2Image = post2
        this.post3Image = post3
    }
}

@Entry
@Component
class CirclesPage {
    @State var loading: Bool = false
    @State var firstLoaded: Bool = false
    @State var errorMsg: String = ""

    @State var myCircles: ArrayList<CircleData> = ArrayList<CircleData>()
    @State var discoverCircles: ArrayList<CircleData> = ArrayList<CircleData>()

    public func aboutToAppear(): Unit {
        if (!this.firstLoaded && !this.loading) {
            this.loadCircles()
        }
    }

    func getRefreshButtonText(): String { return if (this.loading) { "刷新中..." } else { "刷新" } }
    func getJoinButtonText(joined: String): String { return if (joined == "true") { "已加入" } else { "+ 加入" } }

    func hasAnyCircle(): Bool {
        return this.myCircles.size > 0 || this.discoverCircles.size > 0
    }

    func fillCircles(raw: String) {
        let newMyCircles = ArrayList<CircleData>()
        let newDiscoverCircles = ArrayList<CircleData>()

        var i: Int64 = 0
        while (true) {
            let id = CircleService.extractCircleField(raw, i, "id")
            if (id == "") {
                break
            }

            let name = CircleService.extractCircleField(raw, i, "name")
            let desc = CircleService.extractCircleField(raw, i, "description")
            let memberText = CircleService.formatMemberText(CircleService.extractCircleField(raw, i, "memberCount"))
            let joined = CircleService.extractCircleField(raw, i, "joined")
            let post1Image = CircleService.extractCircleField(raw, i, "post1ImageUrl")
            let post2Image = CircleService.extractCircleField(raw, i, "post2ImageUrl")
            let post3Image = CircleService.extractCircleField(raw, i, "post3ImageUrl")

            let circle = CircleData(id, name, desc, memberText, joined, post1Image, post2Image, post3Image)

            if (joined == "true") {
                newMyCircles.append(circle)
            } else {
                newDiscoverCircles.append(circle)
            }
            i++
        }

        this.myCircles = newMyCircles
        this.discoverCircles = newDiscoverCircles
    }

    func loadCircles() {
        this.loading = true; this.errorMsg = ""
        CircleService.getCircles(
            { raw: String => this.fillCircles(raw); this.loading = false; this.firstLoaded = true },
            { msg: String => this.loading = false; this.firstLoaded = true; this.errorMsg = msg }
        )
    }

    func joinCircle(circleId: String) {
        var targetIndex: Int64 = -1

        var i: Int64 = 0
        while (i < this.discoverCircles.size) {
            if (this.discoverCircles[i].id == circleId) {
                targetIndex = i
                break
            }
            i++
        }

        if (targetIndex != -1) {
            let c = this.discoverCircles[targetIndex]

            c.joined = "true"
            this.discoverCircles.remove(targetIndex) // 从发现列表拿走
            this.myCircles.append(c)                 // 放到我的列表

            let refreshDiscover = ArrayList<CircleData>()
            refreshDiscover.appendAll(this.discoverCircles)
            this.discoverCircles = refreshDiscover

            let refreshMy = ArrayList<CircleData>()
            refreshMy.appendAll(this.myCircles)
            this.myCircles = refreshMy
        }

        CircleService.joinCircle(
            circleId,
            { _: String => },
            { msg: String => this.errorMsg = msg }
        )
    }

    func openCircleDetail(circleId: String, circleName: String, circleDesc: String, circleMemberText: String, circleJoined: String) {
        CircleService.setCurrentCircleDetail(circleId, circleName, circleDesc, circleMemberText, circleJoined)
        Router.push(url: "CircleDetailPage")
    }

    func goToHomePage() { Router.push(url: "HomePage") }
    func goToEventsPage() { Router.push(url: "EventsPage") }
    func goToProfilePage() { Router.push(url: "ProfilePage") }
    func goToCreateCirclePage() { Router.push(url: "CreateCirclePage") }

    func build() {
        Column {
            List {
                if (this.errorMsg != "") {
                    ListItem {
                        Column { Text("加载失败").fontSize(17).fontWeight(FontWeight.Bold).fontColor(0xFF24324A).margin(bottom: 8); Text(this.errorMsg).fontSize(13).fontColor(0xFFE96B6B) }.width(100.percent).padding(16).backgroundColor(0xFFFFFFFF).borderRadius(18).margin(bottom: 14)
                    }
                }

                if (!this.firstLoaded && this.loading) {
                    ListItem {
                        Column { Text("正在加载圈子...").fontSize(18).fontWeight(FontWeight.Bold).fontColor(0xFF1E2B45).margin(bottom: 8); Text("稍等一下，圈子列表马上就来。").fontSize(13).fontColor(0xFF7B879A) }.width(100.percent).padding(18).backgroundColor(0xFFFFFFFF).borderRadius(18).margin(bottom: 14)
                    }
                }

                ListItem {
                    Row {
                        Text("我的圈子").fontSize(24).fontWeight(FontWeight.Bold).fontColor(0xFF1E2B45).layoutWeight(1)
                        Text("创建圈子").fontSize(13).fontColor(0xFF2F80FF).onClick({ _: ClickEvent => Router.push(url: "CreateCirclePage") })
                    }.width(100.percent).margin(bottom: 12).alignItems(VerticalAlign.Center)
                }

                if (this.myCircles.size == 0) {
                    ListItem {
                        Column {
                            Text("你还没有加入圈子").fontSize(17).fontWeight(FontWeight.Bold).fontColor(0xFF1E2B45).margin(bottom: 8)
                            Text("可以先创建一个新圈子，或者去下面发现感兴趣的圈子。").fontSize(13).fontColor(0xFF7B879A).margin(bottom: 14)
                            Row { Text("+ 创建圈子").fontSize(13).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF).backgroundColor(0xFF2F80FF).padding(left: 14, right: 14, top: 9, bottom: 9).borderRadius(16).margin(right: 10).onClick({ _: ClickEvent => Router.push(url: "CreateCirclePage") }); Text("去发现").fontSize(13).fontColor(0xFF2F80FF).backgroundColor(0xFFEAF2FF).padding(left: 14, right: 14, top: 9, bottom: 9).borderRadius(16) }.width(100.percent)
                        }.width(100.percent).padding(16).backgroundColor(0xFFFFFFFF).borderRadius(18).margin(bottom: 22)
                    }
                } else {
                    ForEach(this.myCircles, { item: CircleData, index: Int64 =>
                        ListItem {
                            Column {
                                Row {
                                    Row {
                                        Column { Text("圈").fontSize(18).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF) }.width(54).height(54).backgroundColor(0xFF7FAEFF).borderRadius(14).justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center).margin(right: 12)
                                        Column { Text(item.name).fontSize(18).fontWeight(FontWeight.Bold).fontColor(0xFF1E2B45).margin(bottom: 4); Text(item.memberText).fontSize(12).fontColor(0xFF7B879A) }.layoutWeight(1).alignItems(HorizontalAlign.Start)
                                    }.layoutWeight(1)
                                    Text("进入").fontSize(13).fontColor(0xFF2F80FF).backgroundColor(0xFFEAF2FF).padding(left: 12, right: 12, top: 8, bottom: 8).borderRadius(14).onClick({ _: ClickEvent => this.openCircleDetail(item.id, item.name, item.desc, item.memberText, item.joined) })
                                }.width(100.percent).margin(bottom: 10).alignItems(VerticalAlign.Center)
                                Text(item.desc).fontSize(13).fontColor(0xFF5A6A85)
                            }.width(100.percent).padding(16).backgroundColor(0xFFFFFFFF).borderRadius(18).margin(bottom: 12)
                        }
                    })
                }
                ListItem {
                    Row {
                        Text("发现圈子").fontSize(24).fontWeight(FontWeight.Bold).fontColor(0xFF1E2B45).layoutWeight(1)
                        Row { Text("⌕").fontSize(16).fontWeight(FontWeight.Bold).fontColor(0xFF2F80FF) }.width(34).height(34).backgroundColor(0xFFEAF2FF).borderRadius(17).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)
                    }.width(100.percent).margin(top: 10, bottom: 12).alignItems(VerticalAlign.Center)
                }

                if (!this.hasAnyCircle()) {
                    ListItem {
                        Column { Text("暂时还没有圈子").fontSize(18).fontWeight(FontWeight.Bold).fontColor(0xFF1E2B45).margin(bottom: 8); Text("你可以先创建第一个圈子，后面这里会显示真实圈子。").fontSize(13).fontColor(0xFF7B879A).margin(bottom: 14); Text("+ 创建圈子").fontSize(14).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF).backgroundColor(0xFF2F80FF).padding(left: 16, right: 16, top: 10, bottom: 10).borderRadius(16).onClick({ _: ClickEvent => Router.push(url: "CreateCirclePage") }) }.width(100.percent).padding(18).backgroundColor(0xFFFFFFFF).borderRadius(18).margin(bottom: 18)
                    }
                } else if (this.discoverCircles.size == 0) {
                    ListItem {
                        Column { Text("当前可发现的圈子都已经加入了").fontSize(17).fontWeight(FontWeight.Bold).fontColor(0xFF1E2B45).margin(bottom: 8); Text("可以创建新圈子，或者等待新的圈子出现。").fontSize(13).fontColor(0xFF7B879A) }.width(100.percent).padding(18).backgroundColor(0xFFFFFFFF).borderRadius(18).margin(bottom: 18)
                    }
                } else {
                    // 💡 循环渲染“发现圈子”
                    ForEach(this.discoverCircles, { item: CircleData, index: Int64 =>
                        ListItem {
                            Column {
                                Row {
                                    Row {
                                        Column { Text("圈").fontSize(18).fontWeight(FontWeight.Bold).fontColor(0xFFFFFFFF) }.width(58).height(58).backgroundColor(0xFF7FAEFF).borderRadius(14).justifyContent(FlexAlign.Center).alignItems(HorizontalAlign.Center).margin(right: 12)
                                        Column { Text(item.name).fontSize(18).fontWeight(FontWeight.Bold).fontColor(0xFF1E2B45).margin(bottom: 4); Text(item.memberText).fontSize(12).fontColor(0xFF7B879A) }.layoutWeight(1).alignItems(HorizontalAlign.Start)
                                    }.layoutWeight(1)
                                    Text(this.getJoinButtonText(item.joined)).fontSize(13).fontWeight(FontWeight.Bold).fontColor(0xFF2F80FF).backgroundColor(0xFFEAF2FF).padding(left: 14, right: 14, top: 9, bottom: 9).borderRadius(16).onClick({ _: ClickEvent => this.joinCircle(item.id) })
                                }.width(100.percent).margin(bottom: 10).alignItems(VerticalAlign.Center)

                                Text(item.desc).fontSize(13).fontColor(0xFF5A6A85).margin(bottom: 12)

                                Row {
                                    if (item.post1Image != "") { Image(item.post1Image).layoutWeight(1).height(80).objectFit(ImageFit.Cover).borderRadius(12).margin(right: 6) }
                                    else { Column { }.layoutWeight(1).height(80).backgroundColor(0xFFEAF2FF).borderRadius(12).margin(right: 6) }

                                    if (item.post2Image != "") { Image(item.post2Image).layoutWeight(1).height(80).objectFit(ImageFit.Cover).borderRadius(12).margin(right: 6) }
                                    else { Column { }.layoutWeight(1).height(80).backgroundColor(0xFFDDEBFF).borderRadius(12).margin(right: 6) }

                                    if (item.post3Image != "") { Image(item.post3Image).layoutWeight(1).height(80).objectFit(ImageFit.Cover).borderRadius(12) }
                                    else { Column { }.layoutWeight(1).height(80).backgroundColor(0xFFC9DFFF).borderRadius(12) }
                                }.width(100.percent).margin(bottom: 12)

                                Text("查看圈子详情 >").fontSize(13).fontColor(0xFF2F80FF).onClick({ _: ClickEvent => this.openCircleDetail(item.id, item.name, item.desc, item.memberText, item.joined) })
                            }.width(100.percent).padding(16).backgroundColor(0xFFFFFFFF).borderRadius(18).margin(bottom: 14)
                        }
                    })
                }
            }
            .layoutWeight(1)
            .width(100.percent)
            .padding(left: 16, right: 16, top: 16, bottom: 0)

            Row {
                Row { Text("广场").fontColor(0xFF5E6C84).fontSize(15).onClick({ _: ClickEvent => this.goToHomePage() }) }.layoutWeight(1).height(40).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)
                Row { Text("圈子").fontColor(0xFF2F80FF).fontWeight(FontWeight.Bold).fontSize(15) }.layoutWeight(1).height(40).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)
                Button("+").width(52).height(52).backgroundColor(0xFF2F80FF).fontColor(0xFFFFFFFF).fontSize(28).fontWeight(FontWeight.Bold).borderRadius(26).margin(left: 6, right: 6).onClick({ _: ClickEvent => this.goToCreateCirclePage() })
                Row { Text("活动").fontColor(0xFF5E6C84).fontSize(15).onClick({ _: ClickEvent => this.goToEventsPage() }) }.layoutWeight(1).height(40).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)
                Row { Text("我的").fontColor(0xFF5E6C84).fontSize(15).onClick({ _: ClickEvent => this.goToProfilePage() }) }.layoutWeight(1).height(40).justifyContent(FlexAlign.Center).alignItems(VerticalAlign.Center)
            }.alignItems(VerticalAlign.Center).width(100.percent).padding(left: 10, right: 10, top: 10, bottom: 16).backgroundColor(0xFFFFFFFF)
        }.width(100.percent).height(100.percent).backgroundColor(0xFFF4F8FF)
    }
}