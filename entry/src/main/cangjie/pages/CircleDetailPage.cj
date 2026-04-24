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
class CircleDetailPage {
    @State var circleId: String = ""
    @State var circleName: String = "圈子详情"
    @State var circleDesc: String = "暂无简介"
    @State var memberText: String = "0人已加入"
    @State var joinedText: String = "false"

    @State var loading: Bool = false
    @State var errorMsg: String = ""

    @State var post1Title: String = ""
    @State var post1Content: String = ""
    @State var post1Author: String = ""
    @State var post1Time: String = ""
    @State var post1ImageUrl: String = ""

    @State var post2Title: String = ""
    @State var post2Content: String = ""
    @State var post2Author: String = ""
    @State var post2Time: String = ""
    @State var post2ImageUrl: String = ""

    @State var post3Title: String = ""
    @State var post3Content: String = ""
    @State var post3Author: String = ""
    @State var post3Time: String = ""
    @State var post3ImageUrl: String = ""

    @State var post4Title: String = ""
    @State var post4Content: String = ""
    @State var post4Author: String = ""
    @State var post4Time: String = ""
    @State var post4ImageUrl: String = ""

    @State var post5Title: String = ""
    @State var post5Content: String = ""
    @State var post5Author: String = ""
    @State var post5Time: String = ""
    @State var post5ImageUrl: String = ""

    public func aboutToAppear(): Unit {
        this.circleId = CircleService.getCurrentCircleId()
        this.circleName = CircleService.getCurrentCircleName()
        this.circleDesc = CircleService.getCurrentCircleDescription()
        this.memberText = CircleService.getCurrentCircleMemberText()
        this.joinedText = CircleService.getCurrentCircleJoinedText()

        if (this.circleId != "") {
            this.loadCircleDetail()
            this.loadPosts()
        } else {
            this.errorMsg = "圈子 ID 缺失"
        }
    }

    func getRefreshText(): String {
        if (this.loading) {
            return "刷新中..."
        }
        return "刷新内容"
    }

    func clearPosts() {
        this.post1Title = ""
        this.post1Content = ""
        this.post1Author = ""
        this.post1Time = ""
        this.post1ImageUrl = ""

        this.post2Title = ""
        this.post2Content = ""
        this.post2Author = ""
        this.post2Time = ""
        this.post2ImageUrl = ""

        this.post3Title = ""
        this.post3Content = ""
        this.post3Author = ""
        this.post3Time = ""
        this.post3ImageUrl = ""

        this.post4Title = ""
        this.post4Content = ""
        this.post4Author = ""
        this.post4Time = ""
        this.post4ImageUrl = ""

        this.post5Title = ""
        this.post5Content = ""
        this.post5Author = ""
        this.post5Time = ""
        this.post5ImageUrl = ""
    }

    func hasPosts(): Bool {
        return this.post1Title != "" ||
            this.post2Title != "" ||
            this.post3Title != "" ||
            this.post4Title != "" ||
            this.post5Title != ""
    }

    func loadCircleDetail() {
        CircleService.getCircleDetail(
            this.circleId,
            { raw: String =>
                this.circleName = CircleService.extractSingleCircleField(raw, "name")
                this.circleDesc = CircleService.extractSingleCircleField(raw, "description")
                this.memberText = CircleService.formatMemberText(
                    CircleService.extractSingleCircleField(raw, "memberCount")
                )
                this.joinedText = CircleService.extractSingleCircleField(raw, "joined")

                CircleService.setCurrentCircleDetail(
                    this.circleId,
                    this.circleName,
                    this.circleDesc,
                    this.memberText,
                    this.joinedText
                )
            },
            { msg: String =>
                this.errorMsg = msg
            }
        )
    }

