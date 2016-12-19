//
//  TBFirstViewController.h
//  TheBackgrounder
//
//  Created by Gustavo Ambrozio on 19/1/13.
//  Copyright (c) 2013 Gustavo Ambrozio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBFirstViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lblMusicName;
@property (strong, nonatomic) IBOutlet UILabel *lblMusicTime;
@property (strong, nonatomic) IBOutlet UIButton *btnPlayPause;

- (IBAction)didTapPlayPause:(id)sender;
@end
/*

 Cocoa 触摸框架层（theCocoa Touch layer)、媒体层（the Media layer）、核心服务层（the Core Services layer）、核心操作系统（the Core OS layer）
 
 Cocoa Touch层包含创建 iOS应用程序所需的关键框架。上至实现应用程序可视界面，下至与高级系统服务交互，都需要该层技术提供底层基础。在开发应用程序的时候，请尽可能不要使用更底层的框架，尽可能使用该层的框架。
 多任务
 数据保护
 苹果推送通知服务
 本地通知
 手势识别器:UIGestureRecognizer可以使用自定义的手势识别器子类或者系统定义的某个子类处理下面这些标准手势：拍击 (任意次数的拍击) 向里或向外捏 (用于缩放) 摇动或者拖拽 擦碰 (以任意方向) 旋转 (手指朝相反方向移动) 长按
 文件共享支持:用户就可以在iPad和桌面计算机来回移动文件。不允许应用程序和同一设备上的其他应用程序共享文件。如果希望在程序间共享文件，请使用剪贴板或者文档交互控制器对象。

 在应用程序的Info.plist文件中添加UIFileSharingEnabled键，并将键值设置为YES。
 将您希望共享的文件放在应用程序的Documents目录。
 一旦设备插入到用户计算机，iTunes 9.1就会在选中设备的Apps标签中显示一个File Sharing区域。
 此后，用户就可以向该目录添加文件或者将文件移动到桌面计算机中。
 
 点对点服务
 在iOS 3.0 及后续版本，Game Kit框架支持经由蓝牙进行点对点连接。您可以使用点对点连接启动与某个邻近设备的通讯会话，也可用它实现多种多玩家游戏的常见特性。虽然点对点连接主要应用于游戏，但您也可将之应用于其他类型应用程序。
 标准系统视图控制器
 显示或者编辑联系人信息 - 请使用Address Book UI框架中的视图控制器。
 创建或者编辑日历事件 - 请使用Event Kit UI框架的视图控制器。它提供一个视图控制键可以展现查看并编辑事件的标准系统界面
 创建email或者SMS消息 - 请使用Message UI框架中的视图控制器。您可以通过它在应用程序中直接创建并编辑SMS信息（无需离开应用程序）
 打开或者预览一份文件的内容 - 请使用UIKit框架中的UIDocumentInteractionController类。
 从用户的照片库选取一张照片 - 请使用UIKit框架中的 UIImagePickerController 类。
 拍摄视频片段 - 请使用UIKit框架中的UIImagePickerController类。
 外部设备支持:当外部设备连上后，应用程序就可以使用其显示屏显示内容。屏幕的信息，包括屏幕能够支持的分辨率都可通过UIKit框架的接口获取。您也可以通过该框架将应用程序窗口关联到某个屏幕。
 
 
 iAd框架 (iAd.framework)。您可以通过该框架在应用程序中发布横幅广告。广告会被放入到标准视图，您可以将这些视图加入到用户界面，并在合适的时机向用户展现。这些视图和苹果的公告服务相互协作，自动处理广告内容的加载和展现，同时也可以响应用户对广告的点击。
 
 Map Kit框架 (MapKit.framework) ，该框架供一个可被嵌入到应用程序的地图界面，该界面包含一个可以滚动的地图视图。您可以在视图中添加定制信息，并可将其嵌入到应用程序视图，通过编程的方式设置地图的各种属性（包括当前地图显示的区域以及用户的方位）。您也可以使用定制标注或标准标注（例如使用测针标记）突出显示地图中的某些区域或额外的信息。在iOS 4.0系统中，该框架开始支持可拖动标注以及定制覆盖层。可拖动标注允许您通过编程方式或通过用户交互方式重定位某个标注的位置。覆盖层可用于创建多个点组成的复杂地图标注。地图表面诸如公交路线、选举地图、公园边界或者气象信息（例如雷达数据）等可以使用覆盖层进行显示。
 
 
 UIKit框架 (UIKit.framework)核心功能：
 
 应用程序管理
 用户界面管理
 图形和窗口支持
 多任务支持
 处理触摸及移动事件。
 代表标准系统视图和控件的对象
 文本和web内容相关操作
 剪切、复制以及粘贴
 使用动画显示用户界面内容
 通过URL方式将其他应用程序整合到系统
 苹果推送通知服务支持，请查看“苹果推送通知服务 ”
 为残疾用户提供辅助功能
 本地通知的调度和发送
 创建PDF
 使用定制输入视图（其行为类似系统键盘）
 创建和系统键盘进行交互的定制文本视图
 除了链编至应用程序的基础代码，UIKit还为下述和设备紧密相连的功能提供支持：
 
 加速器数据
 内置相机（存在相机的设备）
 用户的图片库
 设备名称和模型信息
 电池状态信息
 距离感应器信息
 来自绑定听筒的远程控制信息
 
 
 
 
 
 
 媒体层（the Media layer）:媒体层包含图形技术、音频技术和视频技术，这些技术相互结合就可为移动设备带来最好的多媒体体验，更重要的是，它们让创建外观音效俱佳的应用程序变得更加容易。您可以使用iOS的高级框架更快速地创建高级的图形和动画，也可以通过底层框架访问必要的工具，从而以某种特定的方式完成某种任务。
 
 
 音频技术层：也可以用于触发发设备的震动功能（具有震动功能的设备）
 在选择音频技术的时候，请记住，要尽可能地选取高级框架，因为可以简化播放音频所需的工作
 从高级到低级排列:
 
 媒体播放器框架（Media Player　framwork）。该框架可以让访问用户的iTuns库变得很容易，并且支持播放曲目和播放列表。
 
 AV Foundation框架。它提供一组简单易用的Objective-C接口，可用于管理音频的播放或录制。(定制各种音频播放器，并实现一些高级功能。AVFoundation可以播放系统中声音文件以及原始音频数据。当然利用此框架还可以实现声音的混叠效果，同时控制多个音频文件的播放。)
 
 OpenAL框架。它提供一组跨平台，用于发布方位音频的接口。
 
 CoreAudio.framework：框架。它提供的接口简单而精密，可用于播放或录制音频内容。您可以使用这些接口播放系统的警报声音、触发备的震动功能、管理多声道的缓冲和播放、对音频内容进行流化处理。主要用于定制各种音频的数据类型。
 
 AudioToolbox.framework：
 可以播放或者录制音频文件。同时还可以对原始音频数据文件进行操作。经过一定的设置还可以实现震动等效果。
 
 OPEN AL.framework：
 Open al（ Open Audio Library）是一项跨平台的音频处理方案。通过此框架可以方便的实现各种音频文件的播放。同时还可以实现对pcm音频文件的播放。尤其是在3D音效技术中，具有非常重要的作用。通过此技术可以很方便的在游戏以及一些特殊的场合实现3D音频特效。
 
 WAV：WAV是微软公司开发的一种音频格式，它几乎没有对采集的数字音频信号进行失真处理，因此可以很好的还原声音的原始信息。
 
 MP3：是今年来最流行的音频处理算法，它在不对音质造成太大影响的情况下最大限度的压缩了数据的大小。
 
 AAC：AAC音频文件的全称是Advanced Audio Coding，采用和mp3完全不同的数据压缩算法，相较于mp3来说具有更高的性价比，音质较好。
 
 Caf：ios设备录音时经常存储的一种音频文件类型。
 
 
 视频技术层：OS有数种技术可用于播放应用程序包的电影文件以及来自网络的数据流内容。如果设备具有合适的视频硬件，这些技术也可用于捕捉视频，并可将捕获到的视频集成到应用程序。系统提供也提供多种方法用于播放或录制视频内容，您可以根据需要选择。选择视频技术的时候，请尽可能选择高级框架，因为高级框架可以简化为提供对某种功能的支持所需的工作。下面列出的框架由高级到低级排列。其中，媒体播放器框架提供最高级的接口：
 
 媒体播放器框架（Media Player　framwork），它提供一组易于使用的接口，可用于播放应用程序中全屏或部分屏的电影。快速的设计出一个视频播放器。但缺点是不方便用户在上面进行二次开发。
 AV Foundation框架，它提供一组Objective-C接口，可以对电影的捕捉和播放进行管理。
 Core Media框架，它对较高级框架使用的底层类型进行描述，同时也提供一些底层接口，它们用于对媒体进行处理。
 iOS视频技术支持播放的电影文件应具有.mov、.mp4、.m4v以及.3gp文件扩展名，而且文件应使用下述的压缩标准：
 
 H.264视频，多达1.5 Mbps， 640x480像素，每秒30帧。 H.264 Baseline Profile 的 Low-Complexity 版本支持 AAC-LC 音频（ .m4v、.mp4以及.mov文件格式中高达160Kbps ,48KHz 的立体音频）。
 H.264视频，高达68 Kbps，320x240像素，每秒30帧。达到Level 1.3的 Baseline Profile支持AAC-LC音频（ .m4v、.mp4以及.mov文件格式中高达160Kbps ,48KHz 的立体音频）。
 MPEG-4视频，高达 2.5 Mbps， 640 x 480像素，每秒30帧。Simple Profile支持AAC-LC 音频（ .m4v、.mp4以及.mov文件格式中高达160Kbps ,48KHz 的立体音频）。
 各种音频格式，包括 “音频技术”列出的清单。

 图像技术层：
 创建应用程序最简单最有效的方法是使用事先渲染过的图片，搭配上标准视图以及UIKit框架的控件，然后把绘制任务交给系统来执行。但是在某些情况下，您可能需要一些UIKit所不具有的功能，而且需要定制某些行为。在这种情况下，您可以使用下述技术管理应用程序的图形内容：
 
 Core Graphics（CoreGraphics.framework) (也被称为Quartz)，用于处理本地2D向量渲染和图片渲染。主要利用Quartz2D实现对二维图像的处理，因此也经常将其称之为Quartz 2D技术。
 Core Animation ( Quartz Core框架的一部分)，主要应用于二维动画的制作，以及一些高级高级视觉效果的渲染。
 OpenGL ES，（OpenGLfor Embedded Systems）是Open Gl专门针对嵌入式操作系统量身定制的。提供完备的2d、3d图像处理API，功能非常强大。是游戏图像、高清图像的首先技术方案。为使用硬件加速接口的2D和3D渲染提供支持。
 Core Text，提供一个精密的文本布局和渲染引擎。
 Image I/O，（ImageIO.framework）可以看出是图像的输入输出管理，可以利用此框架处理图像的基本像素信息。该框架的使用是建立在 Core Graphics数据类型和函数之上的。提供读取及编写大多数图形格式的接口。
 资产库框架（Assets Library framework），可用于访问用户照片库中的照片和视频。
 大多数应用程序应该无需改动，或者只需做很少修改，便可运行在具备高分辨率屏幕的设备。因为在绘图或者操作视图的时候，您所指定的座标值会被映射到逻辑座标系统，它和底层屏幕分辨率没有关联。而且绘制的内容会自动根据需要按比例缩放，以此来支持高分辨率屏幕。对基于向量进行绘制的代码来说，系统框架会自动使用额外的像素来改善图画的内容，使其变得更清晰。如果应用程序中使用了图片，则可以利用UIKit自动加载现有图片的高分辨率版本。
 图像处理是视频处理的基础，同时也是人们视觉体验种非常重要的部分。图像技术层设计到的技术主要有：Core Graphics、Core Animation、Image I/O、OpenGL ES等。正是由于图像技术层提供了这些众多的工具，才能使得我们方便的对图像进行处理。

 
 IOS兼容多种图像格式，如常用的png、jpeg、bmp等都有很好的支持。

 
 媒体层包含的框架
 资产库框架
 iOS 4.0引入了资产库框架(AssetsLibrary.framework)，该框架提供一个查询界面，您可以通过它查找用户照片和数据。通过使用该框架，您可以访问Photos管理的资产，包括用户保存的相册以及导入到设备中的图片或视频。而且您也可以将照片或者视频保存到用户的相册。
 AV Foundation 框架
 iOS 2.2引入了AV Foundation 框架 (AVFoundation.framework)，该框架包含的Objective-C 类可用于播放音频内容。通过使用该框架，您可以播放声音文件或播放内存中的音频数据，也可以同时播放多个声音，并对各个声音的播放特定进行控制。
 
 在 iOS 4.0及后续版本中，该框架提供的服务得到很大的扩展，下述的服务现在也包含在框架中：
 
 媒体资产管理
 媒体编辑
 电影捕捉
 电影播放
 曲目管理
 媒体项的元数据管理
 立体声淘选
 不同声音的精确同步
 用于判断声音文件详细信息的Objective-C接口，例如判断数据格式、采样率和声道数。
 AV Foundation框架是iOS中录制播放音频和视频的唯一框架，该框架还支持对媒体项进行管理和处理。
 
 Core Audio
 Core Audio框架提供C语言接口，可用于操作立体声音频。通过iOS系统Core Audio框架，您可以在应用程序中生成、录制、混合或播放音频，您也可通过该框架访问设备的震动功能（支持震动功能的设备）。
 CoreAudio.framework
 定义Core Audio框架家族使用的音频数据类型。
 AudioToolbox.framework
 播放或录制音频文件或数据流，也可用于管理音频文件、播放系统警告声音、触发某些设备的震动功能。
 AudioUnit.framework
 为内置音频单元服务，内置音频单元是指音频处理模块。
 
 Core Graphics 框架
 Core Graphics框架 (CoreGraphics.framework)包含Quartz 2D绘图API接口 。Quartz 是Mac OS X系统使用的向量绘图引擎，它支持基于路径绘图、抗锯齿渲染、渐变、图片、颜色、坐标空间转换、PDF文件的创建、显示和解析。虽然API基于C语言，但是它使用基于对象的抽象以表示基本绘图对象，这样可以让开发者可以更方便地保存并复用图像内容。
 

 
 Core Text 框架
 (CoreText.framework)，该框架包含一组简单高效的C接口，可用于对文本进行布局以及对字体进行处理。Core Text框架提供一个完整的文本布局引擎，您可以通过它管理文本在屏幕上的摆放。所管理的文本也可以使用不同的字体和渲染属性。该框架专为诸如字处理程序这类需要具有精密文本处理功能的应用程序而设计。如果您的应用程序只需要一种文本输入和显示，则应使用UIKit框架中已有的类。
 
 Core Video 框架
 (CoreVideo.framework) ，该框架为Core Media提供缓存和缓存池的支持。大多数应用程序都不应该直接使用该框架。
 
 Image I/O 框架
 (ImageIO.framework)，该框架的接口可用于导入或导出图像数据及图像元数据。该框架建构于 Core Graphics数据类型和函数之上，能够支持iOS 上所有的标准图像类型。
 
 
 
 媒体播放器框架
(MediaPlayer.framework)为应用程序播放视频和音频内容提供高级支持。通过该框架，您就可以使用标准系统界面播放视频。 iOS 3.0增加了对访问用户iTune库的支持。因此，您可以利用该框架播放音乐曲目、播放列表、搜索歌曲并向用户显示媒体选取界面。
 在 iOS 3.2系统中，该框架发生了变化，开始支持在可改变尺寸的视图中播放视频（之前只支持全屏）。另外还新增数个界面用于支持配置和管理电影播放。
 

 OpenAL 框架
 除了Core Audio之外，, iOS 还支持 Open Audio Library (OpenAL)。OpenAL接口是在应用程序中发布方位音频的跨平台标准。通过使用该框架，您可以在游戏或者要求有方位音频输出的程序中实现高性能、高质量的音频。OpenAL是跨平台的标准，iOS平台使用OpenAL编写的代码模块可以移植到许多其他的平台运行。
 
 
 OpenGL ES 框架
 OpenGL ES框架 (OpenGLES.framework)提供的工具可用于绘制2D及3D内容。该框架基于C语言，能够和设备硬件紧密协作，为全屏游戏类型的应用程序提供很高的帧速率。
 OpenGL框架需要和EAGL接口结合使用。这些接口是 OpenGL ES 框架的一部分，它们是OpenGL ES绘图代码及应用程序中的窗口对象的接口。
 
 在 iOS 3.0及其后续版本的系统中，OpenGL ES 框架同时支持 OpenGL ES 2.0 及OpenGL ES 1.1 接口规范。2.0规范支持分段和点着色，只有运行iOS 3.0及其后续版本的设备才支持2.0。所有版本的iOS及iOS设备都支持OpenGL ES 1.1规范。
 
 
 Quartz Core 框架
 Quartz Core框架 (QuartzCore.framework)包含Core Animation接口。Core Animation是高级动画制作和混合技术，它使用经过优化的渲染路径实现复杂的动画和视觉效果。它提供的高级Objective-C接口可对动画效果进行配置，然后在设备硬件中进行渲染，以此来提高程序的性能。Core Animation框架被整合到iOS的许多部分（包括UIKit框架中的许多类（如UIView）），可以为多种系统行为提供动画效果。您也可以使用该框架中的Objective-C接口直接创建定制动画。
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 Core Services 层
 
 
Grand Central Dispatch
Grand Central Dispatch (GCD)，它是BSD级别的技术，可用于在应用程序内管理多个任务的执行。GCD技术将异步编程模型和高度优化内核结合在一起，可作为多线程的便捷（且更高效）替代。同时，它也为许多种底层任务（ 例如读写文件描述符、实现定时器、监视信号和处理事件等）提供替代方案。
应用程序内购买（In App Purchase）
通过该功能，您可以在应用程序内出售内容或服务。该功能使用Store Kit框架来实现，它可以为使用iTunes账户进行的财务交易的处理提供基础支持，应用程序只需处理用户体验及待售内容或服务的展现。
 
 定位服务
 应用程序可使用Core Location框架提供的接口追踪用户位置。此框架利用当前可用的硬件无线电波（包括Wi-Fi、蜂窝无线或者GPS）定位用户的当前位置。应用程序可以对框架提供的信息进行裁剪，然后再将其发送给客户， 或是用于实现某些特定功能。举个例子，社交应用程序允许您找到附近其他应用程序用户，然后再与之进行通讯。
 
 SQLite
 SQLite库允许开发者将一个轻量级SQL数据库嵌入到应用程序，而且开发者不需要运行独立的远程数据库服务器进程。在此之后，开发者可以在应用程序中创建本地数据库文件，管理文件中的表和记录。虽然SQLite数据库出于通用目的而设计，但它还是针对数据库记录的快速访问做过优化。
 用于访问SQLite库的头文件位于 <iOS_SDK>/usr/include/sqlite3.h。 在该路径中， <iOS_SDK>是Xcode安装目录中目标SDK的路径。
 
 XML 支持
 Foundation框架支持使用NSXMLParser 类从XML文档中解析元素，而libXML2库则为操作XML内容提供支持。 libXML2库是开源的，它可以让您快速地解析或写入任意的XML数据，也可将XML内容转化为HTML文件。
 
 用于访问libXML2库的头文件位于 <iOS_SDK>/usr/include/libxml2/。 在该路径中， <iOS_SDK>是Xcode安装目录中目标SDK的路径。 
 
 
 Address Book 框架
 Address Book框架 (AddressBook.framework)支持编程访问存储于用户设备中的联系人信息。如果应用程序使用到联系人信息，则可通过该框架访问并修改用户联系人数据库的记录。举个例子，通过使用该框架，聊天程序可以获取一个联系人列表，利用此列表初始化聊天会话，并在联系人视图显示列表的联系人。
 
 CFNetwork 框架
 CFNetwork框架 (CFNetwork.framework)提供一组高性能基于C语言的接口，它们为使用网络协议提供面向对象抽象。通过这些抽象，您可以对协议栈进行更精细的控制，而且可以使用诸如 BSD socket这类底层结构。您也可以通过该框架简化诸如与FTP或HTTP服务器通讯以及DNS主机解析这类任务。下面列举一些可以使用 CFNetwork框架执行的任务：
 
 使用BSD sockets
 使用SSL或TLS创建加密连接
 解析DNS主机
 使用HTTP，校验HTTP以及HTTPS服务器。
 使用FTP服务器
 发布、解析并浏览 Bonjour服务。
 CFNetwork理论及实现都以 BSD socket为基础。
 
 Core Data 框架
(CoreData.framework)。Core Data框架是一种管理模型-视图-控制器应用程序数据模型的技术，它适用于数据模型已经高度结构化的应用程序。通过此框架，您再也不需要通过编程定义数据结构，而是通过Xcode提供的图形工具构造一份代表数据模型的图表。在程序运行的时候，Core Data框架就会创建并管理数据模型的实例，同时还对外提供数据模型访问接口。
 通过Core Data管理应用程序的数据模型，可以极大程度减少需编写的代码数量。除此之外，Core Data还具有下述特征：
 
 将对象数据存储在SQLite数据库以获得性能优化。
 提供NSFetchedResultsController 类用于管理表视图的数据。
 管理undo/redo操作。
 属性值校验支持。
 支持对数据变化进行传播，并且不会改变对象间的关联。
 支持对数据进行归类，过滤，并支持对内存数据进行管理。
 如果您正在开发新应用程序或打算对某个现有的程序进行大幅度更新，请考虑使用Core Data。
 
 Core Foundation 框架
 Core Foundation框架 (CoreFoundation.framework) 是一组C语言接口，它们为iOS应用程序提供基本数据管理和服务功能。下面列举该框架支持进行管理的数据以及可提供的服务：
 
 群体数据类型 (数组、集合等)
 程序包
 字符串管理
 日期和时间管理
 原始数据块管理
 偏好管理
 URL及数据流操作
 线程和RunLoop
 端口和soket通讯
 Core Foundation框架和Foundation框架紧密相关，它们为相同功能提供接口，但Foundation框架提供Objective-C接口。如果您将Foundation对象和Core Foundation类型掺杂使用，则可利用两个框架之间的 “toll-free bridging”。所谓的Toll-free bridging是说您可以在某个框架的方法或函数同时使用Core Foundatio和Foundation 框架中的某些类型。很多数据类型支持这一特性，其中包括群体和字符串数据类型。每个框架的类和类型描述都会对某个对象是否为 toll-free bridged，应和什么对象桥接进行说明。

 
 Core Location 框架
 Core Location框架 (CoreLocation.framework)可用于定位某个设备当前经纬度。它可以利用设备具备的硬件，通过附近的GPS、蜂窝基站或者WiFi信号等信息计算用户方位。Maps应用程序就是利用此功能在地图上显示用户当前位置。您可以将此技术结合到应用程序，以此向用户提供方位信息。例如，应用程序可根据用户当前位置搜索附近饭店、商店或其他设施 。
 
 在iOS 3.0系统中，该框架开始支持访问iOS设备（具有相应硬件的设备）的方向信息。
 在iOS 4.0系统中，该框架开始支持低能耗的方位监视服务，该服务利用蜂窝基站跟踪用户方位。
 
 
 Core Media 框架
 iOS 4.0引入了Core Media框架 (CoreMedia.framework)。此框架提供AV Foundation框架使用的底层媒体类型。只有少数需要对音频或视频创建及展示进行精确控制的应用程序才会涉及该框架，其他大部分应用程序应该都用不上。
 
 
 Core Telephony 框架
 iOS 4.0引入了Core Telephony框架(CoreTelephony.framework)。此框架为访问具有蜂窝无线的设备上的电话信息提供接口，应用程序可通过它获取用户蜂窝无线服务的提供商信息。如果应用程序对于电话呼叫感兴趣，也可以在相应事件发生时得到通知。

 
 Event Kit 框架
 iOS 4.0引入了 Event Kit框架 (EventKit.framework)。此框架为访问用户设备的日历事件提供接口。您可以通过该框架访问用户日历中现有事件，可以增加新事件。日历事件可包含闹铃，而且可以配置闹铃激活规则。
 
 Foundation 框架
 Foundation框架 (Foundation.framework)为 Core Foundation框架的许多功能提供Objective-C封装。您可以参考Core Foundation框架了解前面对Core Foundation框架的描述。 Foundation框架为下述功能提供支持：
 
 群体数据类型 (数组、集合等)
 程序包
 字符串管理
 日期和时间管理
 原始数据块管理
 偏好管理
 URL及数据流操作
 线程和RunLoop
 Bonjour
 通讯端口管理
 国际化
 正则表达式匹配
 缓存支持
 如需进一步了解如何使用该框架的类和方法，请阅读Foundation框架参考 。
 
 Mobile Core Services 框架
 iOS 3.0引入了Mobile Core Services框架 (MobileCoreServices.framework)。此框架定义统一类型标识符 (UTIs)使用的底层类型。
 
 
 Quick Look 框架
 iOS 4.0引入Quick Look框架(QuickLook.framework），应用程序可以用过该框架预览无法直接支持查看的文件内容。如果应用程序从网络下载文件或者需处理来源未知的文件，则非常适合使用此框架。因为应用程序只要在获得文件后，调用框架提供的视图控制器就可以直接在界面中显示文件的内容。
 
 
 Store Kit 框架
 iOS 3.0引入Store Kit 框架(StoreKit.framework)，此框架为iOS应用程序内购买内容或服务提供支持。例如，开发者可以利用此框架允许用户解锁应用程序的额外功能。或者假设您是一名游戏开发人员，则可使用此特性向玩家出售附加游戏级别。在上述的两种情况中，Store Kit 框架会处于交易过程中和财务相关的事件，包括处理用户通过 iTunes Store账号发出的支付请求并且向应用程序提供交易相关信息。
 
 Store Kit框架主要关注交易过程中和财务相关的事务，目的是为了确保交易安全准确。应用程序需要处理交易事物的其他因素，包括购买界面和下载（或者解锁）恰当的内容。通过这种任务划分方式，您就拥有购买内容的控制权，可以决定希望展示给用户的购买界面以及何时向用户展示这些界面，同时也可以决定和应用程序最匹配的交付机制。
 
 System Configuration 框架
 System Configuration框架(SystemConfiguration.framework) 可用于确定设备的网络配置。您可以使用该框架判断Wi-Fi或者蜂窝连接是否正在使用中，也可以用于判断某个主机服务是否可以使用。
 
 
 
 
 
 
 
 
 
 
 Core OS 层
 
 Core OS层的底层功能是很多其他技术的构建基础。通常情况下，这些功能不会直接应用于应用程序，而是应用于其他框架。但是，在直接处理安全事务或和某个外设通讯的时候，则必须要应用到该层的框架。
 
 Accelerate 框架
 iOS 4.0引入了Accelerate框架（Accelerate.framework）。该框架的接口可用于执行数学、大数字以及DSP运算。和开发者个人编写的库相比，该框架的优点在于它根据现存的各种iOS设备的硬件配置进行过优化。因此，您只需一次编码就可确保它在所有设备高效运行。
 
 External Accessory 框架
 iOS 3.0引入了External Accessory框架（ExternalAccessory.framework），通过它来支持iOS设备与绑定附件通信。附件可以通过一个30针的基座接口和设备相连，也可通过蓝牙连接。通过External Accessory框架，您可以获得每个外设的信息并初始化一个通讯会话。通讯会话初始化完成之后，您可以使用设备支持的命令直接对其进行操作。
 
 
 Security 框架
 iOS系统不但提供内建的安全功能，还提供Security框架（Security.framework）用于保证应用程序所管理之数据的安全。该框架提供的接口可用于管理证书、公钥、私钥以及信任策略。它支持生成加密的安全伪随机数。同时，它也支持对证书和Keychain密钥进行保存，是用户敏感数据的安全仓库。
 
 CommonCrypto接口另外还支持对称加密、HMAC以及Digests。实际上，Digests的功能实和OpenSSL库常用的功能兼容，但是iOS无法使用OpenSSL库。
 
 在 iOS 3.0及其后续版本的系统中， 您可以让所创建的多个应用程序共享某些Keychain项，这样可以让相同套件内的应用程序的互用更流畅。举个例子，您可以在应用程序间共享用户密码和及其他元素。通过这种方法，您就不需要在每个应用程序单独对用户作出提示。如应用程序需要共享数据，则每个应用程序的Xcode工程必须配备恰当的资格。
 

 
 System
 系统层包括内核环境、驱动及操作系统底层UNIX 接口。内核以Mach为基础，它负责操作系统的各个方面，包括管理系统的虚拟内存、线程、文件系统、网络以及进程间通讯。这一层包含的驱动是系统硬件和系统框架的接口。出于安全方面的考虑，内核和驱动只允许少数系统框架和应用程序访问。
 
 应用程序可以使用iOS提供的LibSystem库访问多种操作系统底层功能。LibSystem库的接口基于C语言，可为下述功能提供支持：
 
 线程 (POSIX 线程)
 网络 (BSD sockets)
 文件系统访问
 标准 I/O
 Bonjour和 DNS服务
 区域信息
 内存分配
 数学计算
 
 */

