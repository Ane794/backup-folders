# 更新日志

## 1.0.1 - 2021-03-10

### 修复

* 修复 *[start.bat](start.bat)* 在用户取消备份后未删除备份脚本的问题。
* 修复 *[simplify-log.py](simplify-log.py)* 无法完全删除复制进度的问题。

### 优化

* *[start.bat](start.bat)* 和 *[simplify-log.py](simplify-log.py)* 直接执行具体内容，不再定义成函数执行。