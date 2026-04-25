package ohos_app_cangjie_entry.service

public class ImageUploadService {
    public static func pickAndUploadImage(
        onLocalSelected: (String) -> Unit,
        onSuccess: (String) -> Unit,
        onError: (String) -> Unit
    ): Unit {
        onError("系统相册暂未接入，请使用页面里的图片链接输入框")
    }
}
