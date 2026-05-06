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
class EventDetailPage {
    @State var eventId: String = ""
    @State var title: String = "加载中..."
    @State var timeText: String = "..."
    @State var location: String = "..."
    @State var statusText: String = "..."
    @State var description: String = "..."
    @State var capacityText: String = "..."
    @State var deadlineText: String = "..."

    @State var loading: Bool = false
    @State var registerSuccess: Bool = false
    @State var errorMsg: String = ""

    // === 全新讨论区交互状态 ===
    @State var inputText: String = ""
    @State var replyTarget: String = "" // 当前正在回复谁

    // 模拟本地瞬间上屏的 3 个对话坑位
    @State var myDiscussion1: String = ""
    @State var myDiscussion2: String = ""
    @State var myDiscussion3: String = ""

    public func aboutToAppear(): Unit {
        this.eventId = EventService.getCurrentEventId()
        this.title = EventService.getCurrentEventTitle()
        this.timeText = EventService.getCurrentEventTimeText()
        this.location = EventService.getCurrentEventLocation()
        this.statusText = EventService.getCurrentEventStatusText()
        this.description = EventService.getCurrentEventDescription()
        this.capacityText = EventService.getCurrentEventCapacityText()
        this.deadlineText = EventService.getCurrentEventDeadlineText()
    }

