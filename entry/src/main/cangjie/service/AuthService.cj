package ohos_app_cangjie_entry.service

import ohos.net.http.*
import ohos.base.*
import std.collection.HashMap

let BASE_URL = "http://10.192.188.52:3000"

public class AuthService {

    // 发送验证码
    public static func sendCode(
        email: String,
        onSuccess: () -> Unit,
        onError: (String) -> Unit
    ): Unit {
        let httpRequest = createHttp()
        let body = "{\"email\":\"${email}\"}"

        let option = HttpRequestOptions(
            method: RequestMethod.POST,
            extraData: HttpData.STRING_DATA(body),
            expectDataType: HttpDataType.STRING,
            header: HashMap<String, String>([("content-type", "application/json")])
        )

        httpRequest.request("${BASE_URL}/auth/send-code", { err, resp =>
            if (let Some(_) <- err) {
                onError("网络请求失败，请检查网络")
            }
           if (let Some(r) <- resp) {
                // 使用 match 替代 if (r.responseCode == ...)
                match (r.responseCode) {
                    case ResponseCode.OK => onSuccess()
                    case _ => onError("发送失败，请重试") // _ 代表 default 分支
                }
            }
            httpRequest.destroy()
        }, options: option)
    }

    // 验证验证码
    public static func verify(
        email: String,
        code: String,
        onSuccess: (String) -> Unit,
        onError: (String) -> Unit
    ): Unit {
        let httpRequest = createHttp()
        let body = "{\"email\":\"${email}\",\"code\":\"${code}\"}"

        let option = HttpRequestOptions(
            method: RequestMethod.POST,
            extraData: HttpData.STRING_DATA(body),
            expectDataType: HttpDataType.STRING,
            header: HashMap<String, String>([("content-type", "application/json")])
        )

      httpRequest.request("${BASE_URL}/auth/verify", { err, resp =>
            if (let Some(_) <- err) {
                onError("网络请求失败，请检查网络")
            }
            if (let Some(r) <- resp) {
                // 使用 match 处理枚举
                match (r.responseCode) {
                    case ResponseCode.OK => onSuccess(r.result.toString())
                    case _ => onError("验证码错误或已过期")
                }
            }
            httpRequest.destroy()
        }, options: option) // <-- 同样保留 options: 标签
    }
}