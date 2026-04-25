
package ohos_app_cangjie_entry.pages

internal import ohos.base.LengthProp
import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.router.*
import ohos_app_cangjie_entry.service.CircleService

@Entry
@Component
class CirclesPage {
    @State var loading: Bool = false
    @State var firstLoaded: Bool = false
    @State var errorMsg: String = ""

    @State var circle1Id: String = ""
    @State var circle1Name: String = ""
    @State var circle1Desc: String = ""
    @State var circle1MemberText: String = ""
    @State var circle1Joined: String = "false"

    @State var circle2Id: String = ""
    @State var circle2Name: String = ""
    @State var circle2Desc: String = ""
    @State var circle2MemberText: String = ""
    @State var circle2Joined: String = "false"

    @State var circle3Id: String = ""
    @State var circle3Name: String = ""
    @State var circle3Desc: String = ""
    @State var circle3MemberText: String = ""
    @State var circle3Joined: String = "false"

    @State var circle4Id: String = ""
    @State var circle4Name: String = ""
    @State var circle4Desc: String = ""
    @State var circle4MemberText: String = ""
    @State var circle4Joined: String = "false"

    @State var circle5Id: String = ""
    @State var circle5Name: String = ""
    @State var circle5Desc: String = ""
    @State var circle5MemberText: String = ""
    @State var circle5Joined: String = "false"

    public func aboutToAppear(): Unit {
        if (!this.firstLoaded && !this.loading) {
            this.loadCircles()
        }
    }

    func getRefreshButtonText(): String {
        if (this.loading) {
            return "刷新中..."
        }
        return "刷新"
    }

    func getJoinButtonText(joined: String): String {
        if (joined == "true") {
            return "已加入"
        }
        return "+ 加入"
    }

    func clearCircles() {
        this.circle1Id = ""
        this.circle1Name = ""
        this.circle1Desc = ""
        this.circle1MemberText = ""
        this.circle1Joined = "false"

        this.circle2Id = ""
        this.circle2Name = ""
        this.circle2Desc = ""
        this.circle2MemberText = ""
        this.circle2Joined = "false"

        this.circle3Id = ""
        this.circle3Name = ""
        this.circle3Desc = ""
        this.circle3MemberText = ""
        this.circle3Joined = "false"

        this.circle4Id = ""
        this.circle4Name = ""
        this.circle4Desc = ""
        this.circle4MemberText = ""
        this.circle4Joined = "false"

        this.circle5Id = ""
        this.circle5Name = ""
        this.circle5Desc = ""
        this.circle5MemberText = ""
        this.circle5Joined = "false"
    }

    func hasAnyCircle(): Bool {
        return this.circle1Name != "" ||
            this.circle2Name != "" ||
            this.circle3Name != "" ||
            this.circle4Name != "" ||
            this.circle5Name != ""
    }

    func hasJoinedCircle(): Bool {
        return (this.circle1Name != "" && this.circle1Joined == "true") ||
            (this.circle2Name != "" && this.circle2Joined == "true") ||
            (this.circle3Name != "" && this.circle3Joined == "true") ||
            (this.circle4Name != "" && this.circle4Joined == "true") ||
            (this.circle5Name != "" && this.circle5Joined == "true")
    }

    func hasDiscoverCircle(): Bool {
        return (this.circle1Name != "" && this.circle1Joined != "true") ||
            (this.circle2Name != "" && this.circle2Joined != "true") ||
            (this.circle3Name != "" && this.circle3Joined != "true") ||
            (this.circle4Name != "" && this.circle4Joined != "true") ||
            (this.circle5Name != "" && this.circle5Joined != "true")
    }

