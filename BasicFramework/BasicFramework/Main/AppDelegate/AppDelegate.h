//
//  AppDelegate.h
//  BasicFramework
//
//  Created by Rainy on 16/8/18.
//  Copyright © 2016年 Rainy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

/**
     首先是怎么安装Protobuf
 brew -v 查看你的mac里面有没有装brew。Homebrew 0.9.5 (git revision be7f2; last commit 2016-03-24)
 ruby -e $(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)在ruby环境下载安装brew,去Homebrew官网找最新的下载地址
 brew install automake
 brew install libtool
 brew install protobuf
 git clone https://github.com/alexeyxo/protobuf-objc.git
 
 ./build.sh 或 
  cd ~/protobuf-objc ->clone的文件目录
 ./autogen.sh
 ./configure
 make
 make install
 
 cd到ProtoBuf的文件夹后，命令如下：
 protoc --plugin=/usr/local/bin/protoc-gen-objc person.proto --objc_out=./
 protoc会自动在/usr/local/bin/目录下寻找名为”protoc-gen-objc”的插件，并使用该插件编译.proto文件，最终生成两个文件：
 Person.pb.h
 Person.pb.m
 */

/*基本用法
 brew search formula # 搜索软件包
 brew install formula # 安装软件包
 brew remove formula # 移除软件包
 brew cleanup formula # 清除旧包
 brew list # 列出已安装的软件包
 brew update # 更新 Homebrew
 brew upgrade # 升级软件包
 brew home formula # 用浏览器打开
 brew info formula # 显示软件内容信息
 brew deps formula # 显示包的依赖
 brew server # 启动 web 服务器，可以通过浏览器访问 http://localhost:4567 来通过网页来管理包
 brew -h # 帮助
 brew versions formula # 列出软件包的版本*/