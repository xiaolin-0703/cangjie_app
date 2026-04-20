package ohos_app_cangjie_entry.service

import ohos.net.http.*
import ohos.base.*
import std.collection.HashMap
import ohos_app_cangjie_entry.common.ApiConfig

public class CircleService {
    private static var currentCircleId: String = ""
    private static var currentCircleName: String = ""
    private static var currentCircleDescription: String = ""
    private static var currentCircleMemberText: String = ""
    private static var currentCircleJoinedText: String = "false"

    public static func setCurrentCircleDetail(
        circleId: String,
        name: String,
        description: String,
        memberText: String,
        joinedText: String
    ): Unit {
        CircleService.currentCircleId = circleId
        CircleService.currentCircleName = name
        CircleService.currentCircleDescription = description
        CircleService.currentCircleMemberText = memberText
        CircleService.currentCircleJoinedText = joinedText
    }

    public static func getCurrentCircleId(): String {
        return CircleService.currentCircleId
    }

    public static func getCurrentCircleName(): String {
        return CircleService.currentCircleName
    }

    public static func getCurrentCircleDescription(): String {
        return CircleService.currentCircleDescription
    }

    public static func getCurrentCircleMemberText(): String {
        return CircleService.currentCircleMemberText
    }

    public static func getCurrentCircleJoinedText(): String {
        return CircleService.currentCircleJoinedText
    }

    public static func clearCurrentCircleDetail(): Unit {
        CircleService.currentCircleId = ""
        CircleService.currentCircleName = ""
        CircleService.currentCircleDescription = ""
        CircleService.currentCircleMemberText = ""
        CircleService.currentCircleJoinedText = "false"
    }

    public static func formatMemberText(raw: String): String {
        if (raw == "") {
            return "0人已加入"
        }
        return "${raw}人已加入"
    }

    public static func formatJoinButtonText(joined: String): String {
        if (joined == "true") {
            return "已加入"
        }
        return "加入"
    }

    public static func boolToJsonText(value: Bool): String {
        if (value) {
            return "true"
        }
        return "false"
    }

