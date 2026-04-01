Travel Record for macOS ✈️🚄
 | 

<a name="english"></a>

English
Travel Record is a professional travel log management tool specifically designed for macOS. Developed by aviation enthusiasts, it turns your digital records into a professional "Flight Logbook" experience. Powered by Apple's latest SwiftData framework, it helps you track every flight and train journey with intelligent, time-based archiving.

🌟 Key Features

Smart Trip Classification:

Upcoming: Real-time monitoring. Trips automatically move to history the moment the departure time passes.

History: A chronological archive of all your past travel memories.

Professional Flight System: Designed by aviation fans to mimic a professional flight manual. It’s open-source, lightweight, and focused on the details that matter to frequent flyers.

Deep Railway Integration: Optimized for different national railway logics (e.g., China Railway seat classes like Business, First Class, and Sleepers). Supports cascading selectors for Operators and Seat Types.

Native macOS Experience: Built with SwiftUI to fit perfectly with the macOS aesthetic. Supports standard inputs, date pickers, and window behaviors.

Data Privacy: All data is stored locally via SwiftData. No internet required, ensuring your travel history stays private.

🛠️ Technical Implementation

Framework: SwiftUI (Targeting macOS 14.0+)

Persistence: SwiftData (Apple's next-gen data modeling).

Auto-Refresh: Driven by Combine timers to ensure the UI stays accurate as time progresses without manual reloading.

Clean Formatting: Optimized flight number inputs (e.g., "8703" instead of "8,703") to match industry standards.

🚀 Getting Started

Requirements: macOS 14.0+, Xcode 15.0+.

Installation:

Clone the repo: git clone https://github.com/yourusername/TravelRecord.git

Open TravelRecord.xcodeproj in Xcode.

Press Cmd + R to Build and Run.

<a name="chinese"></a>

中文
Travel Record 是一款专为 macOS 设计的个人旅行足迹管理工具。由专业飞友制作，致力于将数字记录打造为“专业飞行手册”般的体验。利用 Apple 最新的 SwiftData 技术，它可以帮助你记录每一次飞行和铁路旅程，并能根据时间自动归档行程。

🌟 核心功能

智能行程分类：

即将到来 (Upcoming)：实时监控时间，一旦起飞/出发时间点已过，行程将自动移入历史记录。

历史足迹 (History)：按照时间倒序排列你所有的旅行回忆。

详尽飞行系统：由飞友为飞友制作，界面风格参考专业飞行手册。免费开源，纯净便携。

深耕铁路系统：特别针对不同国家的铁路逻辑进行优化（如中国铁路的席别：商务座、一等座、二等卧等）。支持运营商与席位的级联选择。

原生 macOS 体验：采用 SwiftUI 开发，完美契合 macOS 系统视觉风格，支持标准表单输入与日期选择器。

数据安全：所有数据通过 SwiftData 存储在本地，无需联网，隐私完全由你掌控。

🛠️ 技术实现

框架: SwiftUI (支持 macOS 14.0+)

持久化: SwiftData

自动刷新: 使用 Combine 定时器驱动视图，确保行程状态在时间流逝时自动切换。

数字格式化: 针对航班号输入进行优化，去除了千分位逗号干扰（例如输入 8703 不会变为 8,703），符合行业习惯。

🚀 安装与运行

环境要求: macOS 14.0 或更高版本, Xcode 15.0 或更高版本。

运行步骤:

克隆仓库: git clone https://github.com/你的用户名/TravelRecord.git

使用 Xcode 打开 TravelRecord.xcodeproj。

按下 Cmd + R 编译并运行。

📄 License / 许可证
This project is licensed under the .
本项目基于 MIT 许可证开源。
