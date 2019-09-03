import Foundation
import WebKit

#if os(iOS)
    import UIKit
#endif

final class URLSessionDispatcher: Dispatcher {
    
    let serializer = EventSerializer()
    let timeout: TimeInterval
    let session: URLSession
    let baseURL: URL

    private(set) var userAgent: String?
    
    /// Generate a URLSessionDispatcher instance
    ///
    /// - Parameters:
    ///   - baseURL: The url of the Matomo server. This url has to end in `piwik.php`.
    ///   - userAgent: An optional parameter for custom user agent.
    init(baseURL: URL, userAgent: String? = nil) {                
        self.baseURL = baseURL
        self.timeout = 5
        self.session = URLSession.shared
        self.userAgent = userAgent
        
        if (userAgent == nil) {
            URLSessionDispatcher.getDefaultUserAgent(completion: {(defaultUserAgent: String) in
                self.userAgent = defaultUserAgent.appending(" MatomoTracker SDK URLSessionDispatcher")
            })
        }
    }
    
    private static func getDefaultUserAgent(completion: @escaping (_ defaultUserAgent: String) -> Void) -> Void {
        DispatchQueue.main.async {
            #if os(OSX)
                let webView = WebView(frame: .zero)
                let currentUserAgent = webView.stringByEvaluatingJavaScript(from: "navigator.userAgent") ?? ""
                completion(currentUserAgent)
            #elseif os(iOS)
                let wkWebView = WKWebView(frame: .zero)
                wkWebView.evaluateJavaScript("navigator.userAgent", completionHandler: { (response: Any?, error: Error?) in
                    if let currentUserAgent = response as? String {
                        if let regex = try? NSRegularExpression(pattern: "\\((iPad|iPhone);", options: .caseInsensitive) {
                            let deviceModel = Device.makeCurrentDevice().platform
                            completion(regex.stringByReplacingMatches(
                                in: currentUserAgent,
                                options: .withTransparentBounds,
                                range: NSRange(location: 0, length: currentUserAgent.count),
                                withTemplate: "(\(deviceModel);"
                            ))
                        }

                    } else {
                        completion("")
                    }
                })
            #elseif os(tvOS)
                completion("")
            #endif
        }
    }
    
    func send(events: [Event], success: @escaping ()->(), failure: @escaping (_ error: Error)->()) {
        let jsonBody: Data
        do {
            jsonBody = try serializer.jsonData(for: events)
        } catch  {
            failure(error)
            return
        }
        let request = buildRequest(baseURL: baseURL, method: "POST", contentType: "application/json; charset=utf-8", body: jsonBody)
        send(request: request, success: success, failure: failure)
    }
    
    private func buildRequest(baseURL: URL, method: String, contentType: String? = nil, body: Data? = nil) -> URLRequest {
        var request = URLRequest(url: baseURL, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: timeout)
        request.httpMethod = method
        body.map { request.httpBody = $0 }
        contentType.map { request.setValue($0, forHTTPHeaderField: "Content-Type") }
        userAgent.map { request.setValue($0, forHTTPHeaderField: "User-Agent") }
        return request
    }
    
    private func send(request: URLRequest, success: @escaping ()->(), failure: @escaping (_ error: Error)->()) {
        let task = session.dataTask(with: request) { data, response, error in
            // should we check the response?
            // let dataString = String(data: data!, encoding: String.Encoding.utf8)
            if let error = error {
                failure(error)
            } else {
                success()
            }
        }
        task.resume()
    }
    
}

