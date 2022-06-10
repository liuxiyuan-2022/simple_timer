# Simple Timer

> Flutter SDK : 2.6.0-11.0

🕜基于Flutter的计时器App



## 代码结构

```
simple_timer
├──	android
├──	assets	// 资产文件夹: 存放fonts, icons, imgs, audios
├──	ios
├──	lib
├──	test
├──	web
```

`lib`文件夹下的目录: 

```
lib
├──	common
├──	controller
├──	l10n
├──	pages
├──	style
├──	wwidgets
```

|   文件夹   |                  用处                   |
| :--------: | :-------------------------------------: |
|   common   |           存放一些通用方法类            |
| controller |               GetX控制器                |
|    l10n    |              国际化翻译类               |
|   pages    |          存放所有的路由页面类           |
|   style    |               APP样式主题               |
|  widgets   | APP内封装的一些Widget组件都在该文件夹下 |
|            |                                         |



## 第三方依赖包

- 运行`flutter pub get` 添加依赖包

|          名称           |         备注          |
| :---------------------: | :-------------------: |
|           get           |       状态管理        |
|      numberpicker       |      时间选择器       |
|  animated_flip_counter  |       文本动画        |
|  font_awesome_flutter   |        图标库         |
|    stop_watch_timer     |        计时器         |
| flutter_ringtone_player |       音频播放        |
|   shared_perferences    |    本地持久化存储     |
|  smooth_page_indicator  |      页面指示器       |
| flutter_launcher_icons  | 生成 ios/android 图标 |
|   dot_navigation_bar    |      底部导航栏       |



## 更新日志

> <font color=#70c000>新增</font>	<font color=#dbc693>修复</font>	<font color=##a1c6c9>优化</font>

---

2022.6.7

- <font color=##a1c6c9>优化</font>  计时器预设列表动画

2022.6.5

- <font color=#dbc693>修复</font>  计时器预设列表初始化Bug
- <font color=#70c000>新增</font>  计时器预设 '增删改' 功能

2022.6.4

- <font color=#70c000>新增</font>  计时器偏好列表

2022.6.3

- <font color=#70c000>新增</font>  默认铃声选择功能
- <font color=##a1c6c9>优化</font>  BottomSheet代码

2022.6.2

- <font color=#70c000>新增</font>  单圈计时列表动画
- <font color=#dbc693>修复</font>  计时结束通知框无法点击关闭的Bug
- <font color=##a1c6c9>优化</font>  UI改进

2022.6.1

- <font color=#dbc693>修复</font>  秒表重置Bug
- <font color=#dbc693>修复</font>  秒表毫秒值刷新过快

2022.5.31

- <font color=#70c000>新增</font>  秒表单圈计时
- <font color=##a1c6c9>优化</font>  UI改进

2022.5.30

- <font color=#70c000>新增</font>  秒表功能
- <font color=#70c000>新增</font>  国际化功能
- <font color=#70c000>新增</font>  夜间模式

2022.5.29

- <font color=#70c000>新增</font>  倒计时通知
- <font color=##a1c6c9>优化</font>  UI改进
- <font color=#70c000>新增</font>  导航栏滑动切换页面功能

2022.5.28

- <font color=#70c000>新增</font>  浮动导航栏 
- <font color=#dbc693>修复</font>  计时器出现hour的时间累加到minute上的Bug

