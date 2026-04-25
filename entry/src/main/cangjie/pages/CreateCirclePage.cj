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
class CreateCirclePage {
    @State var name: String = ""
    @State var description: String = ""
    @State var publicMode: Bool = true

    @State var submitting: Bool = false
    @State var successMsg: String = ""
    @State var errorMsg: String = ""

    func getSubmitButtonText(): String {
        if (this.submitting) {
            return "创建中..."
        }
        return "创建圈子"
    }

    func getModeHintText(): String {
        if (this.publicMode) {
            return "公开圈子会展示在圈子列表中"
        }
        return "仅成员可见的圈子需要先加入"
    }

    func validate(): Bool {
        if (this.name == "") {
            this.errorMsg = "圈子名称不能为空"
            return false
        }

        if (this.description == "") {
            this.errorMsg = "圈子简介不能为空"
            return false
        }

        return true
    }

    func submitCircle() {
        this.errorMsg = ""
        this.successMsg = ""

        if (!this.validate()) {
            return
        }

        this.submitting = true

        CircleService.createCircle(
            this.name,
            this.description,
            this.publicMode,
            { _: String =>
                this.submitting = false
                this.successMsg = "圈子创建成功"
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
                        Text("新建圈子")
                            .fontSize(28)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFF24324A)
                            .margin(bottom: 6)

                        Text("创建你的兴趣组织，让更多同学加入进来")
                            .fontSize(14)
                            .fontColor(0xFF6D7B99)
                    }
                    .layoutWeight(1)

                    Text("创建")
                        .fontSize(13)
                        .fontColor(0xFF2F80FF)
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
                        .fontColor(0xFF2F80FF)
                        .borderRadius(20)
                        .margin(right: 8)
                        .onClick({ _: ClickEvent =>
                            Router.push(url: "CirclesPage")
                        })

                    Button("返回首页")
                        .layoutWeight(1)
                        .height(40)
                        .backgroundColor(0xFF2F80FF)
                        .fontColor(0xFFFFFFFF)
                        .borderRadius(20)
                        .onClick({ _: ClickEvent =>
                            Router.push(url: "HomePage")
                        })
                }
                .width(100.percent)
            }
            .width(100.percent)
            .padding(left: 16, right: 16, top: 24, bottom: 20)
            .backgroundColor(0xFFEAF2FF)

            Scroll {
                Column {
                    Column {
                        Text("圈子名称")
                            .fontSize(14)
                            .fontColor(0xFF7E8CA8)
                            .margin(bottom: 8)

                        TextInput(placeholder: "例如：周末桌游局")
                            .width(100.percent)
                            .height(44)
                            .backgroundColor(0xFFF7FAFF)
                            .borderRadius(16)
                            .margin(bottom: 16)
                            .onChange({ v: String =>
                                this.name = v
                            })

                        Text("圈子简介")
                            .fontSize(14)
                            .fontColor(0xFF7E8CA8)
                            .margin(bottom: 8)

                        TextInput(placeholder: "介绍一下你的圈子")
                            .width(100.percent)
                            .height(88)
                            .backgroundColor(0xFFF7FAFF)
                            .borderRadius(16)
                            .margin(bottom: 16)
                            .onChange({ v: String =>
                                this.description = v
                            })

                        Text("圈子可见范围")
                            .fontSize(14)
                            .fontColor(0xFF7E8CA8)
                            .margin(bottom: 10)

                        if (this.publicMode) {
                            Row {
                                Button("公开圈子")
                                    .layoutWeight(1)
                                    .height(40)
                                    .backgroundColor(0xFF2F80FF)
                                    .fontColor(0xFFFFFFFF)
                                    .borderRadius(20)
                                    .margin(right: 8)
                                    .onClick({ _: ClickEvent =>
                                        this.publicMode = true
                                    })

                                Button("仅成员可见")
                                    .layoutWeight(1)
                                    .height(40)
                                    .backgroundColor(0xFFFFFFFF)
                                    .fontColor(0xFF2F80FF)
                                    .borderRadius(20)
                                    .onClick({ _: ClickEvent =>
                                        this.publicMode = false
                                    })
                            }
                            .width(100.percent)
                            .margin(bottom: 12)
                        } else {
                            Row {
                                Button("公开圈子")
                                    .layoutWeight(1)
                                    .height(40)
                                    .backgroundColor(0xFFFFFFFF)
                                    .fontColor(0xFF2F80FF)
                                    .borderRadius(20)
                                    .margin(right: 8)
                                    .onClick({ _: ClickEvent =>
                                        this.publicMode = true
                                    })

                                Button("仅成员可见")
                                    .layoutWeight(1)
                                    .height(40)
                                    .backgroundColor(0xFF2F80FF)
                                    .fontColor(0xFFFFFFFF)
                                    .borderRadius(20)
                                    .onClick({ _: ClickEvent =>
                                        this.publicMode = false
                                    })
                            }
                            .width(100.percent)
                            .margin(bottom: 12)
                        }

                        Text(this.getModeHintText())
                            .fontSize(12)
                            .fontColor(0xFF9AA6BD)
                            .margin(bottom: 16)

                        if (this.errorMsg != "") {
                            Text(this.errorMsg)
                                .fontSize(14)
                                .fontColor(0xFFE96B6B)
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
                            .backgroundColor(0xFF2F80FF)
                            .fontColor(0xFFFFFFFF)
                            .borderRadius(18)
                            .margin(bottom: 12)
                            .onClick({ _: ClickEvent =>
                                this.submitCircle()
                            })

                        if (this.successMsg != "") {
                            Button("去逛圈子")
                                .width(100.percent)
                                .height(44)
                                .backgroundColor(0xFFEAF2FF)
                                .fontColor(0xFF2F80FF)
                                .borderRadius(18)
                                .onClick({ _: ClickEvent =>
                                    Router.push(url: "CirclesPage")
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
        .backgroundColor(0xFFF4F8FF)
    }
}