/*
 * Copyright (c) 2020-Present, Okta, Inc. and/or its affiliates. All rights reserved.
 * The Okta software accompanied by this notice is provided pursuant to the Apache License, Version 2.0 (the "License.")
 *
 * You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0.
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *
 * See the License for the specific language governing permissions and limitations under the License.
 */
import UIKit
import Firebase
import OktaLogger
import OktaAnalytics
import AppCenterAnalytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let appCenterAnalyticsProvider: AnalyticsProviderProtocol = {
        AppCenter.start(withAppSecret: "App Secret", services: [AppCenterAnalytics.Analytics.self])
        let logger = OktaLogger()
        logger.addDestination(
            OktaLoggerConsoleLogger(
                identifier: "com.okta.loggerDemo.console",
                level: OktaLoggerLogLevel.debug,
                defaultProperties: nil
            )
        )
        return AppCenterAnalyticsProvider(name: "AppCenter", logger: logger, appCenter: AppCenterAnalytics.Analytics.self)
    }()

    var timer: Timer?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        OktaAnalytics.addProvider(appCenterAnalyticsProvider)
        OktaAnalytics.trackEvent("applicationDidFinishLaunchingWithOptions", withProperties: nil)
        return true
    }
}