    func fillCircles(raw: String) {
        this.clearCircles()

        this.circle1Id = CircleService.extractCircleField(raw, 0, "id")
        this.circle1Name = CircleService.extractCircleField(raw, 0, "name")
        this.circle1Desc = CircleService.extractCircleField(raw, 0, "description")
        this.circle1MemberText = CircleService.formatMemberText(
            CircleService.extractCircleField(raw, 0, "memberCount")
        )
        this.circle1Joined = CircleService.extractCircleField(raw, 0, "joined")

        this.circle2Id = CircleService.extractCircleField(raw, 1, "id")
        this.circle2Name = CircleService.extractCircleField(raw, 1, "name")
        this.circle2Desc = CircleService.extractCircleField(raw, 1, "description")
        this.circle2MemberText = CircleService.formatMemberText(
            CircleService.extractCircleField(raw, 1, "memberCount")
        )
        this.circle2Joined = CircleService.extractCircleField(raw, 1, "joined")

        this.circle3Id = CircleService.extractCircleField(raw, 2, "id")
        this.circle3Name = CircleService.extractCircleField(raw, 2, "name")
        this.circle3Desc = CircleService.extractCircleField(raw, 2, "description")
        this.circle3MemberText = CircleService.formatMemberText(
            CircleService.extractCircleField(raw, 2, "memberCount")
        )
        this.circle3Joined = CircleService.extractCircleField(raw, 2, "joined")

        this.circle4Id = CircleService.extractCircleField(raw, 3, "id")
        this.circle4Name = CircleService.extractCircleField(raw, 3, "name")
        this.circle4Desc = CircleService.extractCircleField(raw, 3, "description")
        this.circle4MemberText = CircleService.formatMemberText(
            CircleService.extractCircleField(raw, 3, "memberCount")
        )
        this.circle4Joined = CircleService.extractCircleField(raw, 3, "joined")

        this.circle5Id = CircleService.extractCircleField(raw, 4, "id")
        this.circle5Name = CircleService.extractCircleField(raw, 4, "name")
        this.circle5Desc = CircleService.extractCircleField(raw, 4, "description")
        this.circle5MemberText = CircleService.formatMemberText(
            CircleService.extractCircleField(raw, 4, "memberCount")
        )
        this.circle5Joined = CircleService.extractCircleField(raw, 4, "joined")
    }