    func loadPosts() {
        this.loading = true
        this.errorMsg = ""
        this.clearPosts()

        CircleService.getCirclePosts(
            this.circleId,
            { raw: String =>
                this.post1Title = CircleService.extractPostField(raw, 0, "title")
                this.post1Content = CircleService.extractPostField(raw, 0, "content")
                this.post1Author = CircleService.extractPostField(raw, 0, "nickname")
                this.post1Time = CircleService.extractPostField(raw, 0, "createdAt")
                this.post1ImageUrl = CircleService.extractPostField(raw, 0, "imageUrl")

                this.post2Title = CircleService.extractPostField(raw, 1, "title")
                this.post2Content = CircleService.extractPostField(raw, 1, "content")
                this.post2Author = CircleService.extractPostField(raw, 1, "nickname")
                this.post2Time = CircleService.extractPostField(raw, 1, "createdAt")
                this.post2ImageUrl = CircleService.extractPostField(raw, 1, "imageUrl")

                this.post3Title = CircleService.extractPostField(raw, 2, "title")
                this.post3Content = CircleService.extractPostField(raw, 2, "content")
                this.post3Author = CircleService.extractPostField(raw, 2, "nickname")
                this.post3Time = CircleService.extractPostField(raw, 2, "createdAt")
                this.post3ImageUrl = CircleService.extractPostField(raw, 2, "imageUrl")

                this.post4Title = CircleService.extractPostField(raw, 3, "title")
                this.post4Content = CircleService.extractPostField(raw, 3, "content")
                this.post4Author = CircleService.extractPostField(raw, 3, "nickname")
                this.post4Time = CircleService.extractPostField(raw, 3, "createdAt")
                this.post4ImageUrl = CircleService.extractPostField(raw, 3, "imageUrl")

                this.post5Title = CircleService.extractPostField(raw, 4, "title")
                this.post5Content = CircleService.extractPostField(raw, 4, "content")
                this.post5Author = CircleService.extractPostField(raw, 4, "nickname")
                this.post5Time = CircleService.extractPostField(raw, 4, "createdAt")
                this.post5ImageUrl = CircleService.extractPostField(raw, 4, "imageUrl")

                this.loading = false
            },
            { msg: String =>
                this.loading = false
                this.errorMsg = msg
            }
        )
    }

    func joinCurrentCircle() {
        CircleService.joinCircle(
            this.circleId,
            { _: String =>
                this.joinedText = "true"
                this.loadCircleDetail()
            },
            { msg: String =>
                this.errorMsg = msg
            }
        )
    }

