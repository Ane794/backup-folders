"""根据文件读取元目录 URL 和备份目录 URL 的映射关系并生成 .bat 脚本."""

import configparser

_BAT_URL: str = 'backup.bat'
_ROOT_INFO_URL: str = r'conf\root.cfg'
_DIRS_MAP_URL: str = r'conf\dirs.cfg'

_MODE_STR: str = 'MODE'
_SRC_ROOT_STR: str = 'SRC_ROOT'
_DEST_ROOT_STR: str = 'DEST_ROOT'

_ENCODING = 'UTF-8'

_ROBOCOPY_ARGS: str = '/mir /unicode'

if __name__ == '__main__':
    with open(_BAT_URL, 'w', encoding=_ENCODING) as bat_file:
        bat_file.write('@echo off\n')

        conf = configparser.ConfigParser()
        conf.read(_ROOT_INFO_URL, _ENCODING)
        enabled = conf.get('mode', 'ENABLED') == 'True'
        if enabled:
            src_root = conf.get('roots', _SRC_ROOT_STR)
            dest_root = conf.get('roots', _DEST_ROOT_STR)
            bat_file.write('set ' + _SRC_ROOT_STR + '=' + src_root + '\n')
            bat_file.write('set ' + _DEST_ROOT_STR + '=' + dest_root + '\n')

        conf = configparser.ConfigParser()
        conf.read(_DIRS_MAP_URL, _ENCODING)
        dirs = conf.items('dirs')
        for item in dirs:
            if enabled:
                cmd = 'robocopy' \
                      + ' "%' + _SRC_ROOT_STR + '%\\' + item[0].replace('"', '') + '"' \
                      + ' "%' + _DEST_ROOT_STR + '%\\' + item[1].replace('"', '') + '"' \
                      + ' ' + _ROBOCOPY_ARGS
            else:
                cmd = 'robocopy' \
                      + ' "' + item[0].replace('"', '') + '"' \
                      + ' "' + item[1].replace('"', '') + '"' \
                      + ' ' + _ROBOCOPY_ARGS

            bat_file.write(cmd + '\n')
            exit(0)
