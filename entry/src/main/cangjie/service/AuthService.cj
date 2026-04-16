package ohos_app_cangjie_entry.service

import ohos.net.http.*
import ohos.base.*
import std.collection.HashMap
import ohos_app_cangjie_entry.common.ApiConfig

public class AuthService {

    static func handleErrorMessage(raw: String, fallback: String): String {
        let msg = ApiConfig.extractJsonString(raw, "message")
        if (msg == "") {
            return fallback
        }
        return msg
    }

    static func handleVerifyOk(raw: String, onSuccess: (String) -> Unit, onError: (String) -> Unit): Unit {
    try {
        let loginToken = ApiConfig.extractJsonString(raw, "token")
        let nextPage = ApiConfig.extractJsonString(raw, "nextPage")

        if (loginToken == "") {
            onError("登录成功，但未获取到登录凭证")
            return
        }

        //ApiConfig.setAccessToken(loginToken)
        if (nextPage == "") {
            onSuccess("profile")
        } else {
            onSuccess(nextPage)
        }
    } catch (e: Exception) {
        // 关键兜底：一旦上面解析或存储崩溃，走这里！
        println("⚠ 客户端数据解析或存储异常: ${e.toString()}")
        onError("客户端数据处理失败，请稍后再试")
    }
}

    public static func sendCode(
    email: String,
    onSuccess: (String) -> Unit,
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

    httpRequest.request("${ApiConfig.BASE_URL}/auth/send-code", { err, resp =>
        if (let Some(_) <- err) {
            onError("网络请求失败，请检查后端地址和网络")
            httpRequest.destroy()
            return
        }

        if (let Some(r) <- resp) {
            let raw = r.result.toString()
            match (r.responseCode) {
                case ResponseCode.OK =>
                    let serverEmail = ApiConfig.extractJsonString(raw, "email")
                    if (serverEmail == "") {
                        onSuccess(email)
                    } else {
                        onSuccess(serverEmail)
                    }
                case _ => onError(handleErrorMessage(raw, "发送失败，请重试"))
            }
        } else {
            onError("发送失败，请稍后重试")
        }

        httpRequest.destroy()
    }, options: option)
}

    public static func verify(
        email: String,
        code: String,
        onSuccess: (String) -> Unit,
        onError: (String) -> Unit
    ): Unit {
        let normalizedEmail = email
        let normalizedCode = code
        let httpRequest = createHttp()
        let body = "{\"email\":\"${normalizedEmail}\",\"code\":\"${normalizedCode}\"}"

        let option = HttpRequestOptions(
            method: RequestMethod.POST,
            extraData: HttpData.STRING_DATA(body),
            expectDataType: HttpDataType.STRING,
            header: HashMap<String, String>([("content-type", "application/json")])
        )

        httpRequest.request("${ApiConfig.BASE_URL}/auth/verify", { err, resp =>
            if (let Some(_) <- err) {
                onError("网络请求失败，请检查后端地址和网络")
                httpRequest.destroy()
                return
            }

            if (let Some(r) <- resp) {
                let raw = r.result.toString()
                match (r.responseCode) {
                    case ResponseCode.OK => handleVerifyOk(raw, onSuccess, onError)
                    case _ => onError(handleErrorMessage(raw, "验证码错误或已过期"))
                }
            } else {
                onError("登录失败，请稍后重试")
            }

            httpRequest.destroy()
        }, options: option)
    }
}