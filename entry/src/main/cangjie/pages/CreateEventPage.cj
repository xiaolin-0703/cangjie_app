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

    func build() {
        Column {
            Text("发起活动")
                .fontSize(28)
                .fontWeight(FontWeight.Bold)
                .margin(bottom: 16)

            TextInput(placeholder: "活动标题")
                .width(88.percent)
                .margin(bottom: 12)
                .onChange({ v: String =>
                    this.title = v
                })

            TextInput(placeholder: "活动类型：offline 或 online")
                .width(88.percent)
                .margin(bottom: 12)
                .onChange({ v: String =>
                    this.eventType = v
                })

            TextInput(placeholder: "活动开始时间，例如 2026-05-20 19:00")
                .width(88.percent)
                .margin(bottom: 12)
                .onChange({ v: String =>
                    this.startTime = v
                })

            TextInput(placeholder: "活动地点")
                .width(88.percent)
                .margin(bottom: 12)
                .onChange({ v: String =>
                    this.location = v
                })

            TextInput(placeholder: "人数上限，例如 10")
                .width(88.percent)
                .margin(bottom: 12)
                .onChange({ v: String =>
                    this.capacity = v
                })

            TextInput(placeholder: "报名截止时间，例如 2026-05-20 17:00")
                .width(88.percent)
                .margin(bottom: 12)
                .onChange({ v: String =>
                    this.signupDeadline = v
                })

            TextInput(placeholder: "活动描述")
                .width(88.percent)
                .margin(bottom: 16)
                .onChange({ v: String =>
                    this.description = v
                })

            Button(this.getSubmitButtonText())
                .width(88.percent)
                .enabled(!this.submitting)
                .onClick({ =>
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
                })

            if (this.errorMsg != "") {
                Text(this.errorMsg)
                    .fontColor(0xFFFF0000)
                    .margin(top: 16)
            }

            if (this.submitSuccess) {
                Text(this.successMsg)
                    .fontColor(0xFF00AA00)
                    .margin(top: 16, bottom: 12)

                Button("进入活动广场")
                    .width(88.percent)
                    .onClick({ =>
                        Router.push(url: "EventsPage")
                    })
            }
        }
        .width(100.percent)
        .height(100.percent)
        .justifyContent(FlexAlign.Center)
    }
}