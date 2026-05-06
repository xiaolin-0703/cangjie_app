
package ohos_app_cangjie_entry

internal import ohos.base.LengthProp
import ohos.base.*
import ohos.component.*
import ohos.state_manage.*
import ohos.state_macro_manage.*
import ohos.router.*
import ohos_app_cangjie_entry.pages.LoginPage

@Entry
@Component
class EntryView {
    @State var isShowLoginSheet: Bool = false

    // 1. 定义弹窗内容构造器
    @Builder
    func loginSheetBuilder() {
        // 这里的 LoginPage 就是你的登录表单界面
        LoginPage(isShow: this.isShowLoginSheet)
    }

    func build() {
        Column {
            // --- 1. 顶部按钮区 ---
            Row {
                Blank()
                Text("帮助")
                    .fontSize(14)
                    .fontColor(0xFFFFFFFF)
            }
            .width(100.percent)
            .padding(top: 20, right: 20)

            // --- 3. 原有的 Logo 图片区 ---
            Image(@r(app.media.fly))
                .width(200)
                .height(100)
                .objectFit(ImageFit.Contain)
                .margin(top: 40, bottom: 0) // 给上面的欢迎语留出空间
                .borderRadius(16)

            Image(@r(app.media.name))
                .width(300)
                .height(100)
                .objectFit(ImageFit.Contain)
                .margin(top: 0, bottom: 16)
                .borderRadius(16)

            Text("专属BUAA的生活兴趣社区")
                .fontSize(16)
                .fontColor(0xFFFFFFFF)

            // 使用 Blank 撑开剩余空间，把下面的登录按钮牢牢压在屏幕底部
            Blank()

            // --- 4. 底部按钮和协议 ---
            Button("点击登录")
                .width(85.percent)
                .height(48)
                .fontColor(0xFFFFFFFF)
                .backgroundColor(0xFF4169E1)
                .borderRadius(24)
                .margin(bottom: 24)
                .onClick({ =>
                    // 点击唤起半屏弹窗
                    this.isShowLoginSheet = true
                })

            Row {
                Checkbox(name: "agreement")
                    .width(14)
                    .height(14)
                    .selectedColor(0xFF4169E1)
                Text("我已阅读并同意《用户协议》《隐私政策》")
                    .fontSize(12)
                    .fontColor(0xFFFFFFFF)
                    .margin(left: 6)
            }
            .margin(bottom: 60)
        }
        .width(100.percent)
        .height(100.percent)
        .backgroundImage(src: @r(app.media.bg_image), repeat: ImageRepeat.NoRepeat)
        .backgroundImageSize(ImageSize.Cover)

        // ==========================================
        // 【核心修复】完美的半屏弹窗控制
        // ==========================================
        .bindSheet(
            this.isShowLoginSheet,
            this.loginSheetBuilder,
            // 使用 SheetOptions，并传入符合仓颉编译器要求的枚举类型
            options: SheetOptions(
                height: SheetSize.MEDIUM,  // MEDIUM 在鸿蒙中代表正好占据半个屏幕的高度
                backgroundColor: Color.WHITE, // 给弹窗加上纯白底色，避免背景透过来
                onDisappear: { =>
                    this.isShowLoginSheet = false
                }
            )
        )
    }
}