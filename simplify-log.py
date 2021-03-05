"""简化日志文件."""

_LOG_URL: str = 'log/backup.log'
_TMP_URL: str = _LOG_URL + '.tmp'


def _run():
    with open(_LOG_URL, 'r', errors='ignore') as log:
        with open(_TMP_URL, 'w') as tmp:
            for line in log:
                # 跳过复制进度.
                if line.startswith('100%') or line.endswith('%  \n'):
                    continue
                tmp.write(line)

    with open(_TMP_URL, 'r', errors='ignore') as tmp:
        with open(_LOG_URL, 'w') as log:
            for line in tmp:
                log.write(line)

    import os
    os.remove(_TMP_URL)


_run()
exit(0)
