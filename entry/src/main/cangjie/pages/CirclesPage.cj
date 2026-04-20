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
        return "刷新圈子"
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

    func build() {
        Column {
            Column {
                Row {
                    Column {
                        Text("逛圈子")
                            .fontSize(28)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFF222222)
                            .margin(bottom: 6)

                        Text("发现感兴趣的组织，加入你的校园同好圈")
                            .fontSize(14)
                            .fontColor(0xFF666666)
                    }
                    .layoutWeight(1)

                    Text("圈子")
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
                        .onClick({ _: ClickEvent =>
                            Router.push(url: "HomePage")
                        })

                    Button("新建圈子")
                        .layoutWeight(1)
                        .height(40)
                        .backgroundColor(0xFFFF7A45)
                        .fontColor(0xFFFFFFFF)
                        .borderRadius(20)
                        .margin(right: 8)
                        .onClick({ _: ClickEvent =>
                            Router.push(url: "CreateCirclePage")
                        })

                    Button(this.getRefreshButtonText())
                        .layoutWeight(1)
                        .height(40)
                        .backgroundColor(0xFFFFF1EA)
                        .fontColor(0xFFFF7A45)
                        .borderRadius(20)
                        .enabled(!this.loading)
                        .onClick({ _: ClickEvent =>
                            this.loadCircles()
                        })
                }
                .width(100.percent)
            }
            .width(100.percent)
            .padding(left: 16, right: 16, top: 24, bottom: 20)
            .backgroundColor(0xFFFFF3EE)

            Scroll {
                Column {
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
                            Text("正在加载圈子...")
                                .fontSize(18)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF222222)
                                .margin(bottom: 10)

                            Text("稍等一下，圈子列表马上就来。")
                                .fontSize(13)
                                .fontColor(0xFF777777)
                        }
                        .width(100.percent)
                        .padding(18)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 12)
                    } else if (!this.hasAnyCircle()) {
                        Column {
                            Text("暂时还没有圈子")
                                .fontSize(20)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF222222)
                                .margin(bottom: 10)

                            Text("等管理员或用户创建圈子后，这里会显示真实圈子。")
                                .fontSize(13)
                                .fontColor(0xFF777777)
                                .margin(bottom: 16)

                            Button("去创建圈子")
                                .width(100.percent)
                                .height(42)
                                .backgroundColor(0xFFFF7A45)
                                .fontColor(0xFFFFFFFF)
                                .borderRadius(14)
                                .onClick({ _: ClickEvent =>
                                    Router.push(url: "CreateCirclePage")
                                })
                        }
                        .width(100.percent)
                        .padding(18)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 12)
                    } else {
                        if (this.circle1Name != "") {
                            Column {
                                Text(this.circle1Name)
                                    .fontSize(20)
                                    .fontWeight(FontWeight.Bold)
                                    .fontColor(0xFF222222)
                                    .margin(bottom: 6)

                                Text(this.circle1MemberText)
                                    .fontSize(13)
                                    .fontColor(0xFFFF7A45)
                                    .margin(bottom: 8)

                                Text(this.circle1Desc)
                                    .fontSize(13)
                                    .fontColor(0xFF666666)
                                    .margin(bottom: 14)

                                Row {
                                    Button("查看圈子")
                                        .layoutWeight(1)
                                        .height(42)
                                        .backgroundColor(0xFFFFF1EA)
                                        .fontColor(0xFFFF7A45)
                                        .borderRadius(14)
                                        .margin(right: 8)
                                        .onClick({ _: ClickEvent =>
                                            this.openCircleDetail(
                                                this.circle1Id,
                                                this.circle1Name,
                                                this.circle1Desc,
                                                this.circle1MemberText,
                                                this.circle1Joined
                                            )
                                        })

                                    Button(CircleService.formatJoinButtonText(this.circle1Joined))
                                        .layoutWeight(1)
                                        .height(42)
                                        .enabled(this.circle1Joined != "true")
                                        .backgroundColor(0xFFFF7A45)
                                        .fontColor(0xFFFFFFFF)
                                        .borderRadius(14)
                                        .onClick({ _: ClickEvent =>
                                            this.joinCircle(this.circle1Id, 1)
                                        })
                                }
                                .width(100.percent)
                            }
                            .width(100.percent)
                            .padding(16)
                            .backgroundColor(0xFFFFFFFF)
                            .borderRadius(18)
                            .margin(bottom: 12)
                        }

                        if (this.circle2Name != "") {
                            Column {
                                Text(this.circle2Name)
                                    .fontSize(20)
                                    .fontWeight(FontWeight.Bold)
                                    .fontColor(0xFF222222)
                                    .margin(bottom: 6)

                                Text(this.circle2MemberText)
                                    .fontSize(13)
                                    .fontColor(0xFFFF7A45)
                                    .margin(bottom: 8)

                                Text(this.circle2Desc)
                                    .fontSize(13)
                                    .fontColor(0xFF666666)
                                    .margin(bottom: 14)

                                Row {
                                    Button("查看圈子")
                                        .layoutWeight(1)
                                        .height(42)
                                        .backgroundColor(0xFFFFF1EA)
                                        .fontColor(0xFFFF7A45)
                                        .borderRadius(14)
                                        .margin(right: 8)
                                        .onClick({ _: ClickEvent =>
                                            this.openCircleDetail(
                                                this.circle2Id,
                                                this.circle2Name,
                                                this.circle2Desc,
                                                this.circle2MemberText,
                                                this.circle2Joined
                                            )
                                        })

                                    Button(CircleService.formatJoinButtonText(this.circle2Joined))
                                        .layoutWeight(1)
                                        .height(42)
                                        .enabled(this.circle2Joined != "true")
                                        .backgroundColor(0xFFFF7A45)
                                        .fontColor(0xFFFFFFFF)
                                        .borderRadius(14)
                                        .onClick({ _: ClickEvent =>
                                            this.joinCircle(this.circle2Id, 2)
                                        })
                                }
                                .width(100.percent)
                            }
                            .width(100.percent)
                            .padding(16)
                            .backgroundColor(0xFFFFFFFF)
                            .borderRadius(18)
                            .margin(bottom: 12)
                        }

                        if (this.circle3Name != "") {
                            Column {
                                Text(this.circle3Name)
                                    .fontSize(20)
                                    .fontWeight(FontWeight.Bold)
                                    .fontColor(0xFF222222)
                                    .margin(bottom: 6)

                                Text(this.circle3MemberText)
                                    .fontSize(13)
                                    .fontColor(0xFFFF7A45)
                                    .margin(bottom: 8)

                                Text(this.circle3Desc)
                                    .fontSize(13)
                                    .fontColor(0xFF666666)
                                    .margin(bottom: 14)

                                Row {
                                    Button("查看圈子")
                                        .layoutWeight(1)
                                        .height(42)
                                        .backgroundColor(0xFFFFF1EA)
                                        .fontColor(0xFFFF7A45)
                                        .borderRadius(14)
                                        .margin(right: 8)
                                        .onClick({ _: ClickEvent =>
                                            this.openCircleDetail(
                                                this.circle3Id,
                                                this.circle3Name,
                                                this.circle3Desc,
                                                this.circle3MemberText,
                                                this.circle3Joined
                                            )
                                        })

                                    Button(CircleService.formatJoinButtonText(this.circle3Joined))
                                        .layoutWeight(1)
                                        .height(42)
                                        .enabled(this.circle3Joined != "true")
                                        .backgroundColor(0xFFFF7A45)
                                        .fontColor(0xFFFFFFFF)
                                        .borderRadius(14)
                                        .onClick({ _: ClickEvent =>
                                            this.joinCircle(this.circle3Id, 3)
                                        })
                                }
                                .width(100.percent)
                            }
                            .width(100.percent)
                            .padding(16)
                            .backgroundColor(0xFFFFFFFF)
                            .borderRadius(18)
                            .margin(bottom: 12)
                        }

                        if (this.circle4Name != "") {
                            Column {
                                Text(this.circle4Name)
                                    .fontSize(20)
                                    .fontWeight(FontWeight.Bold)
                                    .fontColor(0xFF222222)
                                    .margin(bottom: 6)

                                Text(this.circle4MemberText)
                                    .fontSize(13)
                                    .fontColor(0xFFFF7A45)
                                    .margin(bottom: 8)

                                Text(this.circle4Desc)
                                    .fontSize(13)
                                    .fontColor(0xFF666666)
                                    .margin(bottom: 14)

                                Row {
                                    Button("查看圈子")
                                        .layoutWeight(1)
                                        .height(42)
                                        .backgroundColor(0xFFFFF1EA)
                                        .fontColor(0xFFFF7A45)
                                        .borderRadius(14)
                                        .margin(right: 8)
                                        .onClick({ _: ClickEvent =>
                                            this.openCircleDetail(
                                                this.circle4Id,
                                                this.circle4Name,
                                                this.circle4Desc,
                                                this.circle4MemberText,
                                                this.circle4Joined
                                            )
                                        })

                                    Button(CircleService.formatJoinButtonText(this.circle4Joined))
                                        .layoutWeight(1)
                                        .height(42)
                                        .enabled(this.circle4Joined != "true")
                                        .backgroundColor(0xFFFF7A45)
                                        .fontColor(0xFFFFFFFF)
                                        .borderRadius(14)
                                        .onClick({ _: ClickEvent =>
                                            this.joinCircle(this.circle4Id, 4)
                                        })
                                }
                                .width(100.percent)
                            }
                            .width(100.percent)
                            .padding(16)
                            .backgroundColor(0xFFFFFFFF)
                            .borderRadius(18)
                            .margin(bottom: 12)
                        }

                        if (this.circle5Name != "") {
                            Column {
                                Text(this.circle5Name)
                                    .fontSize(20)
                                    .fontWeight(FontWeight.Bold)
                                    .fontColor(0xFF222222)
                                    .margin(bottom: 6)

                                Text(this.circle5MemberText)
                                    .fontSize(13)
                                    .fontColor(0xFFFF7A45)
                                    .margin(bottom: 8)

                                Text(this.circle5Desc)
                                    .fontSize(13)
                                    .fontColor(0xFF666666)
                                    .margin(bottom: 14)

                                Row {
                                    Button("查看圈子")
                                        .layoutWeight(1)
                                        .height(42)
                                        .backgroundColor(0xFFFFF1EA)
                                        .fontColor(0xFFFF7A45)
                                        .borderRadius(14)
                                        .margin(right: 8)
                                        .onClick({ _: ClickEvent =>
                                            this.openCircleDetail(
                                                this.circle5Id,
                                                this.circle5Name,
                                                this.circle5Desc,
                                                this.circle5MemberText,
                                                this.circle5Joined
                                            )
                                        })

                                    Button(CircleService.formatJoinButtonText(this.circle5Joined))
                                        .layoutWeight(1)
                                        .height(42)
                                        .enabled(this.circle5Joined != "true")
                                        .backgroundColor(0xFFFF7A45)
                                        .fontColor(0xFFFFFFFF)
                                        .borderRadius(14)
                                        .onClick({ _: ClickEvent =>
                                            this.joinCircle(this.circle5Id, 5)
                                        })
                                }
                                .width(100.percent)
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