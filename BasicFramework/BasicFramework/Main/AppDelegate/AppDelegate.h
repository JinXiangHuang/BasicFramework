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

-(void)setMyWindowAndRootViewController;
@end
/*
 iOS提交审核：您的 App 正在使用广告标识符 (IDFA)
     像应用中没有集成广告，但是有第三方工具追踪广告的行为，需要勾选2、3、4这几项，成功通过提交，通过审核。
     如果应用中只集成了广告，没有追踪广告带来的行为，需要勾选1、4。
     如果应用中既集成了广告，又追踪广告带来的行为的情况，全部勾选。
 */
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
 protoc --plugin=/usr/local/bin/protoc-gen-objc messages.proto --objc_out=./
 protoc会自动在/usr/local/bin/目录下寻找名为”protoc-gen-objc”的插件，并使用该插件编译.proto文件，最终生成两个文件：
 Person.pb.h
 Person.pb.m
 */





//models
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


/**
 #安装Cocoapods
 #升级Ruby环境 终端输入：sudo gem update --system
 #安装CocoaPods时我们要访问cocoapods.org  gem sources --remove https://rubygems.org/    gem sources -a https://ruby.taobao.org/
 #可以使用下面的命令(红色部分)查看是否更换镜像成功（如下图所示）：gem sources -l
 #安装Cocoapods，在终端输入命令 sudo gem install cocoapods
 pod setup  ：其实在你安装CocoaPods执行pod install时，系统会默认操作pod setup，然而由于中国强大的墙可能会pod setup不成功。这时就需要手动执行pod setup指令
 #使用search命令搜索类库名：pod search AFNetworking
 
 #需要在工程中创建一个Podfile文件 vim Podfile||pod init 运行结束后，该目录下，会生成了一个Podfile文件
 # 目标平台及其版本use_frameworks!(swift项目需要这句话)，是Objective-C项目的话，请在前面加个`#`注释掉target 'xxxx' do
 (
 A、用cocoapods 导入swift 框架 到 swift项目和OC项目都必须要 use_frameworks!
 B、使用 dynamic frameworks，必须要在Podfile文件中添加 use_frameworks!
 (1)如果在Podfile文件里不使用 use_frameworks! 则是会生成相应的 .a文件（静态链接库），通过 static libraries 这个方式来管理pod的代码。
 
 (2)Linked:libPods-xxx.a包含了其它用pod导入的第三方框架的.a文件。
 
 (3)如果使用了use_frameworks! 则cocoapods 会生成相应的 .frameworks文件（动态链接库：实际内容为 Header + 动态链接库 + 资源文件），使用 dynamic frameworks 来取代 static libraries 方式。
 
 (4)Linked:Pods_xxx.framework包含了其它用pod导入的第三方框架的.framework文件。
 use_frameworks! -> dynamic frameworks 方式 -> .framework
 #use_frameworks! -> static libraries 方式 -> .a
 
 use_frameworks! {
 use_frameworks!遇到了library not found for -lXXXXX 的解决方法
 http://www.jianshu.com/p/d0dc92d9a31b
 或者
 1. #import <> -> #import ""
 2.-l"xxx" -> -framework/"xxx"
 
 
 
 }
 pod 配置文件丢失恢复
 点击“Add User-Defined Setting，人工添加 ${PODS_ROOT} = ${SRCROOT}/Pods。
)
 
 
 
 #按章第三方库pod install
 #如果在安装之后，修改了Podfile文件，可以执行以下的其中一个命令进行库的更新(两个命令的区别和上面说的一样):
 #pod update --no-repo-update or pod update
 
 #更改了Podfile文件，pod update命令
 
 
 
 在项目中移除CocoaPods
 如果你觉得CocoaPods让你的项目出现了问题，不好用甚至是恶心，想将其从项目中彻底移除，也有方法：
 
 1.删除工程文件夹下的Podfile、Podfile.lock和Pods文件夹。
 
 2.删除xcworkspace文件。
 
 3.打开xcodeproj文件，删除项目中的Pods文件夹及Pods.xcconfig引用和libpods.a：
 
 4.打开Build Phases选项，删除Check Pods Manifest.lock和Copy Pods Resources，以及Embeded Pods Frameworks：
 
 5.完成，编译运行，无错通过。
 
 总结
 从项目中移除某个类库直接修改"Podfile"文件即可，但是移除整个CocoaPods就有点麻烦了，或许有其他方法。
 
 另外，如果在编辑工程时不小心删除了某个文件，如Podfile.lock，那么我们就要用上面的方法先移除整个CocoaPods，然后重新建立Podfile和使用pod install命令重装CocoaPods。

pod 配置文件丢失恢复
 一 .关于cocopods的 Attempt to read non existent folder的报错解决办法
   第1种.路径问题：项目路径存在无法识别的folder (backup - copy)错误
   第2种. sudo -- sh -c "echo '117.18.237.29   ocsp.digicert.com' >> /etc/hosts"
    即可，切记：此时应该将终端内的所有命令清除。回车之后，将工程内的pod，pod file，podfilelock文件全部删除，再重新集成即可。
   第3种 .重装
 
 2.修改target名字后 pod
 .xcworkspace 名字无法修改
 在项目中移除CocoaPods  重新 pod init
 
*/


