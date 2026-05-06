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
class PostDetailPage {
    @State var postId: String = ""
    @State var title: String = ""
    @State var content: String = ""
    @State var author: String = ""
    @State var imageUrl: String = ""
    @State var timeText: String = "刚刚 发布"

    @State var isLiked: Bool = false
    @State var likeCount: Int64 = 128

    @State var inputText: String = ""
    @State var isSending: Bool = false
    @State var myComment: String = ""

    public func aboutToAppear(): Unit {
        this.postId = CircleService.getCurrentPostId()
        this.title = CircleService.getCurrentPostTitle()
        this.content = CircleService.getCurrentPostContent()
        this.author = CircleService.getCurrentPostAuthor()
        this.imageUrl = CircleService.getCurrentPostImageUrl()
    }

    func build() {
        Column {
            Row {
                Text("<").fontSize(22).fontColor(0xFF24324A).fontWeight(FontWeight.Bold).padding(right: 16).onClick({_: ClickEvent => Router.back() })
                Row().width(32).height(32).borderRadius(16).backgroundColor(0xFFDDEBFF).margin(right: 8)
                Text(if(this.author != "") { this.author } else { "匿名用户" }).fontSize(14).fontWeight(FontWeight.Bold).fontColor(0xFF24324A)
                Blank()
            }.width(100.percent).padding(left: 16, right: 16, top: 12, bottom: 12).backgroundColor(0xFFFFFFFF)

            Scroll {
                Column {
                    if (this.imageUrl != "") {
                        Image(this.imageUrl).width(100.percent).objectFit(ImageFit.Contain).backgroundColor(0xFFF0F5FF)
                    }

                    Column {
                        Text(this.title).fontSize(20).fontWeight(FontWeight.Bold).fontColor(0xFF24324A).margin(top: 16, bottom: 12)
                        Text(this.content).fontSize(15).fontColor(0xFF42526B).lineHeight(24).margin(bottom: 16)
                        Text(this.timeText).fontSize(12).fontColor(0xFF9AA6BD).margin(bottom: 20)

                        Divider().color(0xFFE2E8F0).margin(bottom: 16)
                        Text("评论区").fontSize(14).fontColor(0xFF6D7B99).margin(bottom: 16)

                        if (this.myComment != "") {
                            Row {
                                Row().width(28).height(28).borderRadius(14).backgroundColor(0xFFDDEBFF).margin(right: 10)
                                Column {
                                    Text("我").fontSize(13).fontColor(0xFF6D7B99).margin(bottom: 4)
                                    Text(this.myComment).fontSize(14).fontColor(0xFF24324A)
                                }.alignItems(HorizontalAlign.Start)
                            }.width(100.percent).alignItems(VerticalAlign.Top).margin(bottom: 16)
                        }

                        Row {
                            Row().width(28).height(28).borderRadius(14).backgroundColor(0xFFFFE4E4).margin(right: 10)
                            Column {
                                Text("热心同学").fontSize(13).fontColor(0xFF6D7B99).margin(bottom: 4)
                                Text("前排支持！").fontSize(14).fontColor(0xFF24324A)
                            }.alignItems(HorizontalAlign.Start)
                        }.width(100.percent).alignItems(VerticalAlign.Top).margin(bottom: 16)
                    }.padding(16).width(100.percent)
                    Row().height(80)
                }
            }.layoutWeight(1).backgroundColor(0xFFFFFFFF)

            Divider().color(0xFFE2E8F0)

            Row {
                TextInput(placeholder: "说点什么...", text: this.inputText)
                    .layoutWeight(1).height(36).backgroundColor(0xFFF1F4F8).borderRadius(18).margin(right: 12)
                    .onChange({ v: String => this.inputText = v })

                if (this.inputText != "") {
                    Text(if(this.isSending){"发送中"}else{"发送"})
                        .fontColor(0xFF2F80FF).fontWeight(FontWeight.Bold).margin(right: 4)
                        .onClick({ _: ClickEvent =>
                            if (this.isSending) { return }
                            this.myComment = this.inputText
                            this.inputText = ""
                            this.isSending = true
                            CircleService.sendComment(this.postId, this.myComment, { _: String =>
                                this.isSending = false
                            }, { msg: String => this.isSending = false })
                        })
                } else {
                    Row {
                        Text(if(this.isLiked) { "♥" } else { "♡" })
                            .fontSize(24).fontColor(if(this.isLiked){0xFFE96B6B}else{0xFF24324A}).margin(right: 4)
                            .onClick({ _: ClickEvent =>
                                this.isLiked = !this.isLiked
                                this.likeCount = this.likeCount + if(this.isLiked){ 1 } else { -1 }
                                CircleService.toggleLike(this.postId, { _: String => }, { msg: String => })
                            })
                        Text("${this.likeCount}").fontSize(13).fontColor(0xFF6D7B99)
                    }
                }
            }.width(100.percent).padding(left: 16, right: 16, top: 10, bottom: 20).backgroundColor(0xFFFFFFFF)
        }.width(100.percent).height(100.percent).backgroundColor(0xFFFFFFFF)
    }
}