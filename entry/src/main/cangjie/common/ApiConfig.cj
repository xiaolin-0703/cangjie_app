package ohos_app_cangjie_entry.common

public class ApiConfig {
    public static let BASE_URL: String = "http://10.192.188.52:3000"
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