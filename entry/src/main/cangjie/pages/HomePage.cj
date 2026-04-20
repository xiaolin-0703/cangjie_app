package ohos_app_cangjie_entry.pages

internal import ohos.base.LengthProp
import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.router.*
import ohos_app_cangjie_entry.common.ApiConfig
import ohos_app_cangjie_entry.service.CircleService

@Entry
@Component
class HomePage {
    @State var welcomeName: String = "北航社区"

    @State var circleLoading: Bool = false
    @State var circleFirstLoaded: Bool = false

    @State var hotCircle1Id: String = ""
    @State var hotCircle1Name: String = ""
    @State var hotCircle1Desc: String = ""
    @State var hotCircle1MemberText: String = ""
    @State var hotCircle1Joined: String = "false"

    @State var hotCircle2Id: String = ""
    @State var hotCircle2Name: String = ""
    @State var hotCircle2Desc: String = ""
    @State var hotCircle2MemberText: String = ""
    @State var hotCircle2Joined: String = "false"

    public func aboutToAppear(): Unit {
        if (!this.circleFirstLoaded && !this.circleLoading) {
            this.loadHotCircles()
        }
    }

    func goToCreateEventPage() {
        Router.push(url: "CreateEventPage")
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

    func goToMyCreatedEventsPage() {
        Router.push(url: "MyCreatedEventsPage")
    }

    func clearHotCircles() {
        this.hotCircle1Id = ""
        this.hotCircle1Name = ""
        this.hotCircle1Desc = ""
        this.hotCircle1MemberText = ""
        this.hotCircle1Joined = "false"

        this.hotCircle2Id = ""
        this.hotCircle2Name = ""
        this.hotCircle2Desc = ""
        this.hotCircle2MemberText = ""
        this.hotCircle2Joined = "false"
    }

    func hasHotCircles(): Bool {
        return this.hotCircle1Name != "" || this.hotCircle2Name != ""
    }

    func loadHotCircles() {
        this.circleLoading = true

        CircleService.getHotCircles(
            { raw: String =>
                this.clearHotCircles()

                this.hotCircle1Id = CircleService.extractCircleField(raw, 0, "id")
                this.hotCircle1Name = CircleService.extractCircleField(raw, 0, "name")
                this.hotCircle1Desc = CircleService.extractCircleField(raw, 0, "description")
                this.hotCircle1MemberText = CircleService.formatMemberText(
                    CircleService.extractCircleField(raw, 0, "memberCount")
                )
                this.hotCircle1Joined = CircleService.extractCircleField(raw, 0, "joined")

                this.hotCircle2Id = CircleService.extractCircleField(raw, 1, "id")
                this.hotCircle2Name = CircleService.extractCircleField(raw, 1, "name")
                this.hotCircle2Desc = CircleService.extractCircleField(raw, 1, "description")
                this.hotCircle2MemberText = CircleService.formatMemberText(
                    CircleService.extractCircleField(raw, 1, "memberCount")
                )
                this.hotCircle2Joined = CircleService.extractCircleField(raw, 1, "joined")

                this.circleLoading = false
                this.circleFirstLoaded = true
            },
            { _: String =>
                this.circleLoading = false
                this.circleFirstLoaded = true
            }
        )
    }

    func joinHotCircle(circleId: String, index: Int64) {
        CircleService.joinCircle(
            circleId,
            { _: String =>
                if (index == 1) {
                    this.hotCircle1Joined = "true"
                }
                if (index == 2) {
                    this.hotCircle2Joined = "true"
                }
                this.loadHotCircles()
            },
            { _: String => }
        )
    }

    func build() {
        Column {
            Column {
                Row {
                    Column {
                        Text("欢迎到来，${this.welcomeName}")
                            .fontSize(28)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFF222222)
                            .margin(bottom: 6)

                        Text("今天为你推荐了校园里的热门活动、圈子和同好")
                            .fontSize(14)
                            .fontColor(0xFF666666)
                    }
                    .layoutWeight(1)

                    Text("消息")
                        .fontSize(13)
                        .fontColor(0xFFFF7A45)
                        .backgroundColor(0xFFFFFFFF)
                        .padding(left: 14, right: 14, top: 8, bottom: 8)
                        .borderRadius(18)
                }
                .width(100.percent)
                .margin(bottom: 16)

                Row {
                    Text("搜索同好 / 圈子 / 活动")
                        .fontSize(14)
                        .fontColor(0xFF999999)
                }
                .width(100.percent)
                .height(44)
                .padding(left: 16, right: 16)
                .backgroundColor(0xFFFFFFFF)
                .borderRadius(22)

                Row {
                    Text("桌游")
                        .fontSize(12)
                        .fontColor(0xFFFF7A45)
                        .backgroundColor(0xFFFFE8DE)
                        .padding(left: 10, right: 10, top: 6, bottom: 6)
                        .borderRadius(14)
                        .margin(right: 8)

                    Text("跑步")
                        .fontSize(12)
                        .fontColor(0xFFFF7A45)
                        .backgroundColor(0xFFFFE8DE)
                        .padding(left: 10, right: 10, top: 6, bottom: 6)
                        .borderRadius(14)
                        .margin(right: 8)

                    Text("电影")
                        .fontSize(12)
                        .fontColor(0xFFFF7A45)
                        .backgroundColor(0xFFFFE8DE)
                        .padding(left: 10, right: 10, top: 6, bottom: 6)
                        .borderRadius(14)
                        .margin(right: 8)

                    Text("摄影")
                        .fontSize(12)
                        .fontColor(0xFFFF7A45)
                        .backgroundColor(0xFFFFE8DE)
                        .padding(left: 10, right: 10, top: 6, bottom: 6)
                        .borderRadius(14)
                }
                .width(100.percent)
                .margin(top: 12)

                Button("个人中心")
                    .width(100.percent)
                    .height(42)
                    .backgroundColor(0xFFFFFFFF)
                    .fontColor(0xFFFF7A45)
                    .borderRadius(18)
                    .margin(top: 14)
                    .onClick({ _: ClickEvent =>
                        this.goToProfilePage()
                    })
            }
            .width(100.percent)
            .padding(left: 16, right: 16, top: 24, bottom: 20)
            .backgroundColor(0xFFFFF3EE)

            Scroll {
                Column {
                    Column {
                        Text("本周校园热度上升中")
                            .fontSize(20)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFFFFFFFF)
                            .margin(bottom: 8)

                        Text("飞盘、桌游、摄影活动正在报名，去看看有没有你感兴趣的局")
                            .fontSize(13)
                            .fontColor(0xFFFFF2EB)
                            .margin(bottom: 16)

                        Button("马上看看")
                            .width(120)
                            .height(40)
                            .backgroundColor(0xFFFFFFFF)
                            .fontColor(0xFFFF7A45)
                            .borderRadius(20)
                            .onClick({ _: ClickEvent =>
                                this.goToEventsPage()
                            })
                    }
                    .width(100.percent)
                    .padding(18)
                    .backgroundColor(0xFFFF7A45)
                    .borderRadius(20)
                    .margin(bottom: 16)

                    Text("快捷入口")
                        .fontSize(20)
                        .fontWeight(FontWeight.Bold)
                        .fontColor(0xFF222222)
                        .margin(bottom: 12)

                    Row {
                        Column {
                            Text("找同好")
                                .fontSize(17)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF222222)
                                .margin(bottom: 8)

                            Text("按兴趣匹配新朋友")
                                .fontSize(12)
                                .fontColor(0xFF777777)
                                .margin(bottom: 12)

                            Button("去看看")
                                .width(100.percent)
                                .height(34)
                                .backgroundColor(0xFFFFF1EA)
                                .fontColor(0xFFFF7A45)
                                .borderRadius(16)
                                .onClick({ _: ClickEvent =>
                                    this.goToProfilePage()
                                })
                        }
                        .layoutWeight(1)
                        .padding(14)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(right: 8)

                        Column {
                            Text("逛圈子")
                                .fontSize(17)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF222222)
                                .margin(bottom: 8)

                            Text("发现感兴趣的组织")
                                .fontSize(12)
                                .fontColor(0xFF777777)
                                .margin(bottom: 12)

                            Button("去逛逛")
                                .width(100.percent)
                                .height(34)
                                .backgroundColor(0xFFFFF1EA)
                                .fontColor(0xFFFF7A45)
                                .borderRadius(16)
                                .onClick({ _: ClickEvent =>
                                    this.goToCirclesPage()
                                })
                        }
                        .layoutWeight(1)
                        .padding(14)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                    }
                    .width(100.percent)
                    .margin(bottom: 8)

                    Row {
                        Column {
                            Text("约活动")
                                .fontSize(17)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF222222)
                                .margin(bottom: 8)

                            Text("参加本周热门活动")
                                .fontSize(12)
                                .fontColor(0xFF777777)
                                .margin(bottom: 12)

                            Button("去看看")
                                .width(100.percent)
                                .height(34)
                                .backgroundColor(0xFFFFF1EA)
                                .fontColor(0xFFFF7A45)
                                .borderRadius(16)
                                .onClick({ _: ClickEvent =>
                                    this.goToEventsPage()
                                })
                        }
                        .layoutWeight(1)
                        .padding(14)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(right: 8)

                        Column {
                            Text("我发起的活动")
                                .fontSize(17)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF222222)
                                .margin(bottom: 8)

                            Text("查看自己创建的活动")
                                .fontSize(12)
                                .fontColor(0xFF777777)
                                .margin(bottom: 12)

                            Button("去查看")
                                .width(100.percent)
                                .height(34)
                                .backgroundColor(0xFFFFF1EA)
                                .fontColor(0xFFFF7A45)
                                .borderRadius(16)
                                .onClick({ _: ClickEvent =>
                                    this.goToMyCreatedEventsPage()
                                })
                        }
                        .layoutWeight(1)
                        .padding(14)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                    }
                    .width(100.percent)
                    .margin(bottom: 16)

                    Row {
                        Text("为你推荐的同好")
                            .fontSize(20)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFF222222)

                        Text("查看更多")
                            .fontSize(13)
                            .fontColor(0xFFFF7A45)
                    }
                    .width(100.percent)
                    .justifyContent(FlexAlign.SpaceBetween)
                    .alignItems(VerticalAlign.Center)
                    .margin(bottom: 12)

                    Column {
                        Row {
                            Column {
                                Text("小周")
                                    .fontSize(18)
                                    .fontWeight(FontWeight.Bold)
                                    .fontColor(0xFF222222)
                                    .margin(bottom: 6)

                                Text("计算机 · 大二")
                                    .fontSize(13)
                                    .fontColor(0xFF777777)
                            }
                            .layoutWeight(1)

                            Text("在线")
                                .fontSize(11)
                                .fontColor(0xFF2E9B4B)
                                .backgroundColor(0xFFEAF7EE)
                                .padding(left: 10, right: 10, top: 6, bottom: 6)
                                .borderRadius(12)
                        }
                        .width(100.percent)
                        .margin(bottom: 10)

                        Text("89% 兴趣契合")
                            .fontSize(13)
                            .fontColor(0xFFFF7A45)
                            .margin(bottom: 8)

                        Text("桌游 / 电影 / 羽毛球")
                            .fontSize(12)
                            .fontColor(0xFF999999)
                            .margin(bottom: 14)

                        Button("打招呼")
                            .width(100.percent)
                            .height(42)
                            .backgroundColor(0xFFFF7A45)
                            .fontColor(0xFFFFFFFF)
                            .borderRadius(14)
                    }
                    .width(100.percent)
                    .padding(16)
                    .backgroundColor(0xFFFFFFFF)
                    .borderRadius(18)
                    .margin(bottom: 12)

                    Column {
                        Row {
                            Column {
                                Text("阿宁")
                                    .fontSize(18)
                                    .fontWeight(FontWeight.Bold)
                                    .fontColor(0xFF222222)
                                    .margin(bottom: 6)

                                Text("新闻 · 大三")
                                    .fontSize(13)
                                    .fontColor(0xFF777777)
                            }
                            .layoutWeight(1)

                            Text("在线")
                                .fontSize(11)
                                .fontColor(0xFF2E9B4B)
                                .backgroundColor(0xFFEAF7EE)
                                .padding(left: 10, right: 10, top: 6, bottom: 6)
                                .borderRadius(12)
                        }
                        .width(100.percent)
                        .margin(bottom: 10)

                        Text("84% 兴趣契合")
                            .fontSize(13)
                            .fontColor(0xFFFF7A45)
                            .margin(bottom: 8)

                        Text("摄影 / 探店 / 电影")
                            .fontSize(12)
                            .fontColor(0xFF999999)
                            .margin(bottom: 14)

                        Button("打招呼")
                            .width(100.percent)
                            .height(42)
                            .backgroundColor(0xFFFF7A45)
                            .fontColor(0xFFFFFFFF)
                            .borderRadius(14)
                    }
                    .width(100.percent)
                    .padding(16)
                    .backgroundColor(0xFFFFFFFF)
                    .borderRadius(18)
                    .margin(bottom: 16)

                    Row {
                        Text("热门圈子")
                            .fontSize(20)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFF222222)

                        Text("发现更多")
                            .fontSize(13)
                            .fontColor(0xFFFF7A45)
                            .onClick({ _: ClickEvent =>
                                this.goToCirclesPage()
                            })
                    }
                    .width(100.percent)
                    .justifyContent(FlexAlign.SpaceBetween)
                    .alignItems(VerticalAlign.Center)
                    .margin(bottom: 12)

                    if (!this.circleFirstLoaded && this.circleLoading) {
                        Column {
                            Text("正在加载圈子...")
                                .fontSize(16)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF222222)
                                .margin(bottom: 8)

                            Text("稍等一下，真实热门圈子马上就来。")
                                .fontSize(13)
                                .fontColor(0xFF777777)
                        }
                        .width(100.percent)
                        .padding(16)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 12)
                    } else if (!this.hasHotCircles()) {
                        Column {
                            Text("暂时还没有热门圈子")
                                .fontSize(16)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF222222)
                                .margin(bottom: 8)

                            Text("等圈子数据接通后，这里会显示真实圈子。")
                                .fontSize(13)
                                .fontColor(0xFF777777)
                        }
                        .width(100.percent)
                        .padding(16)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 12)
                    } else {
                        if (this.hotCircle1Name != "") {
                            Row {
                                Column {
                                    Text(this.hotCircle1Name)
                                        .fontSize(17)
                                        .fontWeight(FontWeight.Bold)
                                        .fontColor(0xFF222222)
                                        .margin(bottom: 6)

                                    Text(this.hotCircle1MemberText)
                                        .fontSize(12)
                                        .fontColor(0xFFFF7A45)
                                        .margin(bottom: 8)

                                    Text(this.hotCircle1Desc)
                                        .fontSize(13)
                                        .fontColor(0xFF777777)
                                }
                                .layoutWeight(1)

                                Button(CircleService.formatJoinButtonText(this.hotCircle1Joined))
                                    .width(72)
                                    .height(36)
                                    .enabled(this.hotCircle1Joined != "true")
                                    .backgroundColor(0xFFFFF1EA)
                                    .fontColor(0xFFFF7A45)
                                    .borderRadius(18)
                                    .onClick({ _: ClickEvent =>
                                        this.joinHotCircle(this.hotCircle1Id, 1)
                                    })
                            }
                            .width(100.percent)
                            .padding(16)
                            .backgroundColor(0xFFFFFFFF)
                            .borderRadius(18)
                            .margin(bottom: 12)
                        }

                        if (this.hotCircle2Name != "") {
                            Row {
                                Column {
                                    Text(this.hotCircle2Name)
                                        .fontSize(17)
                                        .fontWeight(FontWeight.Bold)
                                        .fontColor(0xFF222222)
                                        .margin(bottom: 6)

                                    Text(this.hotCircle2MemberText)
                                        .fontSize(12)
                                        .fontColor(0xFFFF7A45)
                                        .margin(bottom: 8)

                                    Text(this.hotCircle2Desc)
                                        .fontSize(13)
                                        .fontColor(0xFF777777)
                                }
                                .layoutWeight(1)

                                Button(CircleService.formatJoinButtonText(this.hotCircle2Joined))
                                    .width(72)
                                    .height(36)
                                    .enabled(this.hotCircle2Joined != "true")
                                    .backgroundColor(0xFFFFF1EA)
                                    .fontColor(0xFFFF7A45)
                                    .borderRadius(18)
                                    .onClick({ _: ClickEvent =>
                                        this.joinHotCircle(this.hotCircle2Id, 2)
                                    })
                            }
                            .width(100.percent)
                            .padding(16)
                            .backgroundColor(0xFFFFFFFF)
                            .borderRadius(18)
                            .margin(bottom: 12)
                        }
                    }

                    Row {
                        Text("本周精选活动")
                            .fontSize(20)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFF222222)

                        Button("全部活动")
                            .height(32)
                            .backgroundColor(0xFFFFF1EA)
                            .fontColor(0xFFFF7A45)
                            .borderRadius(16)
                            .onClick({ _: ClickEvent =>
                                this.goToEventsPage()
                            })
                    }
                    .width(100.percent)
                    .justifyContent(FlexAlign.SpaceBetween)
                    .alignItems(VerticalAlign.Center)
                    .margin(top: 4, bottom: 12)

                    Button("发起活动")
                        .width(100.percent)
                        .height(42)
                        .backgroundColor(0xFFFFF1EA)
                        .fontColor(0xFFFF7A45)
                        .borderRadius(14)
                        .margin(bottom: 12)
                        .onClick({ _: ClickEvent =>
                            this.goToCreateEventPage()
                        })

                    Column {
                        Row {
                            Column {
                                Text("飞盘体验局")
                                    .fontSize(18)
                                    .fontWeight(FontWeight.Bold)
                                    .fontColor(0xFF222222)
                                    .margin(bottom: 8)

                                Text("今晚 19:00")
                                    .fontSize(13)
                                    .fontColor(0xFF666666)
                                    .margin(bottom: 4)

                                Text("西操场")
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

                        Text("还剩 12 个名额")
                            .fontSize(12)
                            .fontColor(0xFFFF7A45)
                            .margin(bottom: 14)

                        Button("立即报名")
                            .width(100.percent)
                            .height(42)
                            .backgroundColor(0xFFFF7A45)
                            .fontColor(0xFFFFFFFF)
                            .borderRadius(14)
                    }
                    .width(100.percent)
                    .padding(16)
                    .backgroundColor(0xFFFFFFFF)
                    .borderRadius(18)
                    .margin(bottom: 12)

                    Column {
                        Row {
                            Column {
                                Text("电影交换夜")
                                    .fontSize(18)
                                    .fontWeight(FontWeight.Bold)
                                    .fontColor(0xFF222222)
                                    .margin(bottom: 8)

                                Text("周六 18:30")
                                    .fontSize(13)
                                    .fontColor(0xFF666666)
                                    .margin(bottom: 4)

                                Text("学生活动中心")
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

                        Text("报名即将截止")
                            .fontSize(12)
                            .fontColor(0xFFFF7A45)
                            .margin(bottom: 14)

                        Button("立即报名")
                            .width(100.percent)
                            .height(42)
                            .backgroundColor(0xFFFF7A45)
                            .fontColor(0xFFFFFFFF)
                            .borderRadius(14)
                    }
                    .width(100.percent)
                    .padding(16)
                    .backgroundColor(0xFFFFFFFF)
                    .borderRadius(18)
                    .margin(bottom: 16)

                    Text("账号设置")
                        .fontSize(20)
                        .fontWeight(FontWeight.Bold)
                        .fontColor(0xFF222222)
                        .margin(bottom: 12)

                    Button("退出登录")
                        .width(100.percent)
                        .height(46)
                        .backgroundColor(0xFFFFFFFF)
                        .fontColor(0xFF666666)
                        .borderRadius(16)
                        .margin(bottom: 24)
                        .onClick({ _: ClickEvent =>
                            ApiConfig.clearAccessToken()
                            Router.push(url: "LoginPage")
                        })
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