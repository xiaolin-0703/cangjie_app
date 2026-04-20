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
class CreatePostPage {
    @State var circleId: String = ""
    @State var circleName: String = ""

    @State var title: String = ""
    @State var content: String = ""

    @State var submitting: Bool = false
    @State var successMsg: String = ""
    @State var errorMsg: String = ""

    public func aboutToAppear(): Unit {
        this.circleId = CircleService.getCurrentCircleId()
        this.circleName = CircleService.getCurrentCircleName()
    }

    func getSubmitButtonText(): String {
        if (this.submitting) {
            return "发布中..."
        }
        return "发布帖子"
    }

    func getCircleHintText(): String {
        if (this.circleName == "") {
            return "在圈子里发布你的想法"
        }
        return "当前圈子：" + this.circleName
    }

    func validate(): Bool {
        if (this.circleId == "") {
            this.errorMsg = "圈子 ID 缺失"
            return false
        }

        if (this.title == "") {
            this.errorMsg = "帖子标题不能为空"
            return false
        }

        if (this.content == "") {
            this.errorMsg = "帖子内容不能为空"
            return false
        }

        return true
    }

    func submitPost() {
        this.errorMsg = ""
        this.successMsg = ""

        if (!this.validate()) {
            return
        }

        this.submitting = true

        CircleService.createPost(
            this.circleId,
            this.title,
            this.content,
            { _: String =>
                this.submitting = false
                this.successMsg = "帖子发布成功"
                this.title = ""
                this.content = ""
            },
            { msg: String =>
                this.submitting = false
                this.errorMsg = msg
            }
        )
    }

    func build() {
        Column {
            Column {
                Row {
                    Column {
                        Text("发布帖子")
                            .fontSize(28)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFF222222)
                            .margin(bottom: 6)

                        Text(this.getCircleHintText())
                            .fontSize(14)
                            .fontColor(0xFF666666)
                    }
                    .layoutWeight(1)

                    Text("发帖")
                        .fontSize(13)
                        .fontColor(0xFFFF7A45)
                        .backgroundColor(0xFFFFFFFF)
                        .padding(left: 14, right: 14, top: 8, bottom: 8)
                        .borderRadius(18)
                }
                .width(100.percent)
                .margin(bottom: 16)

                Row {
                    Button("返回详情")
                        .layoutWeight(1)
                        .height(40)
                        .backgroundColor(0xFFFFFFFF)
                        .fontColor(0xFFFF7A45)
                        .borderRadius(20)
                        .margin(right: 8)
                        .onClick({ _: ClickEvent =>
                            Router.push(url: "CircleDetailPage")
                        })

                    Button("返回圈子")
                        .layoutWeight(1)
                        .height(40)
                        .backgroundColor(0xFFFF7A45)
                        .fontColor(0xFFFFFFFF)
                        .borderRadius(20)
                        .onClick({ _: ClickEvent =>
                            Router.push(url: "CirclesPage")
                        })
                }
                .width(100.percent)
            }
            .width(100.percent)
            .padding(left: 16, right: 16, top: 24, bottom: 20)
            .backgroundColor(0xFFFFF3EE)

            Scroll {
                Column {
                    Column {
                        Text("帖子标题")
                            .fontSize(14)
                            .fontColor(0xFF777777)
                            .margin(bottom: 8)

                        TextInput(placeholder: "输入帖子标题")
                            .width(100.percent)
                            .height(44)
                            .backgroundColor(0xFFF4F5F7)
                            .borderRadius(16)
                            .margin(bottom: 16)
                            .onChange({ v: String =>
                                this.title = v
                            })

                        Text("帖子内容")
                            .fontSize(14)
                            .fontColor(0xFF777777)
                            .margin(bottom: 8)

                        TextInput(placeholder: "分享你的想法、活动、提问或招募信息")
                            .width(100.percent)
                            .height(120)
                            .backgroundColor(0xFFF4F5F7)
                            .borderRadius(16)
                            .margin(bottom: 16)
                            .onChange({ v: String =>
                                this.content = v
                            })

                        if (this.errorMsg != "") {
                            Text(this.errorMsg)
                                .fontSize(14)
                                .fontColor(0xFFFF0000)
                                .margin(bottom: 12)
                        }

                        if (this.successMsg != "") {
                            Text(this.successMsg)
                                .fontSize(14)
                                .fontColor(0xFF2E9B4B)
                                .margin(bottom: 12)
                        }

                        Button(this.getSubmitButtonText())
                            .width(100.percent)
                            .height(44)
                            .enabled(!this.submitting)
                            .backgroundColor(0xFFFF7A45)
                            .fontColor(0xFFFFFFFF)
                            .borderRadius(18)
                            .margin(bottom: 12)
                            .onClick({ _: ClickEvent =>
                                this.submitPost()
                            })

                        if (this.successMsg != "") {
                            Button("返回圈子详情")
                                .width(100.percent)
                                .height(44)
                                .backgroundColor(0xFFFFF1EA)
                                .fontColor(0xFFFF7A45)
                                .borderRadius(18)
                                .onClick({ _: ClickEvent =>
                                    Router.push(url: "CircleDetailPage")
                                })
                        }
                    }
                    .width(100.percent)
                    .padding(18)
                    .backgroundColor(0xFFFFFFFF)
                    .borderRadius(20)
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