    func build() {
        Column {
            // --- 顶部悬浮返回栏 ---
            Stack {
                Row().width(100.percent).height(200).backgroundColor(0xFF7FAEFF)
                Column {
                    Row {
                        Row { Text("<").fontSize(20).fontColor(0xFF24324A).fontWeight(FontWeight.Bold) }
                            .width(32).height(32).backgroundColor(0x99FFFFFF).borderRadius(16).justifyContent(FlexAlign.Center)
                            .onClick({_: ClickEvent => Router.back() })
                        Blank()
                    }.width(100.percent).padding(left: 16, right: 16, top: 12, bottom: 12)
                    Blank()
                }.width(100.percent).height(200)
            }.width(100.percent).height(200)

            Scroll {
                Column {
                    // --- 基本信息区 ---
                    Column {
                        Text(this.title).fontSize(22).fontWeight(FontWeight.Bold).fontColor(0xFF24324A).margin(bottom: 12)
                        Row { Text(this.statusText).fontSize(12).fontColor(0xFF2F80FF).backgroundColor(0xFFEAF2FF).padding(left: 8, right: 8, top: 4, bottom: 4).borderRadius(8) }.margin(bottom: 16)
                        Text(this.description).fontSize(14).fontColor(0xFF6D7B99).lineHeight(22).margin(bottom: 20)

                        Row { Text("时间").fontSize(13).fontColor(0xFF9AA6BD).width(50); Text(this.timeText).fontSize(13).fontColor(0xFF24324A) }.width(100.percent).margin(bottom: 10)
                        Row { Text("地点").fontSize(13).fontColor(0xFF9AA6BD).width(50); Text(this.location).fontSize(13).fontColor(0xFF24324A) }.width(100.percent).margin(bottom: 10)
                        Row { Text("人数").fontSize(13).fontColor(0xFF9AA6BD).width(50); Text(this.capacityText).fontSize(13).fontColor(0xFF24324A) }.width(100.percent).margin(bottom: 10)
                        Row { Text("截止").fontSize(13).fontColor(0xFF9AA6BD).width(50); Text(this.deadlineText).fontSize(13).fontColor(0xFFE96B6B) }.width(100.percent)
                    }.width(100.percent).padding(20).backgroundColor(0xFFFFFFFF).borderRadius(16).margin(top: -16, bottom: 12)

                    // --- 高级讨论区 ---
                    Column {
                        Text("活动讨论区").fontSize(16).fontWeight(FontWeight.Bold).fontColor(0xFF24324A).margin(bottom: 16)

                        // 1. 历史讨论帖 (带回复按钮)
                        Row {
                            Text("问").fontSize(12).fontColor(0xFFFFFFFF).backgroundColor(0xFF9AA6BD).padding(left: 4, right: 4, top: 2, bottom: 2).borderRadius(4).margin(right: 8)
                            Column {
                                Text("完全不会玩可以来吗？").fontSize(14).fontColor(0xFF24324A).margin(bottom: 4)
                                Text("组织者：可以的！我们会有专门的新手局教学。").fontSize(13).fontColor(0xFF6D7B99).margin(bottom: 6)

                                // 回复与追问互动栏
                                Row {
                                    Text("回复组织者").fontSize(12).fontColor(0xFF2F80FF).padding(right: 12).onClick({_: ClickEvent => this.replyTarget = "组织者" })
                                    Text("追问楼主").fontSize(12).fontColor(0xFF2F80FF).onClick({_: ClickEvent => this.replyTarget = "提问者" })
                                }
                            }.alignItems(HorizontalAlign.Start).layoutWeight(1)
                        }.width(100.percent).alignItems(VerticalAlign.Top).margin(bottom: 16)

                        // 2. 本地瞬间上屏的对话（最多显示最近3条）
                        if (this.myDiscussion1 != "") {
                            Row {
                                Text("我").fontSize(12).fontColor(0xFFFFFFFF).backgroundColor(0xFF2F80FF).padding(left: 4, right: 4, top: 2, bottom: 2).borderRadius(4).margin(right: 8)
                                Text(this.myDiscussion1).fontSize(14).fontColor(0xFF24324A).layoutWeight(1)
                            }.width(100.percent).alignItems(VerticalAlign.Top).margin(bottom: 12)
                        }
                        if (this.myDiscussion2 != "") {
                            Row {
                                Text("我").fontSize(12).fontColor(0xFFFFFFFF).backgroundColor(0xFF2F80FF).padding(left: 4, right: 4, top: 2, bottom: 2).borderRadius(4).margin(right: 8)
                                Text(this.myDiscussion2).fontSize(14).fontColor(0xFF24324A).layoutWeight(1)
                            }.width(100.percent).alignItems(VerticalAlign.Top).margin(bottom: 12)
                        }
                        if (this.myDiscussion3 != "") {
                            Row {
                                Text("我").fontSize(12).fontColor(0xFFFFFFFF).backgroundColor(0xFF2F80FF).padding(left: 4, right: 4, top: 2, bottom: 2).borderRadius(4).margin(right: 8)
                                Text(this.myDiscussion3).fontSize(14).fontColor(0xFF24324A).layoutWeight(1)
                            }.width(100.percent).alignItems(VerticalAlign.Top).margin(bottom: 12)
                        }
                    }.width(100.percent).padding(20).backgroundColor(0xFFFFFFFF).borderRadius(16)

                    Row().height(100)
                }
            }.layoutWeight(1)

            Divider().color(0xFFE2E8F0)
            if (this.errorMsg != "") { Text(this.errorMsg).fontSize(12).fontColor(0xFFE96B6B).padding(8).width(100.percent).textAlign(TextAlign.Center) }

            // --- 底部互动发问栏 ---
            Row {
                // 如果有回复目标，显示蓝色小胶囊
                if (this.replyTarget != "") {
                    Row {
                        Text("回复 ${this.replyTarget} ✖").fontSize(12).fontColor(0xFFFFFFFF)
                    }.backgroundColor(0xFF2F80FF).padding(left: 8, right: 8, top: 6, bottom: 6).borderRadius(12).margin(right: 8)
                    .onClick({_: ClickEvent => this.replyTarget = "" }) // 点击取消回复
                }

                TextInput(placeholder: if(this.replyTarget != ""){"输入回复..."}else{"提问或讨论..."}, text: this.inputText)
                    .layoutWeight(1).height(38).backgroundColor(0xFFF1F4F8).borderRadius(19).margin(right: 12)
                    .onChange({ v: String => this.inputText = v })

                if (this.inputText != "") {
                    Text("发送")
                        .fontColor(0xFF2F80FF).fontWeight(FontWeight.Bold).margin(right: 12)
                        .onClick({ _: ClickEvent =>
                            // 1. 拼接回复前缀
                            let finalMsg = if (this.replyTarget != "") { "回复 ${this.replyTarget}：${this.inputText}" } else { this.inputText }

                            // 2. 瞬间上屏逻辑
                            if (this.myDiscussion1 == "") { this.myDiscussion1 = finalMsg }
                            else if (this.myDiscussion2 == "") { this.myDiscussion2 = finalMsg }
                            else { this.myDiscussion3 = finalMsg }

                            let rawInput = this.inputText // 备份下来发给后端
                            this.inputText = ""           // 清空输入框
                            this.replyTarget = ""         // 清空回复状态

                            // 3. 静默请求后端
                            EventService.addDiscussion(this.eventId, rawInput, { _: String =>
                                // 成功了不用管，UI已经上屏了
                            }, { msg: String =>
                                this.errorMsg = "同步到服务器失败：" + msg
                            })
                        })
                }

                Button(if(this.registerSuccess) { "已报名" } else if(this.loading) { "报名中..." } else { "立即报名" })
                    .width(100).height(38).backgroundColor(if(this.registerSuccess){0xFF9AA6BD}else{0xFF2F80FF}).fontColor(0xFFFFFFFF)
                    .borderRadius(19).fontWeight(FontWeight.Bold).fontSize(14)
                    .enabled(!this.loading && !this.registerSuccess)
                    .onClick({ _: ClickEvent =>
                        if (this.eventId == "") { return }
                        this.registerSuccess = true
                        this.statusText = "报名成功"
                        EventService.registerEvent(this.eventId, { _: String => }, { msg: String => })
                    })
            }.width(100.percent).padding(left: 16, right: 16, top: 10, bottom: 20).backgroundColor(0xFFFFFFFF)
        }.width(100.percent).height(100.percent).backgroundColor(0xFFF4F8FF)
    }
}