package ohos_app_cangjie_entry.service

import ohos.net.http.*
import ohos.base.*
import std.collection.HashMap
import ohos_app_cangjie_entry.common.ApiConfig

public class UserService {
    public static func getMyProfile(
        onSuccess: (String) -> Unit,
        onError: (String) -> Unit
    ): Unit {
        let token = ApiConfig.getAccessToken()
        if (token == "") {
            onError("请先登录")
            return
        }

        let httpRequest = createHttp()
        let option = HttpRequestOptions(
            method: RequestMethod.GET,
            expectDataType: HttpDataType.STRING,
            header: HashMap<String, String>([
                ("Authorization", "Bearer ${token}")
            ])
        )

        httpRequest.request("${ApiConfig.BASE_URL}/users/me", { err, resp =>
            if (let Some(_) <- err) {
                onError("获取个人资料失败，请检查网络")
                httpRequest.destroy()
                return
            }

            if (let Some(r) <- resp) {
                let raw = r.result.toString()
                match (r.responseCode) {
                    case ResponseCode.OK =>
                        onSuccess(raw)
                    case _ =>
                        let msg = ApiConfig.extractJsonString(raw, "message")
                        if (msg == "") {
                            onError("获取个人资料失败")
                        } else {
                            onError(msg)
                        }
                }
            } else {
                onError("获取个人资料失败")
            }

            httpRequest.destroy()
        }, options: option)
    }

   public static func updateMyProfile(
    nickname: String,
    grade: String,
    department: String,
    bio: String,
    onSuccess: (String) -> Unit,
    onError: (String) -> Unit
): Unit {
    let token = ApiConfig.getAccessToken()
    if (token == "") {
        onError("请先登录")
        return
    }

    if (nickname == "") {
        onError("昵称不能为空")
        return
    }

    let body =
        "{\"nickname\":\"${nickname}\"," +
        "\"grade\":\"${grade}\"," +
        "\"department\":\"${department}\"," +
        "\"bio\":\"${bio}\"}"

    let httpRequest = createHttp()
    let option = HttpRequestOptions(
        method: RequestMethod.PUT,
        extraData: HttpData.STRING_DATA(body),
        expectDataType: HttpDataType.STRING,
        header: HashMap<String, String>([
            ("content-type", "application/json"),
            ("Authorization", "Bearer ${token}")
        ])
    )

    httpRequest.request("${ApiConfig.BASE_URL}/users/me", { err, resp =>
        if (let Some(_) <- err) {
            onError("修改资料失败，请检查网络")
            httpRequest.destroy()
            return
        }

        if (let Some(r) <- resp) {
            let raw = r.result.toString()
            match (r.responseCode) {
                case ResponseCode.OK =>
                    onSuccess(raw)
                case _ =>
                    let msg = ApiConfig.extractJsonString(raw, "message")
                    if (msg == "") {
                        onError("修改资料失败")
                    } else {
                        onError(msg)
                    }
            }
        } else {
            onError("修改资料失败")
        }

        httpRequest.destroy()
    }, options: option)
}

   public static func updateMyProfileWithAvatar(
    nickname: String,
    grade: String,
    department: String,
    avatarUrl: String,
    bio: String,
    onSuccess: (String) -> Unit,
    onError: (String) -> Unit
): Unit {
    let token = ApiConfig.getAccessToken()
    if (token == "") {
        onError("请先登录")
        return
    }

    if (nickname == "") {
        onError("昵称不能为空")
        return
    }

    let safeAvatarUrl = ApiConfig.normalizeImageUrl(avatarUrl)
    let body =
        "{\"nickname\":\"${nickname}\"," +
        "\"grade\":\"${grade}\"," +
        "\"department\":\"${department}\"," +
        "\"avatarUrl\":\"${safeAvatarUrl}\"," +
        "\"bio\":\"${bio}\"}"

    let httpRequest = createHttp()
    let option = HttpRequestOptions(
        method: RequestMethod.PUT,
        extraData: HttpData.STRING_DATA(body),
        expectDataType: HttpDataType.STRING,
        header: HashMap<String, String>([
            ("content-type", "application/json"),
            ("Authorization", "Bearer ${token}")
        ])
    )

    httpRequest.request("${ApiConfig.BASE_URL}/users/me", { err, resp =>
        if (let Some(_) <- err) {
            onError("修改资料失败，请检查网络")
            httpRequest.destroy()
            return
        }

        if (let Some(r) <- resp) {
            let raw = r.result.toString()
            match (r.responseCode) {
                case ResponseCode.OK =>
                    onSuccess(raw)
                case _ =>
                    let msg = ApiConfig.extractJsonString(raw, "message")
                    if (msg == "") {
                        onError("修改资料失败")
                    } else {
                        onError(msg)
                    }
            }
        } else {
            onError("修改资料失败")
        }

        httpRequest.destroy()
    }, options: option)
}

