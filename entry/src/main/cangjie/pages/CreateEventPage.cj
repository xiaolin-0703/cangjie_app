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
class CreateEventPage {
    @State var title: String = ""
    @State var eventType: String = "offline"
    @State var startTime: String = ""
    @State var location: String = ""
    @State var capacity: String = "10"
    @State var signupDeadline: String = ""
    @State var description: String = ""
    @State var errorMsg: String = ""
    @State var submitting: Bool = false
    @State var submitSuccess: Bool = false
    @State var successMsg: String = ""

    func getSubmitButtonText(): String {
        if (this.submitting) {
            return "创建中..."
        }
        return "发布活动"
    }

    func submitEvent() {
        if (this.title == "") {
            this.errorMsg = "请输入活动标题"
            return
        }

        if (this.startTime == "") {
            this.errorMsg = "请输入活动开始时间"
            return
        }

        if (this.location == "") {
            this.errorMsg = "请输入活动地点"
            return
        }

        if (this.capacity == "") {
            this.errorMsg = "请输入人数上限"
            return
        }

        this.submitting = true
        this.errorMsg = ""
        this.submitSuccess = false
        this.successMsg = ""

        EventService.createEvent(
            this.title,
            this.eventType,
            this.startTime,
            this.location,
            this.capacity,
            this.signupDeadline,
            this.description,
            { _: String =>
                this.submitting = false
                this.submitSuccess = true
                this.successMsg = "活动创建成功"
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
                        Text("发起活动")
                            .fontSize(28)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFF24324A)
                            .margin(bottom: 6)

                        Text("组织一次校园活动，让同学们更容易找到你")
                            .fontSize(14)
                            .fontColor(0xFF6D7B99)
                    }
                    .layoutWeight(1)

                    Text("活动")
                        .fontSize(13)
                        .fontColor(0xFF2F80FF)
                        .backgroundColor(0xFFFFFFFF)
                        .padding(left: 14, right: 14, top: 8, bottom: 8)
                        .borderRadius(18)
                }
                .width(100.percent)
                .margin(bottom: 16)

                Row {
                    Button("返回活动")
                        .layoutWeight(1)
                        .height(40)
                        .backgroundColor(0xFFFFFFFF)
                        .fontColor(0xFF2F80FF)
                        .borderRadius(20)
                        .margin(right: 8)
                        .onClick({ =>
                            Router.push(url: "EventsPage")
                        })

                    Button("返回首页")
                        .layoutWeight(1)
                        .height(40)
                        .backgroundColor(0xFF2F80FF)
                        .fontColor(0xFFFFFFFF)
                        .borderRadius(20)
                        .onClick({ =>
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
                        Text("活动标题")
                            .fontSize(14)
                            .fontColor(0xFF7E8CA8)
                            .margin(bottom: 8)

                        TextInput(placeholder: "例如：周五飞盘体验局")
                            .width(100.percent)
                            .height(44)
                            .backgroundColor(0xFFF7FAFF)
                            .borderRadius(16)
                            .margin(bottom: 16)
                            .onChange({ v: String =>
                                this.title = v
                            })

                        Text("活动类型")
                            .fontSize(14)
                            .fontColor(0xFF7E8CA8)
                            .margin(bottom: 10)

                        if (this.eventType == "offline") {
                            Row {
                                Button("线下活动")
                                    .layoutWeight(1)
                                    .height(40)
                                    .backgroundColor(0xFF2F80FF)
                                    .fontColor(0xFFFFFFFF)
                                    .borderRadius(20)
                                    .margin(right: 8)
                                    .onClick({ =>
                                        this.eventType = "offline"
                                    })

                                Button("线上活动")
                                    .layoutWeight(1)
                                    .height(40)
                                    .backgroundColor(0xFFEAF2FF)
                                    .fontColor(0xFF2F80FF)
                                    .borderRadius(20)
                                    .onClick({ =>
                                        this.eventType = "online"
                                    })
                            }
                            .width(100.percent)
                            .margin(bottom: 16)
                        } else {
                            Row {
                                Button("线下活动")
                                    .layoutWeight(1)
                                    .height(40)
                                    .backgroundColor(0xFFEAF2FF)
                                    .fontColor(0xFF2F80FF)
                                    .borderRadius(20)
                                    .margin(right: 8)
                                    .onClick({ =>
                                        this.eventType = "offline"
                                    })

                                Button("线上活动")
                                    .layoutWeight(1)
                                    .height(40)
                                    .backgroundColor(0xFF2F80FF)
                                    .fontColor(0xFFFFFFFF)
                                    .borderRadius(20)
                                    .onClick({ =>
                                        this.eventType = "online"
                                    })
                            }
                            .width(100.percent)
                            .margin(bottom: 16)
                        }

                        Text("开始时间")
                            .fontSize(14)
                            .fontColor(0xFF7E8CA8)
                            .margin(bottom: 8)

                        TextInput(placeholder: "例如 2026-05-20 19:00")
                            .width(100.percent)
                            .height(44)
                            .backgroundColor(0xFFF7FAFF)
                            .borderRadius(16)
                            .margin(bottom: 16)
                            .onChange({ v: String =>
                                this.startTime = v
                            })

                        Text("活动地点")
                            .fontSize(14)
                            .fontColor(0xFF7E8CA8)
                            .margin(bottom: 8)

                        TextInput(placeholder: "输入活动地点")
                            .width(100.percent)
                            .height(44)
                            .backgroundColor(0xFFF7FAFF)
                            .borderRadius(16)
                            .margin(bottom: 16)
                            .onChange({ v: String =>
                                this.location = v
                            })

                        Text("人数上限")
                            .fontSize(14)
                            .fontColor(0xFF7E8CA8)
                            .margin(bottom: 8)

                        TextInput(placeholder: "例如 10")
                            .width(100.percent)
                            .height(44)
                            .backgroundColor(0xFFF7FAFF)
                            .borderRadius(16)
                            .margin(bottom: 16)
                            .onChange({ v: String =>
                                this.capacity = v
                            })

                        Text("报名截止")
                            .fontSize(14)
                            .fontColor(0xFF7E8CA8)
                            .margin(bottom: 8)

                        TextInput(placeholder: "例如 2026-05-20 17:00")
                            .width(100.percent)
                            .height(44)
                            .backgroundColor(0xFFF7FAFF)
                            .borderRadius(16)
                            .margin(bottom: 16)
                            .onChange({ v: String =>
                                this.signupDeadline = v
                            })

                        Text("活动描述")
                            .fontSize(14)
                            .fontColor(0xFF7E8CA8)
                            .margin(bottom: 8)

                        TextInput(placeholder: "写下活动亮点、集合方式或注意事项")
                            .width(100.percent)
                            .height(100)
                            .backgroundColor(0xFFF7FAFF)
                            .borderRadius(16)
                            .margin(bottom: 16)
                            .onChange({ v: String =>
                                this.description = v
                            })

                        if (this.errorMsg != "") {
                            Text(this.errorMsg)
                                .fontSize(14)
                                .fontColor(0xFFE96B6B)
                                .margin(bottom: 12)
                        }

                        if (this.submitSuccess) {
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
                            .onClick({ =>
                                this.submitEvent()
                            })

                        if (this.submitSuccess) {
                            Button("进入活动广场")
                                .width(100.percent)
                                .height(44)
                                .backgroundColor(0xFFEAF2FF)
                                .fontColor(0xFF2F80FF)
                                .borderRadius(18)
                                .onClick({ =>
                                    Router.push(url: "EventsPage")
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