    func build() {
        Column {
            Column {
                Row {
                    Column {
                        Text("圈子详情")
                            .fontSize(28)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFF222222)
                            .margin(bottom: 6)

                        Text("查看圈子信息、帖子动态和加入状态")
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
                    Button("返回圈子")
                        .layoutWeight(1)
                        .height(40)
                        .backgroundColor(0xFFFFFFFF)
                        .fontColor(0xFFFF7A45)
                        .borderRadius(20)
                        .margin(right: 8)
                        .onClick({ _: ClickEvent =>
                            Router.push(url: "CirclesPage")
                        })

                    Button(this.getRefreshText())
                        .layoutWeight(1)
                        .height(40)
                        .backgroundColor(0xFFFF7A45)
                        .fontColor(0xFFFFFFFF)
                        .borderRadius(20)
                        .enabled(!this.loading)
                        .onClick({ _: ClickEvent =>
                            this.loadCircleDetail()
                            this.loadPosts()
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

                    Column {
                        Text(this.circleName)
                            .fontSize(22)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFF222222)
                            .margin(bottom: 8)

                        Text(this.memberText)
                            .fontSize(13)
                            .fontColor(0xFFFF7A45)
                            .margin(bottom: 10)

                        Text(this.circleDesc)
                            .fontSize(14)
                            .fontColor(0xFF666666)
                            .margin(bottom: 16)

                        if (this.joinedText == "true") {
                            Button("已加入")
                                .width(100.percent)
                                .height(42)
                                .enabled(false)
                                .backgroundColor(0xFFFFF1EA)
                                .fontColor(0xFFFF7A45)
                                .borderRadius(14)
                                .margin(bottom: 12)
                        } else {
                            Button("加入圈子")
                                .width(100.percent)
                                .height(42)
                                .backgroundColor(0xFFFF7A45)
                                .fontColor(0xFFFFFFFF)
                                .borderRadius(14)
                                .margin(bottom: 12)
                                .onClick({ _: ClickEvent =>
                                    this.joinCurrentCircle()
                                })
                        }

                        Button("发布帖子")
                            .width(100.percent)
                            .height(42)
                            .backgroundColor(0xFFFFF1EA)
                            .fontColor(0xFFFF7A45)
                            .borderRadius(14)
                            .onClick({ _: ClickEvent =>
                                Router.push(url: "CreatePostPage")
                            })
                    }
                    .width(100.percent)
                    .padding(18)
                    .backgroundColor(0xFFFFFFFF)
                    .borderRadius(20)
                    .margin(bottom: 12)

                    Text("圈子动态")
                        .fontSize(20)
                        .fontWeight(FontWeight.Bold)
                        .fontColor(0xFF222222)
                        .margin(bottom: 12)

                    if (!this.hasPosts() && !this.loading) {
                        Column {
                            Text("暂时还没有帖子")
                                .fontSize(18)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF222222)
                                .margin(bottom: 8)

                            Text("快来发布第一条帖子吧。")
                                .fontSize(13)
                                .fontColor(0xFF777777)
                        }
                        .width(100.percent)
                        .padding(18)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 12)
                    }

                    if (this.post1Title != "") {
                        Column {
                            Text(this.post1Title)
                                .fontSize(18)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF222222)
                                .margin(bottom: 8)

                            Text(this.post1Content)
                                .fontSize(14)
                                .fontColor(0xFF666666)
                                .margin(bottom: 10)

                            if (this.post1ImageUrl != "") {
                                Image(this.post1ImageUrl)
                                    .width(100.percent)
                                    .height(180)
                                    .borderRadius(16)
                                    .margin(bottom: 10)
                            }

                            Text(this.post1Author + " · " + this.post1Time)
                                .fontSize(12)
                                .fontColor(0xFFFF7A45)
                        }
                        .width(100.percent)
                        .padding(16)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 12)
                    }

                    if (this.post2Title != "") {
                        Column {
                            Text(this.post2Title)
                                .fontSize(18)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF222222)
                                .margin(bottom: 8)

                            Text(this.post2Content)
                                .fontSize(14)
                                .fontColor(0xFF666666)
                                .margin(bottom: 10)

                            if (this.post2ImageUrl != "") {
                                Image(this.post2ImageUrl)
                                    .width(100.percent)
                                    .height(180)
                                    .borderRadius(16)
                                    .margin(bottom: 10)
                            }

                            Text(this.post2Author + " · " + this.post2Time)
                                .fontSize(12)
                                .fontColor(0xFFFF7A45)
                        }
                        .width(100.percent)
                        .padding(16)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 12)
                    }

                    if (this.post3Title != "") {
                        Column {
                            Text(this.post3Title)
                                .fontSize(18)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF222222)
                                .margin(bottom: 8)

                            Text(this.post3Content)
                                .fontSize(14)
                                .fontColor(0xFF666666)
                                .margin(bottom: 10)

                            if (this.post3ImageUrl != "") {
                                Image(this.post3ImageUrl)
                                    .width(100.percent)
                                    .height(180)
                                    .borderRadius(16)
                                    .margin(bottom: 10)
                            }

                            Text(this.post3Author + " · " + this.post3Time)
                                .fontSize(12)
                                .fontColor(0xFFFF7A45)
                        }
                        .width(100.percent)
                        .padding(16)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 12)
                    }

                    if (this.post4Title != "") {
                        Column {
                            Text(this.post4Title)
                                .fontSize(18)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF222222)
                                .margin(bottom: 8)

                            Text(this.post4Content)
                                .fontSize(14)
                                .fontColor(0xFF666666)
                                .margin(bottom: 10)

                            if (this.post4ImageUrl != "") {
                                Image(this.post4ImageUrl)
                                    .width(100.percent)
                                    .height(180)
                                    .borderRadius(16)
                                    .margin(bottom: 10)
                            }

                            Text(this.post4Author + " · " + this.post4Time)
                                .fontSize(12)
                                .fontColor(0xFFFF7A45)
                        }
                        .width(100.percent)
                        .padding(16)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 12)
                    }

                    if (this.post5Title != "") {
                        Column {
                            Text(this.post5Title)
                                .fontSize(18)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF222222)
                                .margin(bottom: 8)

                            Text(this.post5Content)
                                .fontSize(14)
                                .fontColor(0xFF666666)
                                .margin(bottom: 10)

                            if (this.post5ImageUrl != "") {
                                Image(this.post5ImageUrl)
                                    .width(100.percent)
                                    .height(180)
                                    .borderRadius(16)
                                    .margin(bottom: 10)
                            }

                            Text(this.post5Author + " · " + this.post5Time)
                                .fontSize(12)
                                .fontColor(0xFFFF7A45)
                        }
                        .width(100.percent)
                        .padding(16)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 12)
                    }
                }
                .width(100.percent)
                .padding(left: 16, right: 16, top: 16, bottom: 24)
            }
            .layoutWeight(1)
        }
        .width(100.percent)
        .height(100.percent)
        .backgroundColor(0xFFF7F8FA)
    }
}