    public static func getMyJoinedEvents(
        onSuccess: (String) -> Unit,
        onError: (String) -> Unit
    ): Unit {
        let token = ApiConfig.getAccessToken()
        if (token == "") {
            onError("请先登录")
            return
        }

        let httpRequest = createHttp()
        let option = HttpRequestOptions(
            method: RequestMethod.GET,
            expectDataType: HttpDataType.STRING,
            header: HashMap<String, String>([
                ("Authorization", "Bearer ${token}")
            ])
        )

        httpRequest.request("${ApiConfig.BASE_URL}/events/mine", { err, resp =>
            if (let Some(_) <- err) {
                onError("获取我的活动失败，请检查网络")
                httpRequest.destroy()
                return
            }

            if (let Some(r) <- resp) {
                let raw = r.result.toString()
                match (r.responseCode) {
                    case ResponseCode.OK =>
                        onSuccess(raw)
                    case _ =>
                        let msg = ApiConfig.extractJsonString(raw, "message")
                        if (msg == "") {
                            onError("获取我的活动失败")
                        } else {
                            onError(msg)
                        }
                }
            } else {
                onError("获取我的活动失败")
            }

            httpRequest.destroy()
        }, options: option)
    }

    public static func extractProfileField(raw: String, key: String): String {
        let stringMarker = "\"${key}\":\""
        if (raw.contains(stringMarker)) {
            let valueParts = raw.split(stringMarker)
            if (valueParts.size < 2) {
                return ""
            }

            let tailValue = valueParts[1]
            let finalParts = tailValue.split("\"")
            if (finalParts.size < 1) {
                return ""
            }

            let value = finalParts[0]
            if (key == "avatarUrl") {
                return ApiConfig.normalizeImageUrl(value)
            }
            return value
        }

        let numberMarker = "\"${key}\":"
        if (raw.contains(numberMarker)) {
            let valueParts = raw.split(numberMarker)
            if (valueParts.size < 2) {
                return ""
            }

            let tailValue = valueParts[1]
            let commaParts = tailValue.split(",")
            if (commaParts.size < 1) {
                return ""
            }

            let rawValue = commaParts[0]
            if (rawValue == "null") {
                return ""
            }

            return rawValue
        }

        return ""
    }

    public static func extractEventField(raw: String, index: Int64, key: String): String {
        let listMarker = "\"events\":["
        if (!raw.contains(listMarker)) {
            return ""
        }

        let listParts = raw.split(listMarker)
        if (listParts.size < 2) {
            return ""
        }

        let tail = listParts[1]
        let objectParts = tail.split("\"id\":")
        if (objectParts.size < index + 2) {
            return ""
        }

        let objectRaw = objectParts[index + 1]

        if (key == "id") {
            let commaParts = objectRaw.split(",")
            if (commaParts.size < 1) {
                return ""
            }
            return commaParts[0]
        }

        let stringMarker = "\"${key}\":\""
        if (objectRaw.contains(stringMarker)) {
            let valueParts = objectRaw.split(stringMarker)
            if (valueParts.size < 2) {
                return ""
            }

            let tailValue = valueParts[1]
            let finalParts = tailValue.split("\"")
            if (finalParts.size < 1) {
                return ""
            }

            return finalParts[0]
        }

        let numberMarker = "\"${key}\":"
        if (objectRaw.contains(numberMarker)) {
            let valueParts = objectRaw.split(numberMarker)
            if (valueParts.size < 2) {
                return ""
            }

            let tailValue = valueParts[1]
            let commaParts = tailValue.split(",")
            if (commaParts.size < 1) {
                return ""
            }

            let rawValue = commaParts[0]
            if (rawValue == "null") {
                return ""
            }

            return rawValue
        }

        return ""
    }
    public static func updateProfile(
    nickname: String,
    grade: String,
    department: String,
    avatarUrl: String,
    mode: String,
    onSuccess: (String) -> Unit,
    onError: (String) -> Unit
): Unit {
    let token = ApiConfig.getAccessToken()
    if (token == "") {
        onError("请先登录")
        return
    }

    if (nickname == "") {
        onError("昵称不能为空")
        return
    }

    let safeAvatarUrl = ApiConfig.normalizeImageUrl(avatarUrl)
    let body =
        "{\"nickname\":\"${nickname}\"," +
        "\"grade\":\"${grade}\"," +
        "\"department\":\"${department}\"," +
        "\"avatarUrl\":\"${safeAvatarUrl}\"," +
        "\"identityMode\":\"${mode}\"}"

    let httpRequest = createHttp()
    let option = HttpRequestOptions(
        method: RequestMethod.POST,
        extraData: HttpData.STRING_DATA(body),
        expectDataType: HttpDataType.STRING,
        header: HashMap<String, String>([
            ("content-type", "application/json"),
            ("Authorization", "Bearer ${token}")
        ])
    )

    httpRequest.request("${ApiConfig.BASE_URL}/users/me/update", { err, resp =>
        if (let Some(_) <- err) {
            onError("修改资料失败，请检查网络")
            httpRequest.destroy()
            return
        }

        if (let Some(r) <- resp) {
            let raw = r.result.toString()
            match (r.responseCode) {
                case ResponseCode.OK =>
                    if (mode == "edit") {
                        onSuccess("ProfilePage")
                    } else {
                        onSuccess("HomePage")
                    }
                case _ =>
                    let msg = ApiConfig.extractJsonString(raw, "message")
                    if (msg == "") {
                        onError("修改资料失败")
                    } else {
                        onError(msg)
                    }
            }
        } else {
            onError("修改资料失败")
        }

        httpRequest.destroy()
    }, options: option)
}
}
