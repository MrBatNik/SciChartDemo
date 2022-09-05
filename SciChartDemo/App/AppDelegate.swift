//
//  AppDelegate.swift
//  SciChartDemo
//
//  Created by Nikita Batrakov on 03.09.2022.
//

import UIKit
import SciChart

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.backgroundColor = .red
        window?.rootViewController = UINavigationController(
            rootViewController: ChartViewController()
        )
        window?.makeKeyAndVisible()
        setupSciChart()
        
        return true
    }
    
    private func setupSciChart() {
        SCIChartSurface.setRuntimeLicenseKey(
            "w6xy/g0aWLcYOjYQNsVGsgL19vaBXuAjXDTkVux5XwNKqP6E38uht5MT7ttjjTNwye2f1x58M4KTGwnw+JeH1dyyL4BoKfg484WCs5Woz7IQa4WNP7Kw14ysL4zS9s2ss8+Bd/a06mGhIM19oEd1uZqAp+f9/OUiSLzPx5CFKiyaFkVFu5p41xSeWz6b+iodGe/7FFcdCNdtnNYB/DmqGCOx183wqK1OtYscvIoXlgrezR8qsZQRVTrGD5BBFkPmwrRBijUX2ywyNld15n0A3imHabiDzsIibvtBth7YDXUCTVAP3aA3JMkhUGoYsQ7FTlnDhg9i4dM/MdtoFiTSwPV+XRMI5ViTqFsIyI5vHORsj1rsSvp+LibMxhofegLSDCac+8ctofLKclHq9lLf4l7/1FtJCQ9qV5eIflGm1c3O7KRKJe4iYCqrxA6A7VUR8SbQMAXd7s0FAGyD9QRWGjWoWEUeCokrpXOjhJ1bsfB0q3oxDglXo4iBPBj0gYm8OK7byCZA6dOPKnI8yfJdJIB+1Zm6g4+JulcFXxzSZ+aSeKQ+uFkXyJ1QYSrT9RUahX+G5BJU"
        )
    }
}
