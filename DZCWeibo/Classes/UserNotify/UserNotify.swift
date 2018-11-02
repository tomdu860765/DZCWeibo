//
//  UserNotify.swift
//  DZCWeibo
//
//  Created by tomdu on 2018/10/6.
//  Copyright © 2018 tomdu. All rights reserved.
//

import Foundation
import UIKit
//全局用户通知
let UserNotification = "UserNotification"
//全局通知用户登陆
let UserSigninNotification = "UserSigninNotification"
//全局过期通知
let UserExtimeNotification = "UserExtimeNotification"
//用户uid
let userid = "804208746"
//用户加载信息
var usercode = "df559913d0c799bc39ff3a4f400a62ae"
//用户回调路径
let useruri = "https://www.163.com"
//文件夹路径
let documentpath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last
//获取版本号
let infoCFBundleVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"]  as? String
//屏幕的尺寸
let screenbounds = UIScreen.main.bounds
//有刘海的机型
let isheadscreen = true
//当前机型
let devicesnum = UIDevice.current.model
//命名空间
let bundleNamestring = Bundle.main.infoDictionary?["CFBundleName"] as! String


//外部间距
let outtermargin = CGFloat(12)
//内部间距
let innermargin = CGFloat(3)
//view视图宽度
let viewwidth = screenbounds.size.width-2*outtermargin
//每个item的宽度
let itemviewwidth = (viewwidth-2*innermargin)/3