/*
 查看是否有IDFA
 grep -r advertisingIdentifier .
 
 */

/*
 如果你看不到.git目录，你需要让隐藏的文件可见。具体做法就是打开一个Terminal窗口，输入以下命令：
 
 对于OS X Mavericks 10.9:
 
 defaults write com.apple.finder AppleShowAllFiles TRUE
 对于以前的OS X版本，
 
 defaults write com.apple.Finder AppleShowAllFiles TRUE
 为了重启Finder应用，输入
 
 killall Finder
 
 
 */


/**
 短信框架
 http://wiki.mob.com/author/liufl/
 #import <SMS_SDK/SMSSDK.h>
  [SMSSDK registerApp:@"13374c07fcb30" withSecret:@"9c42835c6da3b4a47c85a1c8faa3d636"];
 pod 'SMSSDK', '~> 2.0.4'
 
 pod 'Bugly', '~> 2.3.1'
 
 [Bugly startWithAppId:@"900025299"];
 阿里推送
 #import <CloudPushSDK/CloudPushSDK.h>
 [CloudPushSDK asyncInit:@"23400193" appSecret:@"e095b9ade7d733c7ba7c43098c8e4651" callback:^(CloudPushCallbackResult *res) {

 }];
 */
/**
 CVS及SVN都是集中式的版本控制系统而Git是分布式版本控制系统
 集中式版本控制系统最大的毛病就是必须联网才能工作，
 
 有两种安装Git的方法。
 一是安装homebrew，然后通过homebrew安装Git，具体方法请参考homebrew的文档：http://brew.sh/。
 第二种方法更简单，也是推荐的方法，就是直接从AppStore安装Xcode，Xcode集成了Git，不过默认没有安装？？，你需要运行Xcode，选择菜单“Xcode”->“Preferences”，在弹出窗口中找到“Downloads”，选择“Command Line Tools”，点“Install”就可以完成安装了。
 第一步，用命令git add告诉Git，把文件添加到仓库 git add xxx xxx xxx/git add .(所在路径文件)
 第二步，用命令git commit告诉Git，把文件提交到仓库
 git commit命令，-m后面输入的是本次提交的说明，可以输入任意内容，当然最好是有意义的，这样你就能从历史记录里方便地找到改动记录。
      要随时掌握工作区的状态，使用git status命令。
  如果git status(暂存区 add前＝工作区，add后暂存区)告诉你有文件被修改过，用git diff可以查看修改内容。
 
 git log命令显示从最近到最远的提交日志,嫌输出信息太多，看得眼花缭乱的，可以试试加上--pretty=oneline参数：
 commit id（版本号），和SVN不一样，Git的commit id不是1，2，3……递增的数字，而是一个SHA1计算出来的一个非常大的数字，用十六进制表示
 
 
 (文件夹)
 在Git中，用HEAD表示当前版本上一个版本就是HEAD^，上上一个版本就是HEAD^^，当然往上100个版本写100个^比较容易数不过来，所以写成HEAD~100。
 git reset --hard Head（上一次commit 版本即当前版本）
 git reset --hard Head^（当前版本上一个版本）
 git reset --hard xxx
 要重返未来，用git reflog查看命令历史，commit id是xxx 以便确定要回到未来的哪个版本。
 
 
 工作区和暂存区
 Git和其他版本控制系统如SVN的一个不同之处就是有暂存区的概念。
 工作区有一个隐藏目录.git，这个不算工作区，而是Git的版本库。Git的版本库里存了很多东西，其中最重要的就是称为stage（或者叫index）的暂存区，还有Git为我们自动创建的第一个分支master，以及指向master的一个指针叫HEAD。
 git add命令实际上就是把要提交的所有修改放到暂存区（Stage），然后，执行git commit(git commit只负责把暂存区的修改提交了)就可以一次性把暂存区的所有修改提交到分支。
 每次修改，如果不add到暂存区，那就不会加入到commit中。
 git status(暂存区 add前＝工作区，add后暂存区)
 
 撤销修改,还原 () （文件 file）
 git checkout -- file命令中的--很重要，没有--，就变成了“切换到另一个分支”的命令
 命令git checkout -- readme.txt意思就是，把readme.txt文件在工作区的修改全部撤销，这里有两种情况：
 一种是readme.txt自修改后还没有被放到暂存区，现在，撤销修改就回到和版本库一模一样的状态；(指定文件撤销修改，全部文件撤销修改git reset --hard Head)
 一种是readme.txt已经添加到暂存区(add)后，又作了修改，现在，撤销修改就回到添加到暂存区(add)后的状态。
 总之，就是让这个文件回到最近一次git commit或git add时的状态。
 
 用命令git reset HEAD file可以把暂存区的修改撤销掉（unstage），重新放回工作区
 git checkout --file 撤销修改就回到和版本库一模一样的状态
 
 远程仓库:
 创建SSH Key。在用户主目录下，看看有没有.ssh目录，如果有，再看看这个目录下有没有id_rsa和id_rsa.pub这两个文件，如果已经有了，可直接跳到下一步。如果没有，打开Shell（Windows下打开Git Bash），创建SSH Key
 $ ssh-keygen -t rsa -C "youremail@example.com"
 你需要把邮件地址换成你自己的邮件地址，然后一路回车，使用默认值即可，由于这个Key也不是用于军事目的，所以也无需设置密码。
 
 Initialize this repository with a README 表示在初始化仓库的时候，是否生成一个readMe文件。我们在查看别人框架的时候，在框架主页上会有对该框架版本信息，作用使用方法等等的介绍，这个文件就是readMe文件，在这里选择勾上。
 　　Add .gitignore按钮，点击之后会出现一个下拉框，问你是否要设置仓库的忽略文件。这个看你自己的需要，通常如果你的仓库和代码项目有关系，那么最好选择相应的忽略文件（如OC项目可以选择Object-C,swift项目可以选择Swift），至于为什么请参考GIT的基本使用。
 　　Add a license按钮，点击之后会出现一个下拉框，需要你选择一种开源协议，开源协议有很多种用的比较多的有MIT的或者是Apache的，不同的开源协议对项目的使用方式等有不同的规定，详情可以参考Choose an open source license。
 
 连接远程仓库:可以使用第三方的GIT管理图形界面工具如sourceTree，也可以使用终端（命令行），或者是XCode。
 
 XCode:把MAC 上面的XCode打开，打开之后，左上角菜单选择Xcode->Preference选项,切换到Accounts菜单，点击左下角的+号，选择Add Respository添加仓库,Address需要输入要连接的远程仓库地址，其实要连接远程仓库有两种方式可以选择一种是HTTPS请求的，一种是SSH密钥对,Type:表示使用的版本管理方式可以选择GIT和SVN，在这里只能选择Git(因为GIThub只支持git的方式来管理)
 　　Authentication:表示认证的方式即验证身份的，Github提供两种验证方式，HTTPS和SSH，我们当前选择的是HTTPS的方式，所以此处选择User Name and Password.
 　　User Name 和passWord两处填入github网站登录的用户名和密码即可。
 # 显示隐藏文件   $ defaults write com.apple.finder AppleShowAllFiles Yes && killall Finder
 # 不显示隐藏文件 $ defaults write com.apple.finder AppleShowAllFiles No && killall Finder
 终端（命令行）
 https
 git remote add origin2 https://github.com/JinXiangHuang/someFiles.git
 remote.origin2.url=https://github.com/JinXiangHuang/someFiles.git
 SSH密钥对
 git remote add origin git@github.com:JinXiangHuang/someFiles.git
 remote.origin.url=git@github.com:JinXiangHuang/someFiles.git

 建议用命令复制ssh key,用文本软件打开有可能出错!
 mac
 pbcopy < ~/.ssh/id_rsa.pub
 windows
 clip < ~/.ssh/id_rsa.pub
 linux
 sudo apt-get install xclip
 xclip -sel clip < ~/.ssh/id_rsa.pub
 
 No such file or directory  创建SSH Key：
 ssh-keygen -t rsa -C "youremail@example.com"
 用户主目录里找到.ssh目录，里面有id_rsa和id_rsa.pub两个文件，这两个就是SSH Key的秘钥对，id_rsa是私钥，不能泄露出去，id_rsa.pub是公钥
 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCnzm128s68qMgyO7F4wpiAgDCgYiik7o/2+Nd8GKca+tMjarnNvByWx1DEXmFSssG5eqkN4SlYjhr823vBMSCgwUKHpuim1QNmJo6evmEWFB+LLdjMghP6voZkNfYdmXdG7RH4nE9fuqpmm1hN0r4mVLjDmFPLh/qp2v/BISv19HK4sjk2Pt3BEHCKhQZMbQujK4hNgOYcUrZHHkbdeLVNm4qFliq0sV7cFuC9khwAX5ikqPaC90jqHr5EqjVExMP1sONLY0xQgIO6y937Q+fP4CjgMw6EtRGYqTMvJLTXR3RLzaOlWkms1V8sGxe/sMafaecl2XXWJRbjPFxaa15Z 445106527@qq.com

 *****先有本地库(是否有README.md)，后有远程库的时候，如何关联远程库。*****

 …or create a new repository on the command line{
 echo "# someFiles" >> README.md
 git init
 git add README.md
 git commit -m "first commit"
 git remote add origin https://github.com/JinXiangHuang/someFiles.git
 git push -u origin master
 }

 …or push an existing repository from the command line{
 git remote add origin https://github.com/JinXiangHuang/someFiles.git
 git push -u origin master
 }

 …or import code from another repository{
 You can initialize this repository with code from a Subversion, Mercurial, or TFS project.
}
 
 Git库第一次提交代码解决冲突(error: failed to push some refs to 'git@github.com:JinXiangHuang/someFiles.git'
 hint: Updates were rejected because the remote contains work that you do
 hint: not have locally. This is usually caused by another repository pushing
 hint: to the same ref. You may want to first integrate the remote changes
 hint: (e.g., 'git pull ...') before pushing again.
 hint: See the 'Note about fast-forwards' in 'git push --help' for details.->
 第一种解决.缺少 echo "# someFiles" >> README.md  git add README.md
 第二种解决.git pull git@github.com:JinXiangHuang/someFiles.git)????
 
 **** 先创建远程库，然后，从远程库克隆。 ****
 
 1.git clone git@github.com:JinXiangHuang/someFiles.git
 
 2.add commit ...
 
 3.命令git push -u origin master第一次推送master分支的所有内容；此后，每次本地提交后，只要有必要，就可以使用命令git push origin master推送最新修改；
 
 
 
 
 
 项目没有勾选git：
 cd /Users/YOUR-USERNAME/Desktop/NoGitExample
 别忘了在上边命令中设置Mac的用户名，接下来，输入：
 git init
  这会初始化一个空的源，如果你在Finder里面查看或是输入ls命令，你会看到.git子目录已经被创建，很好，接下来输入：
 git add .
 这样，当前目录所有的内容就被添加到源里面去了，最后，输入以下命令：
 git commit -m 'Initial commit'
 
 */
