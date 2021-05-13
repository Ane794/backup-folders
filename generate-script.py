"""根据文件读取元目录 URL 和备份目录 URL 的映射关系并生成 .bat 脚本."""

from ruamel.yaml import YAML

_BAT_URL = 'backup.bat'
_BAT_ENCODING = 'GBK'

_CONF_URL = r'conf\config.yml'
_CONF_ENCODING = 'UTF-16'

_LOG_URL = r'log\backup.log'

_ROBOCOPY_ARGS: str = '/mir /unicode /tee /unilog+:"%s"' % _LOG_URL

if __name__ == '__main__':
    with open(_BAT_URL, 'w', encoding=_BAT_ENCODING) as bat_file, open(_CONF_URL, 'r',
                                                                       encoding=_CONF_ENCODING) as conf_file:
        bat_file.write('@echo off\n')

        conf = YAML().load(conf_file)
        for group in conf:
            for item in group['dirs']:
                cmd = ('robocopy "%s" "%s" %s' % (group['root']['src'] + '\\' + item['src'],
                                                  group['root']['dest'] + '\\' + item['dest'],
                                                  _ROBOCOPY_ARGS)).replace('\\\\', '\\').replace('"\\', '"')
                bat_file.write(cmd + '\n')

        exit(0)
