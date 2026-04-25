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
class MemberProfilePage {
    @State var userId: String = ""
    @State var nickname: String = "成员主页"
    @State var avatarUrl: String = ""
    @State var tagText: String = "圈子成员"
    @State var hobbies: String = ""
    @State var role: String = ""

    public func aboutToAppear(): Unit {
        this.userId = CircleService.getCurrentMemberUserId()
        this.nickname = CircleService.getCurrentMemberNickname()
        this.avatarUrl = CircleService.getCurrentMemberAvatarUrl()
        this.tagText = CircleService.getCurrentMemberTagText()
        this.hobbies = CircleService.getCurrentMemberHobbies()
        this.role = CircleService.getCurrentMemberRole()

        if (this.nickname == "") {
            this.nickname = "匿名用户"
        }
        if (this.tagText == "") {
            this.tagText = "圈子成员"
        }
    }

    func roleLabel(): String {
        if (this.role == "owner") {
            return "圈主"
        }
        if (this.role == "admin") {
            return "管理员"
        }
        return "成员"
    }

    func hobbyText(): String {
        if (this.hobbies == "") {
            return "暂未填写爱好"
        }
        return this.hobbies
    }

    func build() {
        Column {
            Column {
                Row {
                    Column {
                        Text("成员主页")
                            .fontSize(28)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFF24324A)
                            .margin(bottom: 6)

                        Text("圈子公开资料")
                            .fontSize(14)
                            .fontColor(0xFF6D7B99)
                    }
                    .layoutWeight(1)

                    Text(this.roleLabel())
                        .fontSize(13)
                        .fontColor(0xFF2F80FF)
                        .backgroundColor(0xFFFFFFFF)
                        .padding(left: 14, right: 14, top: 8, bottom: 8)
                        .borderRadius(18)
                }
                .width(100.percent)
                .margin(bottom: 16)

                Button("返回圈子")
                    .width(100.percent)
                    .height(40)
                    .backgroundColor(0xFFFFFFFF)
                    .fontColor(0xFF2F80FF)
                    .borderRadius(20)
                    .onClick({ _: ClickEvent =>
                        Router.push(url: "CircleDetailPage")
                    })
            }
            .width(100.percent)
            .padding(left: 16, right: 16, top: 24, bottom: 20)
            .backgroundColor(0xFFEAF2FF)

            Scroll {
                Column {
                    Column {
                        if (this.avatarUrl != "") {
                            Image(this.avatarUrl)
                                .width(92)
                                .height(92)
                                .borderRadius(46)
                                .margin(bottom: 14)
                        } else {
                            Row {
                                Text("人")
                                    .fontSize(26)
                                    .fontWeight(FontWeight.Bold)
                                    .fontColor(0xFFFFFFFF)
                            }
                            .width(92)
                            .height(92)
                            .justifyContent(FlexAlign.Center)
                            .alignItems(VerticalAlign.Center)
                            .backgroundColor(0xFF7AAFFF)
                            .borderRadius(46)
                            .margin(bottom: 14)
                        }

                        Text(this.nickname)
                            .fontSize(24)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFF24324A)
                            .margin(bottom: 12)

                        Row {
                            Text(this.tagText)
                                .fontSize(13)
                                .fontColor(0xFF2F80FF)
                                .backgroundColor(0xFFEAF2FF)
                                .padding(left: 12, right: 12, top: 6, bottom: 6)
                                .borderRadius(14)

                            Text(this.roleLabel())
                                .fontSize(13)
                                .fontColor(0xFF4E8DFF)
                                .backgroundColor(0xFFF0F6FF)
                                .padding(left: 12, right: 12, top: 6, bottom: 6)
                                .borderRadius(14)
                                .margin(left: 8)
                        }
                        .justifyContent(FlexAlign.Center)
                        .alignItems(VerticalAlign.Center)
                    }
                    .width(100.percent)
                    .padding(24)
                    .backgroundColor(0xFFFFFFFF)
                    .borderRadius(22)
                    .margin(bottom: 14)
                    .alignItems(HorizontalAlign.Center)

                    Column {
                        Text("爱好")
                            .fontSize(20)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFF24324A)
                            .margin(bottom: 10)

                        Text(this.hobbyText())
                            .fontSize(14)
                            .fontColor(0xFF6D7B99)
                            .lineHeight(22)
                    }
                    .width(100.percent)
                    .padding(18)
                    .backgroundColor(0xFFFFFFFF)
                    .borderRadius(20)
                    .alignItems(HorizontalAlign.Start)
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
