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
    public static func extractRegistrationField(raw: String, index: Int64, key: String): String {
    let listMarker = "\"registrations\":["
    if (!raw.contains(listMarker)) {
        return ""
    }

    let listParts = raw.split(listMarker)
    if (listParts.size < 2) {
        return ""
    }

    let tail = listParts[1]
    let objectParts = tail.split("\"userId\":")
    if (objectParts.size < index + 2) {
        return ""
    }

    let objectRaw = objectParts[index + 1]

    if (key == "userId") {
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

public static func getEventRegistrations(
    eventId: String,
    onSuccess: (String) -> Unit,
    onError: (String) -> Unit
): Unit {
    if (eventId == "") {
        onError("活动 ID 不能为空")
        return
    }

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

    httpRequest.request("${ApiConfig.BASE_URL}/events/${eventId}/registrations", { err, resp =>
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
                    let msg = ApiConfig.extractJsonString(raw, "message")
                    if (msg == "") {
                        onError("获取报名名单失败")
                    } else {
                        onError(msg)
                    }
            }
        } else {
            onError("获取报名名单失败，请稍后重试")
        }

        httpRequest.destroy()
    }, options: option)
}

public static func getCreatedByMeEvents(
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

    httpRequest.request("${ApiConfig.BASE_URL}/events/created-by-me", { err, resp =>
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
                    let msg = ApiConfig.extractJsonString(raw, "message")
                    if (msg == "") {
                        onError("获取我创建的活动失败")
                    } else {
                        onError(msg)
                    }
            }
        } else {
            onError("获取我创建的活动失败，请稍后重试")
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

    // 先按对象切开，每个对象都是从 id 后面开始的
    let objectParts = tail.split("\"id\":")
    if (objectParts.size < index + 2) {
        return ""
    }

    let objectRaw = objectParts[index + 1]

    // 特别处理 id：因为 objectRaw 本身就是从 id 后面开始
    if (key == "id") {
        let commaParts = objectRaw.split(",")
        if (commaParts.size < 1) {
            return ""
        }
        return commaParts[0]
    }

    // 处理字符串字段："key":"value"
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

    // 处理数字或 null："key":10 / "key":null
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

   public static func registerEvent(
    eventId: String,
    onSuccess: (String) -> Unit,
    onError: (String) -> Unit
): Unit {
    if (eventId == "") {
        onError("活动 ID 不能为空")
        return
    }

    let token = ApiConfig.getAccessToken()
    if (token == "") {
        onError("请先登录")
        return
    }

    let httpRequest = createHttp()
    let option = HttpRequestOptions(
        method: RequestMethod.POST,
        expectDataType: HttpDataType.STRING,
        header: HashMap<String, String>([
            ("Authorization", "Bearer ${token}")
        ])
    )

    httpRequest.request("${ApiConfig.BASE_URL}/events/${eventId}/register", { err, resp =>
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
                    let msg = ApiConfig.extractJsonString(raw, "message")
                    if (msg == "") {
                        onError("报名失败")
                    } else {
                        onError(msg)
                    }
            }
        } else {
            onError("报名失败，请稍后重试")
        }

        httpRequest.destroy()
    }, options: option)
}

static var currentEventId: String = ""
static var currentEventTitle: String = ""
static var currentEventTimeText: String = ""
static var currentEventLocation: String = ""
static var currentEventStatusText: String = ""
static var currentEventDescription: String = ""
static var currentEventCapacityText: String = ""
static var currentEventDeadlineText: String = ""

public static func setCurrentEventDetail(
    eventId: String,
    title: String,
    timeText: String,
    location: String,
    statusText: String,
    description: String,
    capacityText: String,
    deadlineText: String
): Unit {
    currentEventId = eventId
    currentEventTitle = title
    currentEventTimeText = timeText
    currentEventLocation = location
    currentEventStatusText = statusText
    currentEventDescription = description
    currentEventCapacityText = capacityText
    currentEventDeadlineText = deadlineText
}
public static func getCurrentEventId(): String {
    return currentEventId
}

public static func getCurrentEventTitle(): String {
    return currentEventTitle
}

public static func getCurrentEventTimeText(): String {
    return currentEventTimeText
}

public static func getCurrentEventLocation(): String {
    return currentEventLocation
}

public static func getCurrentEventStatusText(): String {
    return currentEventStatusText
}

public static func getCurrentEventDescription(): String {
    return currentEventDescription
}

public static func getCurrentEventCapacityText(): String {
    return currentEventCapacityText
}

public static func getCurrentEventDeadlineText(): String {
    return currentEventDeadlineText
}
}