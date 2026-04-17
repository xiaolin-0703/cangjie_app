package ohos_app_cangjie_entry.service

import ohos.net.http.*
import ohos.base.*
import std.collection.HashMap
import ohos_app_cangjie_entry.common.ApiConfig

public class EventService {
    static func handleErrorMessage(raw: String, fallback: String): String {
        let msg = ApiConfig.extractJsonString(raw, "message")
        if (msg == "") {
            return fallback
        }
        return msg
    }

    static func normalizeEventType(eventType: String): String {
        if (eventType == "online") {
            return "online"
        }
        return "offline"
    }

    public static func createEvent(
        title: String,
        eventType: String,
        startTime: String,
        location: String,
        capacity: String,
        signupDeadline: String,
        description: String,
        onSuccess: (String) -> Unit,
        onError: (String) -> Unit
    ): Unit {
        if (title == "") {
            onError("活动标题不能为空")
            return
        }

        if (startTime == "") {
            onError("活动开始时间不能为空")
            return
        }

        if (location == "") {
            onError("活动地点不能为空")
            return
        }

        if (capacity == "") {
            onError("人数上限不能为空")
            return
        }

        let token = ApiConfig.getAccessToken()
        if (token == "") {
            onError("请先登录")
            return
        }

        let safeEventType = normalizeEventType(eventType)

        let body =
            "{\"title\":\"${title}\"," +
            "\"type\":\"${safeEventType}\"," +
            "\"startTime\":\"${startTime}\"," +
            "\"location\":\"${location}\"," +
            "\"capacity\":${capacity}," +
            "\"signupDeadline\":\"${signupDeadline}\"," +
            "\"description\":\"${description}\"}"

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

        httpRequest.request("${ApiConfig.BASE_URL}/events", { err, resp =>
            if (let Some(_) <- err) {
                onError("网络请求失败，请检查后端地址和网络")
                httpRequest.destroy()
                return
            }

            if (let Some(r) <- resp) {
                let raw = r.result.toString()
                match (r.responseCode) {
                    case ResponseCode.OK =>
                        onSuccess(raw)
                    case _ =>
                        onError(handleErrorMessage(raw, "活动创建失败"))
                }
            } else {
                onError("活动创建失败，请稍后重试")
            }

            httpRequest.destroy()
        }, options: option)
    }

    public static func getFeaturedEvents(
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

        httpRequest.request("${ApiConfig.BASE_URL}/events/featured", { err, resp =>
            if (let Some(_) <- err) {
                onError("网络请求失败，请检查后端地址和网络")
                httpRequest.destroy()
                return
            }

            if (let Some(r) <- resp) {
                let raw = r.result.toString()
                match (r.responseCode) {
                    case ResponseCode.OK =>
                        onSuccess(raw)
                    case _ =>
                        onError(handleErrorMessage(raw, "获取活动失败"))
                }
            } else {
                onError("获取活动失败，请稍后重试")
            }

            httpRequest.destroy()
        }, options: option)
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

        return commaParts[0]
    }

    return ""
}
}