/*
 1.AudioToolbox概述 //AudioToolbox播放短音效
 
 通过AudioToolbox框架，可以将短声音注册到system sound服务上，被注册到system sound服务上的声音称之为 system sounds。它必须满足下面几个条件。
 (1).播放的时间不能超过30秒
 (2).数据必须是 PCM或者IMA4流格式
 (3).必须被打包成下面三个格式之一：Core Audio Format (.caf), Waveform audio (.wav), 或者 Audio Interchange File (.aiff) 声音文件必须放到设备的本地文件夹下面。通过AudioServicesCreateSystemSoundID方法注册这个声音文件.
 (4).简单音频不能从内存播放，而只能是磁盘文件
 */
 #pragma mark - AudioFile
 
 
 //    AudioFile类一个c编程接口，使用AudioFile可以从内存或硬盘中读取或写入多种格式的音频数据。
 
 
 //    AudioStreamBasicDescription inFormat;
 //    struct OpaqueAudioFileID	*AudioFileID;
 //inFileRef是目地路径
 //inFileType是创建音频文件的格式
 //inFormat中这个文件的更多详细的信息
 //inFlags 表示是创建还是打开文件（如果值为kAudioFileFlags_EraseFiles的话，将会移除一个已经存在的文件，然后重新创建；如果没有设置的话，如果url出已经有文件，就会返回失败 ），默认是：kAudioFileFlags_EraseFiles
 //outAudioFile是这个音频文件的句柄，唯一标识这个音频文件或者音频流。
 //   OSStatus isErr = AudioFileCreateWithURL((__bridge CFURLRef _Nonnull)([[NSBundle mainBundle] pathForResource:@"xx" ofType:@"wav"]), kAudioFileWAVEType, &inFormat, kAudioFileFlags_EraseFile, &AudioFileID);
 
 
 
 // 删除一个已经存在的文件的内容，并且对这个音频文件对象设置一系列的回调。
 //    参数详情：
 //    inClientData：回调函数所需要的数据，应该包含回调函数所有想要知道的内容。
 //    下面分别是:读回调，写回调、获取文件大小的回调。
 //    inFileType:音频文件被初始化的格式。
 //    inFileType:这个文件中的音频文件的格式。
 //    inFlags:是创建还是打开一个文件，通常设置为0.
 //    outAudioFile:指向刚刚被初始化的文件的句柄。
 //     NSData * data = [[NSData alloc]init];
 //     AudioFileInitializeWithCallbacks(data, <#AudioFile_ReadProc  _Nonnull inReadFunc#>, <#AudioFile_WriteProc  _Nonnull inWriteFunc#>, <#AudioFile_GetSizeProc  _Nonnull inGetSizeFunc#>, <#AudioFile_SetSizeProc  _Nonnull inSetSizeFunc#>, <#AudioFileTypeID inFileType#>, <#const AudioStreamBasicDescription * _Nonnull inFormat#>, <#AudioFileFlags inFlags#>, <#AudioFileID  _Nullable * _Nonnull outAudioFile#>)
 
 // 打开url所指定的一个已经存在的音频文件。
 //inFileRef:已经存在的音频文件的路径。
 //inPermissions:音频文件的读写属性，分为只读、只写、读写三种。
 //inFileTypeHint:从英文字面理解，hint有暗示、提示、线索的意思，这里指的是一些指定类型的音频文件的隐含的文件类型，特别是一些文件类型不容易判断的类型（如ADT或者AC3）。
 //    outAudioFile：只想这个新打开的文件句柄的指针。
 //    AudioFileOpenURL(<#CFURLRef  _Nonnull inFileRef#>, <#AudioFilePermissions inPermissions#>, <#AudioFileTypeID inFileTypeHint#>, <#AudioFileID  _Nullable * _Nonnull outAudioFile#>)
 
 
 //    AudioFileOpenWithCallbacks:,AudioFileClose---读(Read)、写(Write)音频文件。---优化(Optimize)音频文件。---和用户自己的数据和全局信息一起工作(Work with user data and golobal information)。
 
 //获取音频文件的属性。
 //    AudioFileGetProperty(文件操作句柄。（通常，用户是在调用：AuidioFileOpenURL之后获得的）, 用户想要获取的属性类别，比如：kAudioFilePropertyDataFormat（音频的数据格式），它的类型，决定了后面参数的解析方式, 。需要使用AudioFileGetPropertyInfo函数来获取该属性的值, 想要获取的对应于 inPropertyID属性所指定的结果的值)
 
 // 获取音频文件属性的信息，包括音频文件属性的大小以及这个属性只是否可写。
 //inAudioFile:想要获取属性值信息的文件id。
 //inPropertyID:想要获取的属性类型ID。
 //outDataSize:属性值的字节数。
 //isWritable:如果值为1，则属性值可写；如果值为1，则属性值只可读。
 //    AudioFileGetPropertyInfo(<#AudioFileID  _Nonnull inAudioFile#>, <#AudioFilePropertyID inPropertyID#>, <#UInt32 * _Nullable outDataSize#>, <#UInt32 * _Nullable isWritable#>)
 
 //
 //    3,AudioFileSetProperty
 //
 //    函数功能：设置音频文件的属性。（在对音频文件进行改变的时候，通常会用到）
 //
 //    函数原型：
 //
 //    OSStatus AudioFileSetProperty (
 //                                   AudioFileID         inAudioFile,
 //                                   AudioFilePropertyID inPropertyID,
 //                                   UInt32              inDataSize,
 //                                   const void          *inPropertyData
 //                                   );
 //    参数解析：
 //
 //inAudioFile:想要被设置属性的文件id。
 //
 //inPropertyID:想要设置的某个属性的ID。
 //
 //inDataSize:正在传入的 inPropertyData的属性值的大小。
 //
 //inPropertyData:新的属性值。
 
 
 
 #pragma mark - AudioServices
 
 /*
 //     AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//震动
        AudioServicesPlaySystemSound(1020);//系统声音
 //   我们要播放一个自定义的警告音或者消息提示，用音频服务肯定比其他的方法节省资源。
 SystemSoundID soundID;
 NSString *musicFilePath = [[NSBundle mainBundle] pathForResource:@"xx" ofType:@"wav"];
 NSURL *sample = [NSURL fileURLWithPath:musicFilePath];
 OSStatus err = AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(sample), &soundID);
 if (err) {
 NSLog(@"Error occurred assigning system sound!%@",sample);
 }else{
 //添加音频结束时的回调
 AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, SoundFinished,(__bridge void * _Nullable)(sample));
 AudioServicesPlaySystemSound(soundID);
 }
 */
