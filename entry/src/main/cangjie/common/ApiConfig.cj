package ohos_app_cangjie_entry.common

public class ApiConfig {
    public static let BASE_URL: String = "http://101.42.9.121:3000"
    static var accessToken: String = ""

    public static func setAccessToken(token: String): Unit {
        ApiConfig.accessToken = token
    }

    public static func getAccessToken(): String {
        return ApiConfig.accessToken
    }

    public static func clearAccessToken(): Unit {
        ApiConfig.accessToken = ""
    }

    public static func normalizeImageUrl(rawUrl: String): String {
        var url = rawUrl.replace("\r", "").replace("\n", "")
        while (url.startsWith(" ")) {
            let parts = url.split(" ", 2)
            if (parts.size < 2) {
                return ""
            }
            url = parts[1]
        }

        if (url == "") {
            return ""
        }

        if (url.startsWith("//")) {
            return "http:" + url
        }

        if (url.startsWith("/")) {
            return ApiConfig.BASE_URL + url
        }

        if (url.startsWith("uploads/")) {
            return ApiConfig.BASE_URL + "/" + url
        }

        if (url.contains("/uploads/images/")) {
            let parts = url.split("/uploads/images/", 2)
            if (parts.size >= 2) {
                return ApiConfig.BASE_URL + "/uploads/images/" + parts[1]
            }
        }

        return url
    }

    public static func extractJsonString(raw: String, key: String): String {
        let marker = "\"${key}\":\""
        if (!raw.contains(marker)) {
            return ""
        }

        let parts = raw.split(marker)
        if (parts.size < 2) {
            return ""
        }

        let tail = parts[1]
        let valueParts = tail.split("\"")
        if (valueParts.size < 1) {
            return ""
        }

        return valueParts[0]
    }
}
