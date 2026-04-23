package ohos_app_cangjie_entry.pages

internal import ohos.base.LengthProp
import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.router.*

@Entry
@Component
class HomePage {
    @State var currentTab: String = "recommend"

    func goToEventsPage() {
        Router.push(url: "EventsPage")
    }

    func goToCirclesPage() {
        Router.push(url: "CirclesPage")
    }

    func goToProfilePage() {
        Router.push(url: "ProfilePage")
    }

    func goToCreatePostPage() {
        Router.push(url: "CreatePostPage")
    }

    func build() {
        Column {
            Column {
                Row {
                    Row {
                        if (this.currentTab == "recommend") {
                            Column {
                                Text("推荐")
                                    .fontColor(0xFF1D2B53)
                                    .fontSize(18)
                                    .fontWeight(FontWeight.Bold)
                                    .padding(top: 6, bottom: 6)
                                    .onClick({ _: ClickEvent =>
                                        this.currentTab = "recommend"
                                    })

                                Row {}
                                    .width(20)
                                    .height(3)
                                    .backgroundColor(0xFF2F80FF)
                                    .borderRadius(2)
                            }
                            .margin(right: 20)
                        } else {
                            Column {
                                Text("推荐")
                                    .fontColor(0xFF74829C)
                                    .fontSize(17)
                                    .padding(top: 6, bottom: 6)
                                    .onClick({ _: ClickEvent =>
                                        this.currentTab = "recommend"
                                    })

                                Row {}
                                    .width(20)
                                    .height(3)
                                    .backgroundColor(0x00000000)
                            }
                            .margin(right: 20)
                        }

                        if (this.currentTab == "latest") {
                            Column {
                                Text("最新")
                                    .fontColor(0xFF1D2B53)
                                    .fontSize(18)
                                    .fontWeight(FontWeight.Bold)
                                    .padding(top: 6, bottom: 6)
                                    .onClick({ _: ClickEvent =>
                                        this.currentTab = "latest"
                                    })

                                Row {}
                                    .width(20)
                                    .height(3)
                                    .backgroundColor(0xFF2F80FF)
                                    .borderRadius(2)
                            }
                        } else {
                            Column {
                                Text("最新")
                                    .fontColor(0xFF74829C)
                                    .fontSize(17)
                                    .padding(top: 6, bottom: 6)
                                    .onClick({ _: ClickEvent =>
                                        this.currentTab = "latest"
                                    })

                                Row {}
                                    .width(20)
                                    .height(3)
                                    .backgroundColor(0x00000000)
                            }
                        }
                    }
                    .layoutWeight(3)
                    .alignItems(VerticalAlign.Center)

                    Row {
                        Text("⌕")
                            .width(30)
                            .height(30)
                            .fontColor(0xFF2F80FF)
                            .fontSize(18)
                            .fontWeight(FontWeight.Bold)
                            .textAlign(TextAlign.Center)
                    }
                    .layoutWeight(1)
                    .justifyContent(FlexAlign.End)
                }
                .width(100.percent)
                .alignItems(VerticalAlign.Center)
            }
            .width(100.percent)
            .padding(left: 12, right: 12, top: 10, bottom: 10)
            .backgroundColor(0xFFFFFFFF)

            Scroll {
                Column {
                    if (this.currentTab == "recommend") {
                        Row {
                            Column {
                                Column {
                                    Row {
                                        Text("校园随拍")
                                            .fontSize(17)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFF2F80FF)
                                    }
                                    .width(100.percent)
                                    .height(148)
                                    .justifyContent(FlexAlign.Center)
                                    .alignItems(VerticalAlign.Center)
                                    .backgroundColor(0xFFDDEBFF)
                                    .borderRadius(14)
                                    .margin(bottom: 8)

                                    Text("晚霞把教学楼照成了蓝橘色")
                                        .fontSize(14)
                                        .fontWeight(FontWeight.Bold)
                                        .fontColor(0xFF24324A)
                                        .margin(bottom: 6)

                                    Text("路过新主楼时随手拍到，今天校园真的很像电影镜头。")
                                        .fontSize(12)
                                        .fontColor(0xFF6D7B99)
                                        .lineHeight(18)
                                        .margin(bottom: 10)

                                    Row {
                                        Row {
                                            Row {
                                                Text("知")
                                                    .fontSize(12)
                                                    .fontColor(0xFFFFFFFF)
                                            }
                                            .width(28)
                                            .height(28)
                                            .backgroundColor(0xFF7FB2FF)
                                            .borderRadius(14)
                                            .justifyContent(FlexAlign.Center)
                                            .alignItems(VerticalAlign.Center)
                                            .margin(right: 8)

                                            Column {
                                                Text("知行同学")
                                                    .fontSize(12)
                                                    .fontColor(0xFF42526B)
                                                    .margin(bottom: 4)

                                                Text("摄影圈")
                                                    .fontSize(10)
                                                    .fontColor(0xFF2F80FF)
                                                    .backgroundColor(0xFFEAF2FF)
                                                    .padding(left: 7, right: 7, top: 3, bottom: 3)
                                                    .borderRadius(9)
                                            }
                                            .alignItems(HorizontalAlign.Start)
                                        }

                                        Text("❤ 128")
                                            .fontSize(12)
                                            .fontColor(0xFF7E8CA8)
                                    }
                                    .width(100.percent)
                                    .justifyContent(FlexAlign.SpaceBetween)
                                    .alignItems(VerticalAlign.Bottom)
                                }
                                .width(100.percent)
                                .padding(left: 8, right: 8, top: 8, bottom: 10)
                                .backgroundColor(0xFFFFFFFF)
                                .borderRadius(16)
                                .margin(bottom: 10)

                                Column {
                                    Row {
                                        Text("活动")
                                            .fontSize(11)
                                            .fontColor(0xFFFF8A3D)
                                            .backgroundColor(0xFFFFF1E7)
                                            .padding(left: 8, right: 8, top: 4, bottom: 4)
                                            .borderRadius(10)
                                    }
                                    .margin(bottom: 8)

                                    Row {
                                        Text("飞盘体验局")
                                            .fontSize(17)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFFFF8A3D)
                                    }
                                    .width(100.percent)
                                    .height(102)
                                    .justifyContent(FlexAlign.Center)
                                    .alignItems(VerticalAlign.Center)
                                    .backgroundColor(0xFFFFF4EB)
                                    .borderRadius(14)
                                    .margin(bottom: 8)

                                    Text("今晚 19:00，一起跑起来")
                                        .fontSize(14)
                                        .fontWeight(FontWeight.Bold)
                                        .fontColor(0xFF24324A)
                                        .margin(bottom: 6)

                                    Text("零基础也能来，社恐友好，现场会带基础教学和简单对抗。")
                                        .fontSize(12)
                                        .fontColor(0xFF6D7B99)
                                        .lineHeight(18)
                                        .margin(bottom: 10)

                                    Column {
                                        Text("报名截止：05-12 18:00")
                                            .fontSize(11)
                                            .fontColor(0xFF8D6E63)
                                            .margin(bottom: 4)

                                        Text("人数限制：40人")
                                            .fontSize(11)
                                            .fontColor(0xFF8D6E63)
                                            .margin(bottom: 4)

                                        Text("报名中")
                                            .fontSize(11)
                                            .fontColor(0xFFFF8A3D)
                                    }
                                    .alignItems(HorizontalAlign.Start)
                                }
                                .width(100.percent)
                                .padding(left: 8, right: 8, top: 8, bottom: 10)
                                .backgroundColor(0xFFFFFFFF)
                                .borderRadius(16)
                                .margin(bottom: 10)

                                Column {
                                    Row {
                                        Text("灵感记录")
                                            .fontSize(17)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFF2F80FF)
                                    }
                                    .width(100.percent)
                                    .height(126)
                                    .justifyContent(FlexAlign.Center)
                                    .alignItems(VerticalAlign.Center)
                                    .backgroundColor(0xFFE8F5FF)
                                    .borderRadius(14)
                                    .margin(bottom: 8)

                                    Text("自习室门口的猫今天也在上班")
                                        .fontSize(14)
                                        .fontWeight(FontWeight.Bold)
                                        .fontColor(0xFF24324A)
                                        .margin(bottom: 6)

                                    Text("连续三天都看到它趴在同一个位置，治愈值拉满。")
                                        .fontSize(12)
                                        .fontColor(0xFF6D7B99)
                                        .lineHeight(18)
                                        .margin(bottom: 10)

                                    Row {
                                        Row {
                                            Row {
                                                Text("阿")
                                                    .fontSize(12)
                                                    .fontColor(0xFFFFFFFF)
                                            }
                                            .width(28)
                                            .height(28)
                                            .backgroundColor(0xFF8BB6FF)
                                            .borderRadius(14)
                                            .justifyContent(FlexAlign.Center)
                                            .alignItems(VerticalAlign.Center)
                                            .margin(right: 8)

                                            Column {
                                                Text("阿宁")
                                                    .fontSize(12)
                                                    .fontColor(0xFF42526B)
                                                    .margin(bottom: 4)

                                                Text("校园日常")
                                                    .fontSize(10)
                                                    .fontColor(0xFF2F80FF)
                                                    .backgroundColor(0xFFEAF2FF)
                                                    .padding(left: 7, right: 7, top: 3, bottom: 3)
                                                    .borderRadius(9)
                                            }
                                            .alignItems(HorizontalAlign.Start)
                                        }

                                        Text("❤ 96")
                                            .fontSize(12)
                                            .fontColor(0xFF7E8CA8)
                                    }
                                    .width(100.percent)
                                    .justifyContent(FlexAlign.SpaceBetween)
                                    .alignItems(VerticalAlign.Bottom)
                                }
                                .width(100.percent)
                                .padding(left: 8, right: 8, top: 8, bottom: 10)
                                .backgroundColor(0xFFFFFFFF)
                                .borderRadius(16)
                            }
                            .layoutWeight(1)
                            .margin(right: 6)

                            Column {
                                Column {
                                    Row {
                                        Text("社团日常")
                                            .fontSize(17)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFF2F80FF)
                                    }
                                    .width(100.percent)
                                    .height(116)
                                    .justifyContent(FlexAlign.Center)
                                    .alignItems(VerticalAlign.Center)
                                    .backgroundColor(0xFFEAF2FF)
                                    .borderRadius(14)
                                    .margin(bottom: 8)

                                    Text("排练结束后顺路去吃了北门那家米线")
                                        .fontSize(14)
                                        .fontWeight(FontWeight.Bold)
                                        .fontColor(0xFF24324A)
                                        .margin(bottom: 6)

                                    Text("今天合唱排练状态不错，结束后大家一起去夜宵，气氛特别好。")
                                        .fontSize(12)
                                        .fontColor(0xFF6D7B99)
                                        .lineHeight(18)
                                        .margin(bottom: 10)

                                    Row {
                                        Row {
                                            Row {
                                                Text("小")
                                                    .fontSize(12)
                                                    .fontColor(0xFFFFFFFF)
                                            }
                                            .width(28)
                                            .height(28)
                                            .backgroundColor(0xFF73A8FF)
                                            .borderRadius(14)
                                            .justifyContent(FlexAlign.Center)
                                            .alignItems(VerticalAlign.Center)
                                            .margin(right: 8)

                                            Column {
                                                Text("小周")
                                                    .fontSize(12)
                                                    .fontColor(0xFF42526B)
                                                    .margin(bottom: 4)

                                                Text("合唱团")
                                                    .fontSize(10)
                                                    .fontColor(0xFF2F80FF)
                                                    .backgroundColor(0xFFEAF2FF)
                                                    .padding(left: 7, right: 7, top: 3, bottom: 3)
                                                    .borderRadius(9)
                                            }
                                            .alignItems(HorizontalAlign.Start)
                                        }

                                        Text("❤ 72")
                                            .fontSize(12)
                                            .fontColor(0xFF7E8CA8)
                                    }
                                    .width(100.percent)
                                    .justifyContent(FlexAlign.SpaceBetween)
                                    .alignItems(VerticalAlign.Bottom)
                                }
                                .width(100.percent)
                                .padding(left: 8, right: 8, top: 8, bottom: 10)
                                .backgroundColor(0xFFFFFFFF)
                                .borderRadius(16)
                                .margin(bottom: 10)

                                Column {
                                    Row {
                                        Text("氛围感封面")
                                            .fontSize(17)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFF2F80FF)
                                    }
                                    .width(100.percent)
                                    .height(164)
                                    .justifyContent(FlexAlign.Center)
                                    .alignItems(VerticalAlign.Center)
                                    .backgroundColor(0xFFD9EAFF)
                                    .borderRadius(14)
                                    .margin(bottom: 8)

                                    Text("今天图书馆这组蓝白色调太适合出片")
                                        .fontSize(14)
                                        .fontWeight(FontWeight.Bold)
                                        .fontColor(0xFF24324A)
                                        .margin(bottom: 6)

                                    Text("想做一个‘北航春天’拍照点合集，这里先收藏一下。")
                                        .fontSize(12)
                                        .fontColor(0xFF6D7B99)
                                        .lineHeight(18)
                                        .margin(bottom: 10)

                                    Row {
                                        Row {
                                            Row {
                                                Text("木")
                                                    .fontSize(12)
                                                    .fontColor(0xFFFFFFFF)
                                            }
                                            .width(28)
                                            .height(28)
                                            .backgroundColor(0xFF5E97FF)
                                            .borderRadius(14)
                                            .justifyContent(FlexAlign.Center)
                                            .alignItems(VerticalAlign.Center)
                                            .margin(right: 8)

                                            Column {
                                                Text("木子")
                                                    .fontSize(12)
                                                    .fontColor(0xFF42526B)
                                                    .margin(bottom: 4)

                                                Text("摄影圈")
                                                    .fontSize(10)
                                                    .fontColor(0xFF2F80FF)
                                                    .backgroundColor(0xFFEAF2FF)
                                                    .padding(left: 7, right: 7, top: 3, bottom: 3)
                                                    .borderRadius(9)
                                            }
                                            .alignItems(HorizontalAlign.Start)
                                        }

                                        Text("❤ 184")
                                            .fontSize(12)
                                            .fontColor(0xFF7E8CA8)
                                    }
                                    .width(100.percent)
                                    .justifyContent(FlexAlign.SpaceBetween)
                                    .alignItems(VerticalAlign.Bottom)
                                }
                                .width(100.percent)
                                .padding(left: 8, right: 8, top: 8, bottom: 10)
                                .backgroundColor(0xFFFFFFFF)
                                .borderRadius(16)
                                .margin(bottom: 10)

                                Column {
                                    Row {
                                        Text("操场夜跑")
                                            .fontSize(17)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFF2F80FF)
                                    }
                                    .width(100.percent)
                                    .height(132)
                                    .justifyContent(FlexAlign.Center)
                                    .alignItems(VerticalAlign.Center)
                                    .backgroundColor(0xFFE3EEFF)
                                    .borderRadius(14)
                                    .margin(bottom: 8)

                                    Text("今天的风很舒服，夜跑体验满分")
                                        .fontSize(14)
                                        .fontWeight(FontWeight.Bold)
                                        .fontColor(0xFF24324A)
                                        .margin(bottom: 6)

                                    Text("操场人很多，感觉最近大家都重新开始认真运动了。")
                                        .fontSize(12)
                                        .fontColor(0xFF6D7B99)
                                        .lineHeight(18)
                                        .margin(bottom: 10)

                                    Row {
                                        Row {
                                            Row {
                                                Text("晨")
                                                    .fontSize(12)
                                                    .fontColor(0xFFFFFFFF)
                                            }
                                            .width(28)
                                            .height(28)
                                            .backgroundColor(0xFF6CA3FF)
                                            .borderRadius(14)
                                            .justifyContent(FlexAlign.Center)
                                            .alignItems(VerticalAlign.Center)
                                            .margin(right: 8)

                                            Column {
                                                Text("晨星")
                                                    .fontSize(12)
                                                    .fontColor(0xFF42526B)
                                                    .margin(bottom: 4)

                                                Text("跑步圈")
                                                    .fontSize(10)
                                                    .fontColor(0xFF2F80FF)
                                                    .backgroundColor(0xFFEAF2FF)
                                                    .padding(left: 7, right: 7, top: 3, bottom: 3)
                                                    .borderRadius(9)
                                            }
                                            .alignItems(HorizontalAlign.Start)
                                        }

                                        Text("❤ 56")
                                            .fontSize(12)
                                            .fontColor(0xFF7E8CA8)
                                    }
                                    .width(100.percent)
                                    .justifyContent(FlexAlign.SpaceBetween)
                                    .alignItems(VerticalAlign.Bottom)
                                }
                                .width(100.percent)
                                .padding(left: 8, right: 8, top: 8, bottom: 10)
                                .backgroundColor(0xFFFFFFFF)
                                .borderRadius(16)
                            }
                            .layoutWeight(1)
                        }
                        .width(100.percent)
                    } else {
                        Row {
                            Column {
                                Column {
                                    Row {
                                        Text("刚刚更新")
                                            .fontSize(17)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFF2F80FF)
                                    }
                                    .width(100.percent)
                                    .height(122)
                                    .justifyContent(FlexAlign.Center)
                                    .alignItems(VerticalAlign.Center)
                                    .backgroundColor(0xFFEAF2FF)
                                    .borderRadius(14)
                                    .margin(bottom: 8)

                                    Text("操场今天风很舒服，跑步的人特别多")
                                        .fontSize(14)
                                        .fontWeight(FontWeight.Bold)
                                        .fontColor(0xFF24324A)
                                        .margin(bottom: 6)

                                    Text("晚上 8 点随手拍的，感觉最近大家都开始恢复运动了。")
                                        .fontSize(12)
                                        .fontColor(0xFF6D7B99)
                                        .lineHeight(18)
                                        .margin(bottom: 10)

                                    Row {
                                        Row {
                                            Row {
                                                Text("晨")
                                                    .fontSize(12)
                                                    .fontColor(0xFFFFFFFF)
                                            }
                                            .width(28)
                                            .height(28)
                                            .backgroundColor(0xFF7CAFFF)
                                            .borderRadius(14)
                                            .justifyContent(FlexAlign.Center)
                                            .alignItems(VerticalAlign.Center)
                                            .margin(right: 8)

                                            Column {
                                                Text("晨星")
                                                    .fontSize(12)
                                                    .fontColor(0xFF42526B)
                                                    .margin(bottom: 4)

                                                Text("跑步圈")
                                                    .fontSize(10)
                                                    .fontColor(0xFF2F80FF)
                                                    .backgroundColor(0xFFEAF2FF)
                                                    .padding(left: 7, right: 7, top: 3, bottom: 3)
                                                    .borderRadius(9)
                                            }
                                            .alignItems(HorizontalAlign.Start)
                                        }

                                        Text("❤ 33")
                                            .fontSize(12)
                                            .fontColor(0xFF7E8CA8)
                                    }
                                    .width(100.percent)
                                    .justifyContent(FlexAlign.SpaceBetween)
                                    .alignItems(VerticalAlign.Bottom)
                                }
                                .width(100.percent)
                                .padding(left: 8, right: 8, top: 8, bottom: 10)
                                .backgroundColor(0xFFFFFFFF)
                                .borderRadius(16)
                                .margin(bottom: 10)

                                Column {
                                    Row {
                                        Text("活动")
                                            .fontSize(11)
                                            .fontColor(0xFFFF8A3D)
                                            .backgroundColor(0xFFFFF1E7)
                                            .padding(left: 8, right: 8, top: 4, bottom: 4)
                                            .borderRadius(10)
                                    }
                                    .margin(bottom: 8)

                                    Row {
                                        Text("电影交换夜")
                                            .fontSize(17)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFFFF8A3D)
                                    }
                                    .width(100.percent)
                                    .height(98)
                                    .justifyContent(FlexAlign.Center)
                                    .alignItems(VerticalAlign.Center)
                                    .backgroundColor(0xFFFFF4EB)
                                    .borderRadius(14)
                                    .margin(bottom: 8)

                                    Text("周六 18:30，一起交换片单")
                                        .fontSize(14)
                                        .fontWeight(FontWeight.Bold)
                                        .fontColor(0xFF24324A)
                                        .margin(bottom: 6)

                                    Text("每个人带一部想推荐的电影来聊，轻社交，很适合第一次认识新朋友。")
                                        .fontSize(12)
                                        .fontColor(0xFF6D7B99)
                                        .lineHeight(18)
                                        .margin(bottom: 10)

                                    Column {
                                        Text("报名截止：05-14 16:00")
                                            .fontSize(11)
                                            .fontColor(0xFF8D6E63)
                                            .margin(bottom: 4)

                                        Text("人数限制：30人")
                                            .fontSize(11)
                                            .fontColor(0xFF8D6E63)
                                            .margin(bottom: 4)

                                        Text("报名中")
                                            .fontSize(11)
                                            .fontColor(0xFFFF8A3D)
                                    }
                                    .alignItems(HorizontalAlign.Start)
                                }
                                .width(100.percent)
                                .padding(left: 8, right: 8, top: 8, bottom: 10)
                                .backgroundColor(0xFFFFFFFF)
                                .borderRadius(16)
                            }
                            .layoutWeight(1)
                            .margin(right: 6)

                            Column {
                                Column {
                                    Row {
                                        Text("最新帖子")
                                            .fontSize(17)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFF2F80FF)
                                    }
                                    .width(100.percent)
                                    .height(162)
                                    .justifyContent(FlexAlign.Center)
                                    .alignItems(VerticalAlign.Center)
                                    .backgroundColor(0xFFD9EAFF)
                                    .borderRadius(14)
                                    .margin(bottom: 8)

                                    Text("刚从社团摊位回来，大家给的新生攻略很实用")
                                        .fontSize(14)
                                        .fontWeight(FontWeight.Bold)
                                        .fontColor(0xFF24324A)
                                        .margin(bottom: 6)

                                    Text("拍了几张摊位照片，之后想整理一份‘新生逛摊路线图’。")
                                        .fontSize(12)
                                        .fontColor(0xFF6D7B99)
                                        .lineHeight(18)
                                        .margin(bottom: 10)

                                    Row {
                                        Row {
                                            Row {
                                                Text("林")
                                                    .fontSize(12)
                                                    .fontColor(0xFFFFFFFF)
                                            }
                                            .width(28)
                                            .height(28)
                                            .backgroundColor(0xFF6CA3FF)
                                            .borderRadius(14)
                                            .justifyContent(FlexAlign.Center)
                                            .alignItems(VerticalAlign.Center)
                                            .margin(right: 8)

                                            Column {
                                                Text("林一")
                                                    .fontSize(12)
                                                    .fontColor(0xFF42526B)
                                                    .margin(bottom: 4)

                                                Text("校园攻略")
                                                    .fontSize(10)
                                                    .fontColor(0xFF2F80FF)
                                                    .backgroundColor(0xFFEAF2FF)
                                                    .padding(left: 7, right: 7, top: 3, bottom: 3)
                                                    .borderRadius(9)
                                            }
                                            .alignItems(HorizontalAlign.Start)
                                        }

                                        Text("❤ 58")
                                            .fontSize(12)
                                            .fontColor(0xFF7E8CA8)
                                    }
                                    .width(100.percent)
                                    .justifyContent(FlexAlign.SpaceBetween)
                                    .alignItems(VerticalAlign.Bottom)
                                }
                                .width(100.percent)
                                .padding(left: 8, right: 8, top: 8, bottom: 10)
                                .backgroundColor(0xFFFFFFFF)
                                .borderRadius(16)
                                .margin(bottom: 10)

                                Column {
                                    Row {
                                        Text("刚发布")
                                            .fontSize(17)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFF2F80FF)
                                    }
                                    .width(100.percent)
                                    .height(118)
                                    .justifyContent(FlexAlign.Center)
                                    .alignItems(VerticalAlign.Center)
                                    .backgroundColor(0xFFEAF2FF)
                                    .borderRadius(14)
                                    .margin(bottom: 8)

                                    Text("今天食堂二层新开的窗口还不错")
                                        .fontSize(14)
                                        .fontWeight(FontWeight.Bold)
                                        .fontColor(0xFF24324A)
                                        .margin(bottom: 6)

                                    Text("点了份招牌套餐，性价比挺高，准备再去试试别的口味。")
                                        .fontSize(12)
                                        .fontColor(0xFF6D7B99)
                                        .lineHeight(18)
                                        .margin(bottom: 10)

                                    Row {
                                        Row {
                                            Row {
                                                Text("饭")
                                                    .fontSize(12)
                                                    .fontColor(0xFFFFFFFF)
                                            }
                                            .width(28)
                                            .height(28)
                                            .backgroundColor(0xFF5A96FF)
                                            .borderRadius(14)
                                            .justifyContent(FlexAlign.Center)
                                            .alignItems(VerticalAlign.Center)
                                            .margin(right: 8)

                                            Column {
                                                Text("饭搭子")
                                                    .fontSize(12)
                                                    .fontColor(0xFF42526B)
                                                    .margin(bottom: 4)

                                                Text("吃喝小组")
                                                    .fontSize(10)
                                                    .fontColor(0xFF2F80FF)
                                                    .backgroundColor(0xFFEAF2FF)
                                                    .padding(left: 7, right: 7, top: 3, bottom: 3)
                                                    .borderRadius(9)
                                            }
                                            .alignItems(HorizontalAlign.Start)
                                        }

                                        Text("❤ 24")
                                            .fontSize(12)
                                            .fontColor(0xFF7E8CA8)
                                    }
                                    .width(100.percent)
                                    .justifyContent(FlexAlign.SpaceBetween)
                                    .alignItems(VerticalAlign.Bottom)
                                }
                                .width(100.percent)
                                .padding(left: 8, right: 8, top: 8, bottom: 10)
                                .backgroundColor(0xFFFFFFFF)
                                .borderRadius(16)
                                .margin(bottom: 10)

                                Column {
                                    Row {
                                        Text("新角度")
                                            .fontSize(17)
                                            .fontWeight(FontWeight.Bold)
                                            .fontColor(0xFF2F80FF)
                                    }
                                    .width(100.percent)
                                    .height(132)
                                    .justifyContent(FlexAlign.Center)
                                    .alignItems(VerticalAlign.Center)
                                    .backgroundColor(0xFFE3EEFF)
                                    .borderRadius(14)
                                    .margin(bottom: 8)

                                    Text("宿舍楼下的玉兰花终于开了")
                                        .fontSize(14)
                                        .fontWeight(FontWeight.Bold)
                                        .fontColor(0xFF24324A)
                                        .margin(bottom: 6)

                                    Text("今天光线很好，顺手拍了一组，准备回头发到摄影圈。")
                                        .fontSize(12)
                                        .fontColor(0xFF6D7B99)
                                        .lineHeight(18)
                                        .margin(bottom: 10)

                                    Row {
                                        Row {
                                            Row {
                                                Text("木")
                                                    .fontSize(12)
                                                    .fontColor(0xFFFFFFFF)
                                            }
                                            .width(28)
                                            .height(28)
                                            .backgroundColor(0xFF7AAFFF)
                                            .borderRadius(14)
                                            .justifyContent(FlexAlign.Center)
                                            .alignItems(VerticalAlign.Center)
                                            .margin(right: 8)

                                            Column {
                                                Text("木子")
                                                    .fontSize(12)
                                                    .fontColor(0xFF42526B)
                                                    .margin(bottom: 4)

                                                Text("摄影圈")
                                                    .fontSize(10)
                                                    .fontColor(0xFF2F80FF)
                                                    .backgroundColor(0xFFEAF2FF)
                                                    .padding(left: 7, right: 7, top: 3, bottom: 3)
                                                    .borderRadius(9)
                                            }
                                            .alignItems(HorizontalAlign.Start)
                                        }

                                        Text("❤ 19")
                                            .fontSize(12)
                                            .fontColor(0xFF7E8CA8)
                                    }
                                    .width(100.percent)
                                    .justifyContent(FlexAlign.SpaceBetween)
                                    .alignItems(VerticalAlign.Bottom)
                                }
                                .width(100.percent)
                                .padding(left: 8, right: 8, top: 8, bottom: 10)
                                .backgroundColor(0xFFFFFFFF)
                                .borderRadius(16)
                            }
                            .layoutWeight(1)
                        }
                        .width(100.percent)
                    }
                }
                .width(100.percent)
                .padding(left: 12, right: 12, top: 8, bottom: 96)
            }
            .layoutWeight(1)

            Row {
                Row {
                    Text("广场")
                        .fontColor(0xFF2F80FF)
                        .fontWeight(FontWeight.Bold)
                        .fontSize(15)
                        .onClick({ _: ClickEvent =>
                        })
                }
                .layoutWeight(1)
                .height(40)
                .justifyContent(FlexAlign.Center)
                .alignItems(VerticalAlign.Center)

                Row {
                    Text("圈子")
                        .fontColor(0xFF5E6C84)
                        .fontSize(15)
                        .onClick({ _: ClickEvent =>
                            this.goToCirclesPage()
                        })
                }
                .layoutWeight(1)
                .height(40)
                .justifyContent(FlexAlign.Center)
                .alignItems(VerticalAlign.Center)

                Button("+")
                    .width(52)
                    .height(52)
                    .backgroundColor(0xFF2F80FF)
                    .fontColor(0xFFFFFFFF)
                    .fontSize(28)
                    .fontWeight(FontWeight.Bold)
                    .borderRadius(26)
                    .margin(left: 6, right: 6)
                    .onClick({ _: ClickEvent =>
                        this.goToCreatePostPage()
                    })

                Row {
                    Text("活动")
                        .fontColor(0xFF5E6C84)
                        .fontSize(15)
                        .onClick({ _: ClickEvent =>
                            this.goToEventsPage()
                        })
                }
                .layoutWeight(1)
                .height(40)
                .justifyContent(FlexAlign.Center)
                .alignItems(VerticalAlign.Center)

                Row {
                    Text("我的")
                        .fontColor(0xFF5E6C84)
                        .fontSize(15)
                        .onClick({ _: ClickEvent =>
                            this.goToProfilePage()
                        })
                }
                .layoutWeight(1)
                .height(40)
                .justifyContent(FlexAlign.Center)
                .alignItems(VerticalAlign.Center)
            }
            .alignItems(VerticalAlign.Center)
            .width(100.percent)
            .padding(left: 10, right: 10, top: 10, bottom: 16)
            .backgroundColor(0xFFFFFFFF)
        }
        .width(100.percent)
        .height(100.percent)
        .backgroundColor(0xFFF4F8FF)
    }
}