#pragma mark - AudioFileStream
/*
 //AudioFileStream介绍,是用来读取采样率、码率、时长等基本信息以及分离音频帧。用在流播放中，当然不仅限于网络流，本地文件同样可以用它来读取信息和分离音频帧
 
 //初始化AudioFileStream，创建一个音频流解析器，生成一个AudioFileStream示例。
 //inClientData 上下文对象
 //AudioFileStream_PropertyListenerProc 歌曲信息解析的回调，每次解析出一个歌曲信息，都会执行一次回调。
 //AudioFileStream_PacketsProc 分离帧的回调，每解析出一部分帧就会进行一次回调
 AudioFileStream_PropertyListenerProc inPropertyListenerProc;
 AudioFileStream_PacketsProc inPacketsProc;
 AudioFileStreamID outAudioFileStream;
 OSStatus s = AudioFileStreamOpen((__bridge void * _Nullable)(self), inPropertyListenerProc, inPacketsProc, kAudioFileMP3Type, &outAudioFileStream);
 if (s == noErr) {
 NSLog(@"noErr");
 }else{
 NSLog(@"Err");
 }
 //aquire some data
 
 //  解析数据，在初始化完成之后，调用该方法解析文件数据。
 // inAudioFileStream 初始化成功后返回的 AudioFileStreamID
 // inDataByteSize 本次解析的文件长度
 // inData 本次解析的数据
 // inFlags 标志位，标识本次的解析和上一次解析是否是连续的关系，默认0表示连续，否则传入kAudioFileStreamParseFlag_Discontinuity。
 NSData * data = [[NSData alloc]init];
 
 AudioFileStreamParseBytes(outAudioFileStream, (int)data.length, (__bridge const void * _Nonnull)(data), 0);
 
 //inClientData 得到上下文
 //inAudioFileStream 表示当前的FileStream的AudioFileStreamID
 //inPropertyID 表示此次回调解析的AudioFileStreamPropertyID，
 //    AudioFileStream_PropertyListenerProc
 //    解析文件格式信息的回调，在调用AudioFileStreamParseBytes方法进行解析时会首先读取格式信息，并同步的进入AudioFileStream_PropertyListenerProc回调方法。
 //    //设置从流文件中读取data时的offset
 //    AudioFileStreamSeek(<#AudioFileStreamID inAudioFileStream#>, <#SInt64 inPacketOffset#>, <#SInt64 *outDataByteOffset#>, <#UInt32 *ioFlags#>);
 //
 //    //获取完数据后，关闭该流对象
 //
 //    AudioFileClose(<#AudioFileID inAudioFile#>)
 //http://www.jianshu.com/p/09cc9345c74c
 */


