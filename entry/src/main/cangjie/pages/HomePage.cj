package ohos_app_cangjie_entry.pages

internal import ohos.base.LengthProp
import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.router.*
import ohos_app_cangjie_entry.common.ApiConfig

@Entry
@Component
class HomePage {
    @State var welcomeName: String = "北航社区"

    func goToCreateEventPage() {
        Router.push(url: "CreateEventPage")
    }

    func goToEventsPage() {
        Router.push(url: "EventsPage")
    }

    func build() {
        Column {
            // 顶部欢迎区
            Column {
                Row {
                    Column {
                        Text("欢迎到来，${this.welcomeName}")
                            .fontSize(28)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFF222222)
                            .margin(bottom: 6)

                        Text("今天为你推荐了 18 位兴趣相投的同学")
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
            }
            .width(100.percent)
            .padding(left: 16, right: 16, top: 24, bottom: 20)
            .backgroundColor(0xFFFFF3EE)
            Button("个人中心")
            .width(100.percent)
            .height(46)
            .backgroundColor(0xFFFFF1EA)
            .fontColor(0xFFFF7A45)
            .borderRadius(16)
            .margin(top: 8)
            .onClick({ =>
                Router.push(url: "ProfilePage")
            })
            // 主内容区
            Scroll {
                Column {
                    // 运营卡片
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
                            .onClick({ =>
                                this.goToEventsPage()
                            })
                    }
                    .width(100.percent)
                    .padding(18)
                    .backgroundColor(0xFFFF7A45)
                    .borderRadius(20)
                    .margin(bottom: 16)

                    // 快捷入口
                    Row {
                        Column {
                            Text("找同好")
                                .fontSize(16)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF222222)
                                .margin(bottom: 8)

                            Text("按兴趣匹配新朋友")
                                .fontSize(12)
                                .fontColor(0xFF777777)
                        }
                        .layoutWeight(1)
                        .padding(14)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(right: 8, bottom: 12)

                        Column {
                            Text("逛圈子")
                                .fontSize(16)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF222222)
                                .margin(bottom: 8)

                            Text("发现感兴趣的组织")
                                .fontSize(12)
                                .fontColor(0xFF777777)
                        }
                        .layoutWeight(1)
                        .padding(14)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(right: 8, bottom: 12)

                        Column {
                            Text("约活动")
                                .fontSize(16)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF222222)
                                .margin(bottom: 8)

                            Text("参加本周热门活动")
                                .fontSize(12)
                                .fontColor(0xFF777777)
                                .margin(bottom: 10)

                            Button("去看看")
                                .width(100.percent)
                                .height(34)
                                .backgroundColor(0xFFFFF1EA)
                                .fontColor(0xFFFF7A45)
                                .borderRadius(16)
                                .onClick({ =>
                                    this.goToEventsPage()
                                })
                            Button("我发起的活动")
                            .width(100.percent)
                            .height(42)
                            .backgroundColor(0xFFFFF1EA)
                            .fontColor(0xFFFF7A45)
                            .borderRadius(14)
                            .onClick({ =>
                                Router.push(url: "MyCreatedEventsPage")
                            })
                        }
                        .layoutWeight(1)
                        .padding(14)
                        .backgroundColor(0xFFFFFFFF)
                        .borderRadius(18)
                        .margin(bottom: 12)
                    }
                    .width(100.percent)

                    // 为你推荐的同好
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
                    .margin(top: 14, bottom: 12)

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
                    .margin(bottom: 12)

                    // 热门圈子
                    Row {
                        Text("热门圈子")
                            .fontSize(20)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFF222222)

                        Text("发现更多")
                            .fontSize(13)
                            .fontColor(0xFFFF7A45)
                    }
                    .width(100.percent)
                    .justifyContent(FlexAlign.SpaceBetween)
                    .alignItems(VerticalAlign.Center)
                    .margin(top: 14, bottom: 12)

                    Row {
                        Column {
                            Text("周末桌游局")
                                .fontSize(17)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF222222)
                                .margin(bottom: 6)

                            Text("326人已加入")
                                .fontSize(12)
                                .fontColor(0xFFFF7A45)
                                .margin(bottom: 8)

                            Text("每周都有人组局，萌新友好")
                                .fontSize(13)
                                .fontColor(0xFF777777)
                        }
                        .layoutWeight(1)

                        Button("加入")
                            .width(72)
                            .height(36)
                            .backgroundColor(0xFFFFF1EA)
                            .fontColor(0xFFFF7A45)
                            .borderRadius(18)
                    }
                    .width(100.percent)
                    .padding(16)
                    .backgroundColor(0xFFFFFFFF)
                    .borderRadius(18)
                    .margin(bottom: 12)

                    Row {
                        Column {
                            Text("校园摄影社")
                                .fontSize(17)
                                .fontWeight(FontWeight.Bold)
                                .fontColor(0xFF222222)
                                .margin(bottom: 6)

                            Text("214人已加入")
                                .fontSize(12)
                                .fontColor(0xFFFF7A45)
                                .margin(bottom: 8)

                            Text("一起扫街、约拍、修图交流")
                                .fontSize(13)
                                .fontColor(0xFF777777)
                        }
                        .layoutWeight(1)

                        Button("加入")
                            .width(72)
                            .height(36)
                            .backgroundColor(0xFFFFF1EA)
                            .fontColor(0xFFFF7A45)
                            .borderRadius(18)
                    }
                    .width(100.percent)
                    .padding(16)
                    .backgroundColor(0xFFFFFFFF)
                    .borderRadius(18)
                    .margin(bottom: 12)

                    // 本周精选活动
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
                            .onClick({ =>
                                this.goToEventsPage()
                            })
                    }
                    .width(100.percent)
                    .justifyContent(FlexAlign.SpaceBetween)
                    .alignItems(VerticalAlign.Center)
                    .margin(top: 14, bottom: 12)

                    Button("发起活动")
                        .width(100.percent)
                        .height(42)
                        .backgroundColor(0xFFFFF1EA)
                        .fontColor(0xFFFF7A45)
                        .borderRadius(14)
                        .margin(bottom: 12)
                        .onClick({ =>
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
                    .margin(bottom: 12)

                    // 账号设置
                    Row {
                        Text("账号设置")
                            .fontSize(20)
                            .fontWeight(FontWeight.Bold)
                            .fontColor(0xFF222222)
                    }
                    .width(100.percent)
                    .margin(top: 14, bottom: 12)

                    Button("退出登录")
                        .width(100.percent)
                        .height(46)
                        .backgroundColor(0xFFFFFFFF)
                        .fontColor(0xFF666666)
                        .borderRadius(16)
                        .margin(top: 8, bottom: 24)
                        .onClick({ =>
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