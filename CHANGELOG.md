# 更新日志

## 2.0 - 2021-05-13

### 修改

* 修改了配置文件格式及读写方式，从 .cfg 文件改为 .yml 文件。

* 修改了备份过程输出倒屏幕的方式，使用 `robocopy` 命令的功能代替 Powershell 的 `tee`。

* 取消对用户不可见的 venv 环境的依赖。

## 1.1 - 2021-04-08

### 新增

* 新增将备份过程输出到屏幕的功能；此功能需要调用 PowerShell。

## 1.0 - 2021-03-13

### 修复

* 修复 *[start.bat](start.bat)* 在用户取消备份后未删除备份脚本的问题。
* 修复 *[simplify-log.py](simplify-log.py)* 无法完全删除复制进度的问题。
* 修复 *[simplify-log.py](simplify-log.py)* 生成备份脚本不完整的问题。

### 优化

* *[start.bat](start.bat)* 和 *[simplify-log.py](simplify-log.py)* 直接执行具体内容，不再定义成函数执行。