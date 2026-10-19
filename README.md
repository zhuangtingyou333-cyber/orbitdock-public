# OrbitDock · Selected Source

**OrbitDock 商业产品的部分源码展示。** 这里是从个人项目中选出的通用 Swift 模块，
配套独立构建、演示与测试，用于说明代码组织、参数校验和状态处理方法。
本项目使用 Codex 辅助开发；此仓库不是完整 OrbitDock 应用或可重建它的源码发行版。

## 已公开的模块

| 模块 | 展示内容 |
|---|---|
| `ClockTimeZone` | IANA 时区、固定偏移、夏令时与严格输入校验 |
| `ClockAppearance` | 字重、颜色、有限数值与文字尺寸边界 |
| `ClockZoneCaption` / `ClockBackground` | 时区文字及通用样式参数 |
| `BadgeTracker` | 不完整采样、基线、增量提醒与状态清理 |

这些文件从原项目中明确选取；测试从对应回归用例中抽出并改为独立检查程序。
没有用空实现替代隐藏核心，也不需要完整商业仓库才能运行这里的测试。

## 构建、测试与演示

需要 Swift 6.0+ 与 macOS 13+；没有第三方包依赖，没有 API 密钥或后台服务。

```sh
swift build
swift run orbitdock-utilities-checks
swift run orbitdock-utilities-demo
```

演示使用固定日期和合成应用路径，不读取真实 Dock、文件列表或用户配置。
验证结果见 [VALIDATION.md](VALIDATION.md)。

## 商业源码边界

完整界面、多屏布局与吸附、窗口控制、交互渲染、文件管理与恢复、
商业集成、收费/授权相关实现及产品发布资源保留在私有项目中。
本仓库不包含这些源码、原项目 Git 历史、本机配置、签名资料或应用安装包。

本仓库中的公开展示不代表完整 OrbitDock 的功能、性能或实机验收结论。
原创代码的权利保留及 AI 辅助说明见 [NOTICE.md](NOTICE.md)。