    func loadCircles() {
        this.loading = true
        this.errorMsg = ""

        CircleService.getCircles(
            { raw: String =>
                this.fillCircles(raw)
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

    func joinCircle(circleId: String, index: Int64) {
        CircleService.joinCircle(
            circleId,
            { _: String =>
                if (index == 1) {
                    this.circle1Joined = "true"
                }
                if (index == 2) {
                    this.circle2Joined = "true"
                }
                if (index == 3) {
                    this.circle3Joined = "true"
                }
                if (index == 4) {
                    this.circle4Joined = "true"
                }
                if (index == 5) {
                    this.circle5Joined = "true"
                }
                this.loadCircles()
            },
            { msg: String =>
                this.errorMsg = msg
            }
        )
    }

    func openCircleDetail(
        circleId: String,
        circleName: String,
        circleDesc: String,
        circleMemberText: String,
        circleJoined: String
    ) {
        CircleService.setCurrentCircleDetail(
            circleId,
            circleName,
            circleDesc,
            circleMemberText,
            circleJoined
        )
        Router.push(url: "CircleDetailPage")
    }



    func goToHomePage() {
        Router.push(url: "HomePage")
    }

    func goToEventsPage() {
        Router.push(url: "EventsPage")
    }

    func goToProfilePage() {
        Router.push(url: "ProfilePage")
    }

    func goToCreateCirclePage() {
        Router.push(url: "CreateCirclePage")
    }

    func build() {
        Column {
            Scroll {
                Column {
                    if (this.errorMsg != "") {
                        Column {
                            Text("加载失败")
                                .fontSize(17)
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
                        .margin(bottom: 14)
                    }

                    if (!this.firstLoaded && this.loading) {
                        Column {
                            Text("正在加载圈子...")
                                .fontSize(18)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF1E2B45)
                                .margin(bottom: 8)

                            Text("稍等一下，圈子列表马上就来。")
                                .fontSize(13)
                                .fontColor(0xFF7B879A)
                        }
                        .width(100.percent)
                        .padding(18)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 14)
                    }

                    Row {
                        Text("我的圈子")
                            .fontSize(24)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFF1E2B45)
                            .layoutWeight(1)

                        Text("创建圈子")
                            .fontSize(13)
                            .fontColor(0xFF2F80FF)
                            .onClick({ _: ClickEvent =>
                                Router.push(url: "CreateCirclePage")
                            })
                    }
                    .width(100.percent)
                    .margin(bottom: 12)
                    .alignItems(VerticalAlign.Center)

                    if (!this.hasJoinedCircle()) {
                        Column {
                            Text("你还没有加入圈子")
                                .fontSize(17)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF1E2B45)
                                .margin(bottom: 8)

                            Text("可以先创建一个新圈子，或者去下面发现感兴趣的圈子。")
                                .fontSize(13)
                                .fontColor(0xFF7B879A)
                                .margin(bottom: 14)

                            Row {
                                Text("+ 创建圈子")
                                    .fontSize(13)
                                    .fontWeight(FontWeight.Bold)
                                    .fontColor(0xFFFFFFFF)
                                    .backgroundColor(0xFF2F80FF)
                                    .padding(left: 14, right: 14, top: 9, bottom: 9)
                                    .borderRadius(16)
                                    .margin(right: 10)
                                    .onClick({ _: ClickEvent =>
                                        Router.push(url: "CreateCirclePage")
                                    })

                                Text("去发现")
                                    .fontSize(13)
                                    .fontColor(0xFF2F80FF)
                                    .backgroundColor(0xFFEAF2FF)
                                    .padding(left: 14, right: 14, top: 9, bottom: 9)
                                    .borderRadius(16)
                            }
                            .width(100.percent)
                        }
                        .width(100.percent)
                        .padding(16)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 22)
                    } else {
                        if (this.circle1Name != "" && this.circle1Joined == "true") {
                            Column {
                                Row {
                                    Row {
                                        Column {
                                            Text("圈")
                                                .fontSize(18)
                                                .fontWeight(FontWeight.Bold)
                                                .fontColor(0xFFFFFFFF)
                                        }
                                        .width(54)
                                        .height(54)
                                        .backgroundColor(0xFF7FAEFF)
                                        .borderRadius(14)
                                        .justifyContent(FlexAlign.Center)
                                        .alignItems(HorizontalAlign.Center)
                                        .margin(right: 12)

                                        Column {
                                            Text(this.circle1Name)
                                                .fontSize(18)
                                                .fontWeight(FontWeight.Bold)
                                                .fontColor(0xFF1E2B45)
                                                .margin(bottom: 4)

                                            Text(this.circle1MemberText)
                                                .fontSize(12)
                                                .fontColor(0xFF7B879A)
                                        }
                                        .layoutWeight(1)
                                        .alignItems(HorizontalAlign.Start)
                                    }
                                    .layoutWeight(1)

                                    Text("进入")
                                        .fontSize(13)
                                        .fontColor(0xFF2F80FF)
                                        .backgroundColor(0xFFEAF2FF)
                                        .padding(left: 12, right: 12, top: 8, bottom: 8)
                                        .borderRadius(14)
                                        .onClick({ _: ClickEvent =>
                                            this.openCircleDetail(
                                                this.circle1Id,
                                                this.circle1Name,
                                                this.circle1Desc,
                                                this.circle1MemberText,
                                                this.circle1Joined
                                            )
                                        })
                                }
                                .width(100.percent)
                                .margin(bottom: 10)
                                .alignItems(VerticalAlign.Center)

                                Text(this.circle1Desc)
                                    .fontSize(13)
                                    .fontColor(0xFF5A6A85)
                            }
                            .width(100.percent)
                            .padding(16)
                            .backgroundColor(0xFFFFFFFF)
                            .borderRadius(18)
                            .margin(bottom: 12)
                        }

                        if (this.circle2Name != "" && this.circle2Joined == "true") {
                            Column {
                                Row {
                                    Row {
                                        Column {
                                            Text("圈")
                                                .fontSize(18)
                                                .fontWeight(FontWeight.Bold)
                                                .fontColor(0xFFFFFFFF)
                                        }
                                        .width(54)
                                        .height(54)
                                        .backgroundColor(0xFF8BB6FF)
                                        .borderRadius(14)
                                        .justifyContent(FlexAlign.Center)
                                        .alignItems(HorizontalAlign.Center)
                                        .margin(right: 12)

                                        Column {
                                            Text(this.circle2Name)
                                                .fontSize(18)
                                                .fontWeight(FontWeight.Bold)
                                                .fontColor(0xFF1E2B45)
                                                .margin(bottom: 4)

                                            Text(this.circle2MemberText)
                                                .fontSize(12)
                                                .fontColor(0xFF7B879A)
                                        }
                                        .layoutWeight(1)
                                        .alignItems(HorizontalAlign.Start)
                                    }
                                    .layoutWeight(1)

                                    Text("进入")
                                        .fontSize(13)
                                        .fontColor(0xFF2F80FF)
                                        .backgroundColor(0xFFEAF2FF)
                                        .padding(left: 12, right: 12, top: 8, bottom: 8)
                                        .borderRadius(14)
                                        .onClick({ _: ClickEvent =>
                                            this.openCircleDetail(
                                                this.circle2Id,
                                                this.circle2Name,
                                                this.circle2Desc,
                                                this.circle2MemberText,
                                                this.circle2Joined
                                            )
                                        })
                                }
                                .width(100.percent)
                                .margin(bottom: 10)
                                .alignItems(VerticalAlign.Center)

                                Text(this.circle2Desc)
                                    .fontSize(13)
                                    .fontColor(0xFF5A6A85)
                            }
                            .width(100.percent)
                            .padding(16)
                            .backgroundColor(0xFFFFFFFF)
                            .borderRadius(18)
                            .margin(bottom: 12)
                        }

                        if (this.circle3Name != "" && this.circle3Joined == "true") {
                            Column {
                                Row {
                                    Row {
                                        Column {
                                            Text("圈")
                                                .fontSize(18)
                                                .fontWeight(FontWeight.Bold)
                                                .fontColor(0xFFFFFFFF)
                                        }
                                        .width(54)
                                        .height(54)
                                        .backgroundColor(0xFF7FAEFF)
                                        .borderRadius(14)
                                        .justifyContent(FlexAlign.Center)
                                        .alignItems(HorizontalAlign.Center)
                                        .margin(right: 12)

                                        Column {
                                            Text(this.circle3Name)
                                                .fontSize(18)
                                                .fontWeight(FontWeight.Bold)
                                                .fontColor(0xFF1E2B45)
                                                .margin(bottom: 4)

                                            Text(this.circle3MemberText)
                                                .fontSize(12)
                                                .fontColor(0xFF7B879A)
                                        }
                                        .layoutWeight(1)
                                        .alignItems(HorizontalAlign.Start)
                                    }
                                    .layoutWeight(1)

                                    Text("进入")
                                        .fontSize(13)
                                        .fontColor(0xFF2F80FF)
                                        .backgroundColor(0xFFEAF2FF)
                                        .padding(left: 12, right: 12, top: 8, bottom: 8)
                                        .borderRadius(14)
                                        .onClick({ _: ClickEvent =>
                                            this.openCircleDetail(
                                                this.circle3Id,
                                                this.circle3Name,
                                                this.circle3Desc,
                                                this.circle3MemberText,
                                                this.circle3Joined
                                            )
                                        })
                                }
                                .width(100.percent)
                                .margin(bottom: 10)
                                .alignItems(VerticalAlign.Center)

                                Text(this.circle3Desc)
                                    .fontSize(13)
                                    .fontColor(0xFF5A6A85)
                            }
                            .width(100.percent)
                            .padding(16)
                            .backgroundColor(0xFFFFFFFF)
                            .borderRadius(18)
                            .margin(bottom: 12)
                        }

                        if (this.circle4Name != "" && this.circle4Joined == "true") {
                            Column {
                                Row {
                                    Row {
                                        Column {
                                            Text("圈")
                                                .fontSize(18)
                                                .fontWeight(FontWeight.Bold)
                                                .fontColor(0xFFFFFFFF)
                                        }
                                        .width(54)
                                        .height(54)
                                        .backgroundColor(0xFF6CA3FF)
                                        .borderRadius(14)
                                        .justifyContent(FlexAlign.Center)
                                        .alignItems(HorizontalAlign.Center)
                                        .margin(right: 12)

                                        Column {
                                            Text(this.circle4Name)
                                                .fontSize(18)
                                                .fontWeight(FontWeight.Bold)
                                                .fontColor(0xFF1E2B45)
                                                .margin(bottom: 4)

                                            Text(this.circle4MemberText)
                                                .fontSize(12)
                                                .fontColor(0xFF7B879A)
                                        }
                                        .layoutWeight(1)
                                        .alignItems(HorizontalAlign.Start)
                                    }
                                    .layoutWeight(1)

                                    Text("进入")
                                        .fontSize(13)
                                        .fontColor(0xFF2F80FF)
                                        .backgroundColor(0xFFEAF2FF)
                                        .padding(left: 12, right: 12, top: 8, bottom: 8)
                                        .borderRadius(14)
                                        .onClick({ _: ClickEvent =>
                                            this.openCircleDetail(
                                                this.circle4Id,
                                                this.circle4Name,
                                                this.circle4Desc,
                                                this.circle4MemberText,
                                                this.circle4Joined
                                            )
                                        })
                                }
                                .width(100.percent)
                                .margin(bottom: 10)
                                .alignItems(VerticalAlign.Center)

                                Text(this.circle4Desc)
                                    .fontSize(13)
                                    .fontColor(0xFF5A6A85)
                            }
                            .width(100.percent)
                            .padding(16)
                            .backgroundColor(0xFFFFFFFF)
                            .borderRadius(18)
                            .margin(bottom: 12)
                        }

                        if (this.circle5Name != "" && this.circle5Joined == "true") {
                            Column {
                                Row {
                                    Row {
                                        Column {
                                            Text("圈")
                                                .fontSize(18)
                                                .fontWeight(FontWeight.Bold)
                                                .fontColor(0xFFFFFFFF)
                                        }
                                        .width(54)
                                        .height(54)
                                        .backgroundColor(0xFF5A96FF)
                                        .borderRadius(14)
                                        .justifyContent(FlexAlign.Center)
                                        .alignItems(HorizontalAlign.Center)
                                        .margin(right: 12)

                                        Column {
                                            Text(this.circle5Name)
                                                .fontSize(18)
                                                .fontWeight(FontWeight.Bold)
                                                .fontColor(0xFF1E2B45)
                                                .margin(bottom: 4)

                                            Text(this.circle5MemberText)
                                                .fontSize(12)
                                                .fontColor(0xFF7B879A)
                                        }
                                        .layoutWeight(1)
                                        .alignItems(HorizontalAlign.Start)
                                    }
                                    .layoutWeight(1)

                                    Text("进入")
                                        .fontSize(13)
                                        .fontColor(0xFF2F80FF)
                                        .backgroundColor(0xFFEAF2FF)
                                        .padding(left: 12, right: 12, top: 8, bottom: 8)
                                        .borderRadius(14)
                                        .onClick({ _: ClickEvent =>
                                            this.openCircleDetail(
                                                this.circle5Id,
                                                this.circle5Name,
                                                this.circle5Desc,
                                                this.circle5MemberText,
                                                this.circle5Joined
                                            )
                                        })
                                }
                                .width(100.percent)
                                .margin(bottom: 10)
                                .alignItems(VerticalAlign.Center)

                                Text(this.circle5Desc)
                                    .fontSize(13)
                                    .fontColor(0xFF5A6A85)
                            }
                            .width(100.percent)
                            .padding(16)
                            .backgroundColor(0xFFFFFFFF)
                            .borderRadius(18)
                            .margin(bottom: 12)
                        }
                    }

                    Row {
                        Text("发现圈子")
                            .fontSize(24)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFF1E2B45)
                            .layoutWeight(1)

                        Row {
                            Text("⌕")
                                .fontSize(16)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF2F80FF)
                        }
                        .width(34)
                        .height(34)
                        .backgroundColor(0xFFEAF2FF)
                        .borderRadius(17)
                        .justifyContent(FlexAlign.Center)
                        .alignItems(VerticalAlign.Center)
                    }
                    .width(100.percent)
                    .margin(top: 10, bottom: 12)
                    .alignItems(VerticalAlign.Center)

                    if (!this.hasAnyCircle()) {
                        Column {
                            Text("暂时还没有圈子")
                                .fontSize(18)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF1E2B45)
                                .margin(bottom: 8)

                            Text("你可以先创建第一个圈子，后面这里会显示真实圈子。")
                                .fontSize(13)
                                .fontColor(0xFF7B879A)
                                .margin(bottom: 14)

                            Text("+ 创建圈子")
                                .fontSize(14)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFFFFFFFF)
                                .backgroundColor(0xFF2F80FF)
                                .padding(left: 16, right: 16, top: 10, bottom: 10)
                                .borderRadius(16)
                                .onClick({ _: ClickEvent =>
                                    Router.push(url: "CreateCirclePage")
                                })
                        }
                        .width(100.percent)
                        .padding(18)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 18)
                    } else if (!this.hasDiscoverCircle()) {
                        Column {
                            Text("当前可发现的圈子都已经加入了")
                                .fontSize(17)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF1E2B45)
                                .margin(bottom: 8)

                            Text("可以创建新圈子，或者等待新的圈子出现。")
                                .fontSize(13)
                                .fontColor(0xFF7B879A)
                        }
                        .width(100.percent)
                        .padding(18)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 18)
                    } else {
                        if (this.circle1Name != "" && this.circle1Joined != "true") {
                            Column {
                                Row {
                                    Row {
                                        Column {
                                            Text("圈")
                                                .fontSize(18)
                                                .fontWeight(FontWeight.Bold)
                                                .fontColor(0xFFFFFFFF)
                                        }
                                        .width(58)
                                        .height(58)
                                        .backgroundColor(0xFF7FAEFF)
                                        .borderRadius(14)
                                        .justifyContent(FlexAlign.Center)
                                        .alignItems(HorizontalAlign.Center)
                                        .margin(right: 12)

                                        Column {
                                            Text(this.circle1Name)
                                                .fontSize(18)
                                                .fontWeight(FontWeight.Bold)
                                                .fontColor(0xFF1E2B45)
                                                .margin(bottom: 4)

                                            Text(this.circle1MemberText)
                                                .fontSize(12)
                                                .fontColor(0xFF7B879A)
                                        }
                                        .layoutWeight(1)
                                        .alignItems(HorizontalAlign.Start)
                                    }
                                    .layoutWeight(1)

                                    Text(this.getJoinButtonText(this.circle1Joined))
                                        .fontSize(13)
                                        .fontWeight(FontWeight.Bold)
                                        .fontColor(0xFF2F80FF)
                                        .backgroundColor(0xFFEAF2FF)
                                        .padding(left: 14, right: 14, top: 9, bottom: 9)
                                        .borderRadius(16)
                                        .onClick({ _: ClickEvent =>
                                            this.joinCircle(this.circle1Id, 1)
                                        })
                                }
                                .width(100.percent)
                                .margin(bottom: 10)
                                .alignItems(VerticalAlign.Center)

                                Text(this.circle1Desc)
                                    .fontSize(13)
                                    .fontColor(0xFF5A6A85)
                                    .margin(bottom: 12)

                                Row {
                                    Column { }
                                        .layoutWeight(1)
                                        .height(80)
                                        .backgroundColor(0xFFDDEBFF)
                                        .borderRadius(12)
                                        .margin(right: 6)

                                    Column { }
                                        .layoutWeight(1)
                                        .height(80)
                                        .backgroundColor(0xFFC9DEFF)
                                        .borderRadius(12)
                                        .margin(right: 6)

                                    Column { }
                                        .layoutWeight(1)
                                        .height(80)
                                        .backgroundColor(0xFFB6D1FF)
                                        .borderRadius(12)
                                }
                                .width(100.percent)
                                .margin(bottom: 12)

                                Text("查看圈子详情 >")
                                    .fontSize(13)
                                    .fontColor(0xFF2F80FF)
                                    .onClick({ _: ClickEvent =>
                                        this.openCircleDetail(
                                            this.circle1Id,
                                            this.circle1Name,
                                            this.circle1Desc,
                                            this.circle1MemberText,
                                            this.circle1Joined
                                        )
                                    })
                            }
                            .width(100.percent)
                            .padding(16)
                            .backgroundColor(0xFFFFFFFF)
                            .borderRadius(18)
                            .margin(bottom: 14)
                        }

                        if (this.circle2Name != "" && this.circle2Joined != "true") {
                            Column {
                                Row {
                                    Row {
                                        Column {
                                            Text("圈")
                                                .fontSize(18)
                                                .fontWeight(FontWeight.Bold)
                                                .fontColor(0xFFFFFFFF)
                                        }
                                        .width(58)
                                        .height(58)
                                        .backgroundColor(0xFF8BB6FF)
                                        .borderRadius(14)
                                        .justifyContent(FlexAlign.Center)
                                        .alignItems(HorizontalAlign.Center)
                                        .margin(right: 12)

                                        Column {
                                            Text(this.circle2Name)
                                                .fontSize(18)
                                                .fontWeight(FontWeight.Bold)
                                                .fontColor(0xFF1E2B45)
                                                .margin(bottom: 4)

                                            Text(this.circle2MemberText)
                                                .fontSize(12)
                                                .fontColor(0xFF7B879A)
                                        }
                                        .layoutWeight(1)
                                        .alignItems(HorizontalAlign.Start)
                                    }
                                    .layoutWeight(1)

                                    Text(this.getJoinButtonText(this.circle2Joined))
                                        .fontSize(13)
                                        .fontWeight(FontWeight.Bold)
                                        .fontColor(0xFF2F80FF)
                                        .backgroundColor(0xFFEAF2FF)
                                        .padding(left: 14, right: 14, top: 9, bottom: 9)
                                        .borderRadius(16)
                                        .onClick({ _: ClickEvent =>
                                            this.joinCircle(this.circle2Id, 2)
                                        })
                                }
                                .width(100.percent)
                                .margin(bottom: 10)
                                .alignItems(VerticalAlign.Center)

                                Text(this.circle2Desc)
                                    .fontSize(13)
                                    .fontColor(0xFF5A6A85)
                                    .margin(bottom: 12)

                                Row {
                                    Column { }
                                        .layoutWeight(1)
                                        .height(80)
                                        .backgroundColor(0xFFEAF2FF)
                                        .borderRadius(12)
                                        .margin(right: 6)

                                    Column { }
                                        .layoutWeight(1)
                                        .height(80)
                                        .backgroundColor(0xFFDDEBFF)
                                        .borderRadius(12)
                                        .margin(right: 6)

                                    Column { }
                                        .layoutWeight(1)
                                        .height(80)
                                        .backgroundColor(0xFFDDEBFF)
                                        .borderRadius(12)
                                }
                                .width(100.percent)
                                .margin(bottom: 12)

                                Text("查看圈子详情 >")
                                    .fontSize(13)
                                    .fontColor(0xFF2F80FF)
                                    .onClick({ _: ClickEvent =>
                                        this.openCircleDetail(
                                            this.circle2Id,
                                            this.circle2Name,
                                            this.circle2Desc,
                                            this.circle2MemberText,
                                            this.circle2Joined
                                        )
                                    })
                            }
                            .width(100.percent)
                            .padding(16)
                            .backgroundColor(0xFFFFFFFF)
                            .borderRadius(18)
                            .margin(bottom: 14)
                        }

                        if (this.circle3Name != "" && this.circle3Joined != "true") {
                            Column {
                                Row {
                                    Row {
                                        Column {
                                            Text("圈")
                                                .fontSize(18)
                                                .fontWeight(FontWeight.Bold)
                                                .fontColor(0xFFFFFFFF)
                                        }
                                        .width(58)
                                        .height(58)
                                        .backgroundColor(0xFF7FAEFF)
                                        .borderRadius(14)
                                        .justifyContent(FlexAlign.Center)
                                        .alignItems(HorizontalAlign.Center)
                                        .margin(right: 12)

                                        Column {
                                            Text(this.circle3Name)
                                                .fontSize(18)
                                                .fontWeight(FontWeight.Bold)
                                                .fontColor(0xFF1E2B45)
                                                .margin(bottom: 4)

                                            Text(this.circle3MemberText)
                                                .fontSize(12)
                                                .fontColor(0xFF7B879A)
                                        }
                                        .layoutWeight(1)
                                        .alignItems(HorizontalAlign.Start)
                                    }
                                    .layoutWeight(1)

                                    Text(this.getJoinButtonText(this.circle3Joined))
                                        .fontSize(13)
                                        .fontWeight(FontWeight.Bold)
                                        .fontColor(0xFF2F80FF)
                                        .backgroundColor(0xFFEAF2FF)
                                        .padding(left: 14, right: 14, top: 9, bottom: 9)
                                        .borderRadius(16)
                                        .onClick({ _: ClickEvent =>
                                            this.joinCircle(this.circle3Id, 3)
                                        })
                                }
                                .width(100.percent)
                                .margin(bottom: 10)
                                .alignItems(VerticalAlign.Center)

                                Text(this.circle3Desc)
                                    .fontSize(13)
                                    .fontColor(0xFF5A6A85)
                                    .margin(bottom: 12)

                                Row {
                                    Column { }
                                        .layoutWeight(1)
                                        .height(80)
                                        .backgroundColor(0xFFEAF2FF)
                                        .borderRadius(12)
                                        .margin(right: 6)

                                    Column { }
                                        .layoutWeight(1)
                                        .height(80)
                                        .backgroundColor(0xFFDDEBFF)
                                        .borderRadius(12)
                                        .margin(right: 6)

                                    Column { }
                                        .layoutWeight(1)
                                        .height(80)
                                        .backgroundColor(0xFFC9DFFF)
                                        .borderRadius(12)
                                }
                                .width(100.percent)
                                .margin(bottom: 12)

                                Text("查看圈子详情 >")
                                    .fontSize(13)
                                    .fontColor(0xFF2F80FF)
                                    .onClick({ _: ClickEvent =>
                                        this.openCircleDetail(
                                            this.circle3Id,
                                            this.circle3Name,
                                            this.circle3Desc,
                                            this.circle3MemberText,
                                            this.circle3Joined
                                        )
                                    })
                            }
                            .width(100.percent)
                            .padding(16)
                            .backgroundColor(0xFFFFFFFF)
                            .borderRadius(18)
                            .margin(bottom: 14)
                        }

                        if (this.circle4Name != "" && this.circle4Joined != "true") {
                            Column {
                                Row {
                                    Row {
                                        Column {
                                            Text("圈")
                                                .fontSize(18)
                                                .fontWeight(FontWeight.Bold)
                                                .fontColor(0xFFFFFFFF)
                                        }
                                        .width(58)
                                        .height(58)
                                        .backgroundColor(0xFF6CA3FF)
                                        .borderRadius(14)
                                        .justifyContent(FlexAlign.Center)
                                        .alignItems(HorizontalAlign.Center)
                                        .margin(right: 12)

                                        Column {
                                            Text(this.circle4Name)
                                                .fontSize(18)
                                                .fontWeight(FontWeight.Bold)
                                                .fontColor(0xFF1E2B45)
                                                .margin(bottom: 4)

                                            Text(this.circle4MemberText)
                                                .fontSize(12)
                                                .fontColor(0xFF7B879A)
                                        }
                                        .layoutWeight(1)
                                        .alignItems(HorizontalAlign.Start)
                                    }
                                    .layoutWeight(1)

                                    Text(this.getJoinButtonText(this.circle4Joined))
                                        .fontSize(13)
                                        .fontWeight(FontWeight.Bold)
                                        .fontColor(0xFF2F80FF)
                                        .backgroundColor(0xFFEAF2FF)
                                        .padding(left: 14, right: 14, top: 9, bottom: 9)
                                        .borderRadius(16)
                                        .onClick({ _: ClickEvent =>
                                            this.joinCircle(this.circle4Id, 4)
                                        })
                                }
                                .width(100.percent)
                                .margin(bottom: 10)
                                .alignItems(VerticalAlign.Center)

                                Text(this.circle4Desc)
                                    .fontSize(13)
                                    .fontColor(0xFF5A6A85)
                                    .margin(bottom: 12)

                                Row {
                                    Column { }
                                        .layoutWeight(1)
                                        .height(80)
                                        .backgroundColor(0xFFEAF2FF)
                                        .borderRadius(12)
                                        .margin(right: 6)

                                    Column { }
                                        .layoutWeight(1)
                                        .height(80)
                                        .backgroundColor(0xFFDDEBFF)
                                        .borderRadius(12)
                                        .margin(right: 6)

                                    Column { }
                                        .layoutWeight(1)
                                        .height(80)
                                        .backgroundColor(0xFFC9DFFF)
                                        .borderRadius(12)
                                }
                                .width(100.percent)
                                .margin(bottom: 12)

                                Text("查看圈子详情 >")
                                    .fontSize(13)
                                    .fontColor(0xFF2F80FF)
                                    .onClick({ _: ClickEvent =>
                                        this.openCircleDetail(
                                            this.circle4Id,
                                            this.circle4Name,
                                            this.circle4Desc,
                                            this.circle4MemberText,
                                            this.circle4Joined
                                        )
                                    })
                            }
                            .width(100.percent)
                            .padding(16)
                            .backgroundColor(0xFFFFFFFF)
                            .borderRadius(18)
                            .margin(bottom: 14)
                        }

                        if (this.circle5Name != "" && this.circle5Joined != "true") {
                            Column {
                                Row {
                                    Row {
                                        Column {
                                            Text("圈")
                                                .fontSize(18)
                                                .fontWeight(FontWeight.Bold)
                                                .fontColor(0xFFFFFFFF)
                                        }
                                        .width(58)
                                        .height(58)
                                        .backgroundColor(0xFF5A96FF)
                                        .borderRadius(14)
                                        .justifyContent(FlexAlign.Center)
                                        .alignItems(HorizontalAlign.Center)
                                        .margin(right: 12)

                                        Column {
                                            Text(this.circle5Name)
                                                .fontSize(18)
                                                .fontWeight(FontWeight.Bold)
                                                .fontColor(0xFF1E2B45)
                                                .margin(bottom: 4)

                                            Text(this.circle5MemberText)
                                                .fontSize(12)
                                                .fontColor(0xFF7B879A)
                                        }
                                        .layoutWeight(1)
                                        .alignItems(HorizontalAlign.Start)
                                    }
                                    .layoutWeight(1)

                                    Text(this.getJoinButtonText(this.circle5Joined))
                                        .fontSize(13)
                                        .fontWeight(FontWeight.Bold)
                                        .fontColor(0xFF2F80FF)
                                        .backgroundColor(0xFFEAF2FF)
                                        .padding(left: 14, right: 14, top: 9, bottom: 9)
                                        .borderRadius(16)
                                        .onClick({ _: ClickEvent =>
                                            this.joinCircle(this.circle5Id, 5)
                                        })
                                }
                                .width(100.percent)
                                .margin(bottom: 10)
                                .alignItems(VerticalAlign.Center)

                                Text(this.circle5Desc)
                                    .fontSize(13)
                                    .fontColor(0xFF5A6A85)
                                    .margin(bottom: 12)

                                Row {
                                    Column { }
                                        .layoutWeight(1)
                                        .height(80)
                                        .backgroundColor(0xFFEAF2FF)
                                        .borderRadius(12)
                                        .margin(right: 6)

                                    Column { }
                                        .layoutWeight(1)
                                        .height(80)
                                        .backgroundColor(0xFFDDEBFF)
                                        .borderRadius(12)
                                        .margin(right: 6)

                                    Column { }
                                        .layoutWeight(1)
                                        .height(80)
                                        .backgroundColor(0xFFC9DFFF)
                                        .borderRadius(12)
                                }
                                .width(100.percent)
                                .margin(bottom: 12)

                                Text("查看圈子详情 >")
                                    .fontSize(13)
                                    .fontColor(0xFF2F80FF)
                                    .onClick({ _: ClickEvent =>
                                        this.openCircleDetail(
                                            this.circle5Id,
                                            this.circle5Name,
                                            this.circle5Desc,
                                            this.circle5MemberText,
                                            this.circle5Joined
                                        )
                                    })
                            }
                            .width(100.percent)
                            .padding(16)
                            .backgroundColor(0xFFFFFFFF)
                            .borderRadius(18)
                            .margin(bottom: 14)
                        }
                    }
                }
                .width(100.percent)
                .padding(left: 16, right: 16, top: 16, bottom: 96)
            }
            .layoutWeight(1)

            Row {
                Row {
                    Text("广场")
                        .fontColor(0xFF5E6C84)
                        .fontSize(15)
                        .onClick({ _: ClickEvent =>
                            this.goToHomePage()
                        })
                }
                .layoutWeight(1)
                .height(40)
                .justifyContent(FlexAlign.Center)
                .alignItems(VerticalAlign.Center)

                Row {
                    Text("圈子")
                        .fontColor(0xFF2F80FF)
                        .fontWeight(FontWeight.Bold)
                        .fontSize(15)
                        .onClick({ _: ClickEvent =>
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
                        this.goToCreateCirclePage()
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