#pragma mark - AudioServices
 

 /*
   AudioQueue
 使用一个缓冲队列来存储data，用来播放或录音。播放或录音的时候，数据以流的形式操作，可以边获取数据变播放，或者边录音，边存储。
 
 -------------------------------------------------------------------------
 
 NSFileHandle 用来从文件、socket中读取数据
 
 CFReadStream 用来读取一个字节流byte stream，该字节流可以来自于内存、一个文件、一个socket。在读bytes之前，流stream需要被打开。
 
 CFWriteStream用来写一个字节流
 
 AudioQueueRef  定义的一个不透明的数据类型，专门用来代表一个audio queue
 
 AudioQueueBufferRef 是AudioQueueBuffer的别名，表明该参数为一个AudioQueueBuffer对象
 
 AudioFileID 定义一个不透明的数据类型，代表一个audiofile的对象
 
 反思：以ref结尾的对象名称，一般是在参数中使用，表明这个参数的数据类型
 */

/*
 AudioStreamBasicDescription
 
 音频数据流格式的描述.Callback Method 回调函数，系统规定好了回调函数的参数，以及调用的地方，你只需要保证参数的格式正确，向函数里添加代码即可，函数的方法名称可以随便写，没有强制的规定。
 
 AudioQueueNewOutput的第三个参数：inUserData 这是由用户来自定义的，数据的来源。只需要传递一个对象进去即可。使用，当系统自动调用回调函数MyAudioQueueOutputCallback或者MyAudioQueueInputCallback时候，返回的第一个参数inUserData就是你在AudioQueueNewOutput中设置的第三个参数。然后，你需要在回调函数中使用这个对象填充buffer(播放音频，当一个buffer为空时自动调用)或者读取buffer的数据(录音，当一个buffer满时自动调用)。
 
 
 
 AudioFileStream_PropertyListenerProc
 
 当在audio stream中找到一个property value后，回调该方法。
 
 AudioFileStream_PacketsProc当在stream中找到audio data后回调该方法。
 
 
 
 在参数中的in和out个代表的意思：in代表的是这个参数需要你在外面得到然后传递进去，在这个方法中要使用；out开头的参数表示这个参数是这个方法返回的值，你一般只需要定义一个引用，然后传递进去，执行完这个方法后，这个参数就实例化了。oh，my god！坑爹的苹果。
 
 
 
 
 
 AudioFileStream类
 
 提供了一个借口，用来解析流音频文件。功能：从网络中读取数据流，把数据流解析成音频文件。
 
 音频文件流是不容易获取的。当需要从stream中读取data时，以前的data可能已无法使用，而新的data还没有到达，而从网络中获取的data可能还包含packets数据。为了解析audio stream，parser必须记着已经获取的数据，等待剩余的数据。


 
 //====下载=====
 
 CFReadStream
 
 CFReadStreamClientCallBack回调函数在CFReadStreamSetClient中调用，是第三个参数。CFReadStreamClientCallBack只有在满足CFReadStreamSetClient中添加的streamEvents发生时才会别回调。
 
 CFReadStreamScheduleWithRunLoop方法把stream加到一个线程中。然后，CFReadStreamSetClient在设置的东西就起作用了。当各种streamEvent发生时，client都会得到通知，client判断是否执行回调方法CFReadStreamClientCallBack。
 
 
 
 AudioSession类
 
 一个c接口，用来管理应用中audio的行为。
 
 线程的操作，暂停后可能是县城就停止了。
 
 对线程的操作  让某一个线程停下来。
 
 
 
 
 
 AudioQueue
 
 一个c编程接口，是Core Audio的一部分。功能：录音、播放音频。
 
 AudioQueue类播放音频时，在内存中维护着一个buffer queue。只要buffer中有数据就可以播放，因此，一般使用AudioQueue对象来播放音频流，这样可以“边下载边播放”。
 
 audioqueue中的方法都是静态方法，使用时传递进去的参数前缀是in，传递出来的参数前缀是out播放音频的方法：
 
 AudioQueueNewOutput
 
 1、用来创建一个播放音频队列的对象AudioQueueRef，然后就是对该audioqueue对象进行操作。
 
 2、用来添加一个回调方法AudioQueueOutputCallback，调用该方法时会返回一个audioqueue的buffer，该buffer中的数据已经被使用，需要在这个方法中填充新数据。
 
 3、AudioQueueEnqueueBuffer
 
 想缓冲区中添加新的数据（数据一般从file或网络中获取）
 
 
 AudioQueueAllocateBuffer
 
 为一个audioqueue分配一个queueBuffer，每调用一次创建一个缓冲区，最后所有的缓冲区组成一个缓冲队列。
 
 AudioQueueCreateTimeline
 
 创建一个与audioqueue相关的时间轴。如果想要显示audio的时间，需要熟悉uyutimeLine相关的方法。
 
 
 audioqueue的属性操作：
 
 具体属性类型见官方文档：https://developer.apple.com/library/ios/#documentation/MusicAudio/Reference/AudioQueueReference/Reference/reference.html#//apple_ref/c/func/AudioQueueAddPropertyListener
 
 AudioQueueSetProperty
 
 用来设置某一个audioqueue对象的属性，具体属性以 kAudioQueueProperty_*开头
 
 AudioQueueGetProperty
 
 获取audioqueue对象的某一个属性值。首先应该先调用AudioQueueGetPropertySize方法获取value的大小(byte形式)
 
 AudioQueueAddPropertyListener
 
 添加一个属性监听器。当一个audioqueue的对应属性值改变时，会回调这个监听器。
 
 
 
 audioqueue的参数操作：
 
 AudioQueueSetParameter
 
 AudioQueueGetParameter
 
 对参数的修改和获取，具体参数parameter包括：音量的调节、声道的调节、以及音量的渐变设置
 
 
 http://blog.csdn.net/lvmaker/article/details/8152810
 */