    public static func getHotCircles(
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

        httpRequest.request("${ApiConfig.BASE_URL}/circles/hot", { err, resp =>
            if (let Some(_) <- err) {
                onError("获取热门圈子失败，请检查网络")
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
                            onError("获取热门圈子失败")
                        } else {
                            onError(msg)
                        }
                }
            } else {
                onError("获取热门圈子失败")
            }

            httpRequest.destroy()
        }, options: option)
    }

    public static func getCircles(
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

        httpRequest.request("${ApiConfig.BASE_URL}/circles", { err, resp =>
            if (let Some(_) <- err) {
                onError("获取圈子列表失败，请检查网络")
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
                            onError("获取圈子列表失败")
                        } else {
                            onError(msg)
                        }
                }
            } else {
                onError("获取圈子列表失败")
            }

            httpRequest.destroy()
        }, options: option)
    }

    public static func createCircle(
        name: String,
        description: String,
        isPublic: Bool,
        onSuccess: (String) -> Unit,
        onError: (String) -> Unit
    ): Unit {
        let token = ApiConfig.getAccessToken()
        if (token == "") {
            onError("请先登录")
            return
        }

        if (name == "") {
            onError("圈子名称不能为空")
            return
        }

        let body =
            "{\"name\":\"${name}\"," +
            "\"description\":\"${description}\"," +
            "\"isPublic\":${CircleService.boolToJsonText(isPublic)}}"

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

        httpRequest.request("${ApiConfig.BASE_URL}/circles", { err, resp =>
            if (let Some(_) <- err) {
                onError("创建圈子失败，请检查网络")
                httpRequest.destroy()
                return
            }

            if (let Some(r) <- resp) {
                let raw = r.result.toString()
                match (r.responseCode) {
                    case ResponseCode.OK =>
                        let newId = CircleService.extractSingleCircleField(raw, "id")
                        let newName = CircleService.extractSingleCircleField(raw, "name")
                        let newDesc = CircleService.extractSingleCircleField(raw, "description")
                        let memberRaw = CircleService.extractSingleCircleField(raw, "memberCount")
                        let joinedRaw = CircleService.extractSingleCircleField(raw, "joined")

                        if (newId != "" || newName != "") {
                            CircleService.setCurrentCircleDetail(
                                newId,
                                newName,
                                newDesc,
                                CircleService.formatMemberText(memberRaw),
                                joinedRaw
                            )
                        }

                        onSuccess(raw)
                    case _ =>
                        let msg = ApiConfig.extractJsonString(raw, "message")
                        if (msg == "") {
                            onError("创建圈子失败")
                        } else {
                            onError(msg)
                        }
                }
            } else {
                onError("创建圈子失败")
            }

            httpRequest.destroy()
        }, options: option)
    }

    public static func getCircleDetail(
        circleId: String,
        onSuccess: (String) -> Unit,
        onError: (String) -> Unit
    ): Unit {
        if (circleId == "") {
            onError("圈子 ID 不能为空")
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

        httpRequest.request("${ApiConfig.BASE_URL}/circles/${circleId}", { err, resp =>
            if (let Some(_) <- err) {
                onError("获取圈子详情失败，请检查网络")
                httpRequest.destroy()
                return
            }

            if (let Some(r) <- resp) {
                let raw = r.result.toString()
                match (r.responseCode) {
                    case ResponseCode.OK =>
                        let name = CircleService.extractSingleCircleField(raw, "name")
                        let description = CircleService.extractSingleCircleField(raw, "description")
                        let memberRaw = CircleService.extractSingleCircleField(raw, "memberCount")
                        let joinedRaw = CircleService.extractSingleCircleField(raw, "joined")

                        CircleService.setCurrentCircleDetail(
                            circleId,
                            name,
                            description,
                            CircleService.formatMemberText(memberRaw),
                            joinedRaw
                        )

                        onSuccess(raw)
                    case _ =>
                        let msg = ApiConfig.extractJsonString(raw, "message")
                        if (msg == "") {
                            onError("获取圈子详情失败")
                        } else {
                            onError(msg)
                        }
                }
            } else {
                onError("获取圈子详情失败")
            }

            httpRequest.destroy()
        }, options: option)
    }

    public static func joinCircle(
        circleId: String,
        onSuccess: (String) -> Unit,
        onError: (String) -> Unit
    ): Unit {
        if (circleId == "") {
            onError("圈子 ID 不能为空")
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

        httpRequest.request("${ApiConfig.BASE_URL}/circles/${circleId}/join", { err, resp =>
            if (let Some(_) <- err) {
                onError("加入圈子失败，请检查网络")
                httpRequest.destroy()
                return
            }

            if (let Some(r) <- resp) {
                let raw = r.result.toString()
                match (r.responseCode) {
                    case ResponseCode.OK =>
                        let name = CircleService.extractSingleCircleField(raw, "name")
                        let description = CircleService.extractSingleCircleField(raw, "description")
                        let memberRaw = CircleService.extractSingleCircleField(raw, "memberCount")
                        let joinedRaw = CircleService.extractSingleCircleField(raw, "joined")

                        if (name != "" || description != "") {
                            CircleService.setCurrentCircleDetail(
                                circleId,
                                name,
                                description,
                                CircleService.formatMemberText(memberRaw),
                                joinedRaw
                            )
                        }

                        onSuccess(raw)
                    case _ =>
                        let msg = ApiConfig.extractJsonString(raw, "message")
                        if (msg == "") {
                            onError("加入圈子失败")
                        } else {
                            onError(msg)
                        }
                }
            } else {
                onError("加入圈子失败")
            }

            httpRequest.destroy()
        }, options: option)
    }

    public static func getCirclePosts(
        circleId: String,
        onSuccess: (String) -> Unit,
        onError: (String) -> Unit
    ): Unit {
        if (circleId == "") {
            onError("圈子 ID 不能为空")
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

        httpRequest.request("${ApiConfig.BASE_URL}/circles/${circleId}/posts", { err, resp =>
            if (let Some(_) <- err) {
                onError("获取帖子失败，请检查网络")
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
                            onError("获取帖子失败")
                        } else {
                            onError(msg)
                        }
                }
            } else {
                onError("获取帖子失败")
            }

            httpRequest.destroy()
        }, options: option)
    }

    public static func createPost(
        circleId: String,
        title: String,
        content: String,
        onSuccess: (String) -> Unit,
        onError: (String) -> Unit
    ): Unit {
        if (circleId == "") {
            onError("圈子 ID 不能为空")
            return
        }

        if (title == "") {
            onError("帖子标题不能为空")
            return
        }

        if (content == "") {
            onError("帖子内容不能为空")
            return
        }

        let token = ApiConfig.getAccessToken()
        if (token == "") {
            onError("请先登录")
            return
        }

        let body =
            "{\"title\":\"${title}\"," +
            "\"content\":\"${content}\"}"

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

        httpRequest.request("${ApiConfig.BASE_URL}/circles/${circleId}/posts", { err, resp =>
            if (let Some(_) <- err) {
                onError("发布帖子失败，请检查网络")
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
                            onError("发布帖子失败")
                        } else {
                            onError(msg)
                        }
                }
            } else {
                onError("发布帖子失败")
            }

            httpRequest.destroy()
        }, options: option)
    }

    public static func extractCircleField(raw: String, index: Int64, key: String): String {
        let listMarker = "\"circles\":["
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

    public static func extractSingleCircleField(raw: String, key: String): String {
        let circleWrapperMarker = "\"circle\":{"
        let postsMarker = "\"posts\":["
        let wrappedRaw =
            if (raw.contains(circleWrapperMarker)) {
                raw.split(circleWrapperMarker)[1]
            } else {
                raw
            }

        let objectRaw =
            if (wrappedRaw.contains(postsMarker)) {
                wrappedRaw.split(postsMarker)[0]
            } else {
                wrappedRaw
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

            let braceParts = rawValue.split("}")
            if (braceParts.size > 0) {
                return braceParts[0]
            }

            return rawValue
        }

        return ""
    }

    public static func extractPostField(raw: String, index: Int64, key: String): String {
        let listMarker = "\"posts\":["
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
}