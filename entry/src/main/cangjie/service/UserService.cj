package ohos_app_cangjie_entry.service

import ohos.net.http.*
import ohos.base.*
import std.collection.HashMap
import ohos_app_cangjie_entry.common.ApiConfig

public class UserService {
    static func handleErrorMessage(raw: String, fallback: String): String {
        let msg = ApiConfig.extractJsonString(raw, "message")
        if (msg == "") {
            return fallback
        }
        return msg
    }

    static func handleProfileOk(raw: String, onSuccess: (String) -> Unit): Unit {
        let nextPage = ApiConfig.extractJsonString(raw, "nextPage")
        if (nextPage == "") {
            onSuccess("home")
        } else {
            onSuccess(nextPage)
        }
    }

    public static func updateProfile(
        nickname: String,
        grade: String,
        department: String,
        avatarUrl: String,
        identityMode: String,
        onSuccess: (String) -> Unit,
        onError: (String) -> Unit
    ): Unit {
        let accessToken = ApiConfig.getAccessToken()
        if (accessToken == "") {
            onError("登录状态已失效，请重新登录")
            return
        }

        let httpRequest = createHttp()
        let body = "{\"nickname\":\"${nickname}\",\"grade\":\"${grade}\",\"department\":\"${department}\",\"avatarUrl\":\"${avatarUrl}\",\"identityMode\":\"${identityMode}\"}"

        let option = HttpRequestOptions(
            method: RequestMethod.PUT,
            extraData: HttpData.STRING_DATA(body),
            expectDataType: HttpDataType.STRING,
            header: HashMap<String, String>([
                ("content-type", "application/json"),
                ("authorization", "Bearer ${accessToken}")
            ])
        )

        httpRequest.request("${ApiConfig.BASE_URL}/users/me", { err, resp =>
            if (let Some(_) <- err) {
                onError("网络请求失败，请检查后端地址和网络")
                httpRequest.destroy()
                return
            }

            if (let Some(r) <- resp) {
                let raw = r.result.toString()
                match (r.responseCode) {
                    case ResponseCode.OK => handleProfileOk(raw, onSuccess)
                    case _ => onError(handleErrorMessage(raw, "资料保存失败，请重试"))
                }
            } else {
                onError("资料保存失败，请稍后重试")
            }

            httpRequest.destroy()
        }, options: option)
    }
}
