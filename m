From: Andre Prendel <andre.prendel@gmx.de>
Date: Wed, 13 Jan 2010 20:56:50 +0000
Subject: [lm-sensors] [PATCH RFC 1/1] Add the sensors-config tool
Message-Id: <20100113205650.GB1856@andre-laptop>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This tool helps you to configure lm-sensors. Some of the features are:

* Download configs from lm-sensors.org and build an archive
* Install archives into file system
* List all the available configs
* Install configs by vendor and board name or automatically based on DMI data
* Show DMI data

---
 prog/detect/sensors-config.py |  237 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 237 insertions(+)

Index: prog/detect/sensors-config.py
=================================--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ prog/detect/sensors-config.py	2010-01-13 20:32:29.673177231 +0100
@@ -0,0 +1,237 @@
+#!/usr/bin/python
+
+import os
+import sys
+import optparse
+import urllib
+import re
+
+config_dir = '/usr/local/share/sensors/conf'
+config_install_dir = '/etc/sensors.d'
+dmi_dir = '/sys/class/dmi/id'
+config_url="http://www.lm-sensors.org/wiki/Configurations"
+
+configs = {
+    'ASRock' : ['AM2NF3-VSTA'],
+    'Abit' : ['AA8-DuraMAX', 'AA8XE-Fatal1ty', 'AI7', 'AN7',
+              'AN8-SLI', 'AV8', 'AX8', 'Aa7-Max', 'Ag7', 'KN9-Ultra',
+              'KV8-MAX3', 'Kv8Pro', 'VA-20'],
+    'Asus' : ['KFN4-DRE', 'M2N-SLI Deluxe'],
+    'DFI' : ['CFX3200-M2-G-infinity', 'Lanparty NF4 Expert',
+             'Lanparty UT 790FX'],
+    'Epox' : ['M1697', 'MF4-Ultra3'],
+    'Evga' : ['x58-SLI'],
+}
+
+def get_vendor_list():
+    try:
+        dir = os.listdir(config_dir)
+        dir.sort()
+        return dir
+
+    except OSError:
+        print "Could not find configurations in " + config_dir
+        dir = []
+        return dir
+
+
+def list_vendors():
+    dir = get_vendor_list()
+    for name in dir:
+        print name
+
+
+def get_board_list(vendor):
+    try:
+        dir = os.listdir(config_dir + '/' + vendor)
+        dir.sort()
+
+        return dir
+
+    except:
+        print "Could not find a configuration for " + vendor
+        dir = []
+        return dir
+
+
+def list_boards(vendor):
+    dir = get_board_list(vendor)
+    for name in dir:
+        print name
+
+
+def clear_config_dir():
+    try:
+        dir = os.listdir(config_install_dir)
+        for name in dir:
+            os.remove(config_install_dir  + '/' + name)
+
+    except OSError:
+        return
+
+
+def install(config):
+    sys.stdout.write('This will delete older configurations. Do you want to proceed? [y/N]: ')
+    line = sys.stdin.readline()
+    if (line[0] = 'N' or line[0] = 'n' or line[0] = '\n'):
+        return
+
+    clear_config_dir()
+
+    src = config_dir + '/' + config
+    dst = '/etc/sensors.d'
+    os.system('cp %s %s' % (config_dir + '/' + config, '/etc/sensors.d'));
+
+
+def get_dmi_data():
+    dmi = {'sys_vendor': '',
+           'product_name': '',
+           'product_version': '',
+           'board_vendor': '',
+           'board_name': '',
+           'board_version': '',
+           'chassis_type': ''}
+
+    for key in dmi:
+        f = open(dmi_dir + '/' + key, 'r')
+        dmi[key] = f.read().rstrip('\n')
+        f.close()
+
+    return dmi
+
+
+def show_dmi():
+    dmi = get_dmi_data()
+    keys = dmi.keys()
+    keys.sort()
+    for key in keys:
+        print key + ': ' + dmi[key]
+
+
+def install_archive(archive):
+    if (os.path.exists(config_dir) = False):
+        os.makedirs(config_dir)
+    os.system("tar -xzf" + archive + " -C" + config_dir)
+
+
+def uninstall_archive():
+    if (os.path.exists(config_dir) = True):
+        os.system("rm -rf " + config_dir)
+
+
+def find_board(dmi, dir):
+    for name in dir:
+        if (dmi['board_name'].lower().find(name.lower()) != -1):
+            return name
+
+    return ''
+
+
+def find_vendor(vendor, board):
+    dmi = get_dmi_data()
+
+    if (vendor):
+        dmi['board_vendor'] = vendor
+
+    if (board):
+        dmi['board_name'] = board
+
+    dir = get_vendor_list()
+    board_dir = ''
+    for name in dir:
+        if (dmi['board_vendor'].lower().lower().find(name.lower()) != -1):
+            board_dir = get_board_list(name)
+            board = find_board(dmi, board_dir)
+            if (board != ''):
+                config = name + '/' + board
+                print 'Found a suitable configuration: ' + config
+                sys.stdout.write('Do you want to install this configuration? [y/N]: ')
+                line = sys.stdin.readline()
+                if (line[0] = 'Y' or line[0] = 'y'):
+                    install(config);
+
+
+def fetch_configs():
+    for key in configs:
+        os.mkdir(key)
+        boards = configs[key]
+        for board in boards:
+            print 'Fetch config for ' + key + '/' + board
+            url = urllib.urlopen(config_url + '/' + key + '/' + board +
+                                 '?format=txt')
+
+            data = url.read()
+            start = data.find('{{{')
+            start = data.find('\n', start)
+            end = data.find('}}}')
+            data = data[start + 1:end]
+            url.close()
+
+            f = open(key + '/' + board, 'w')
+            f.write(data)
+            f.close()
+
+    os.system('tar czf configuration.tar.gz *')
+
+
+def parse_cmdline():
+    parser = optparse.OptionParser()
+    parser.add_option('-l', '--list-vendors', dest='opt_list_vendors',
+                      action='store_true', help='lists all the vendors');
+    parser.add_option('-b', '--list-boards', dest='opt_list_boards',
+                      help='lists the boards for a given vendor')
+    parser.add_option('-i', '--install', dest='opt_install',
+                      help='installs the given configuration')
+    parser.add_option('-d', '--show-dmi', dest='opt_show_dmi',
+                      action='store_true', help='shows DMI data')
+    parser.add_option('-a', '--install-archive', dest='opt_install_archive',
+                      help='installs the given archive')
+    parser.add_option('-u', '--uninstall-archive',
+                      dest='opt_uninstall_archive', action='store_true',
+                      help='removes configurations from archive')
+    parser.add_option('-f', '--find-board', dest='opt_find_board',
+                      action='store_true',
+                      help='find a configuration based on DMI data')
+    parser.add_option('-B', '--dmi-board', dest='opt_dmi_board',
+                      help='overwrites DMI data for board')
+    parser.add_option('-V', '--dmi-vendor', dest='opt_dmi_vendor',
+                      help='overwrites DMI data for vendor')
+    parser.add_option('-t', '--fetch-configs', dest='opt_fetch_configs',
+                      action='store_true',
+                      help='fetches configurations from lm-sensors.org')
+
+    return parser.parse_args()
+
+
+# Main
+try:
+    (options, args) = parse_cmdline()
+
+    if (options.opt_list_vendors):
+        list_vendors()
+
+    if (options.opt_list_boards):
+        list_boards(options.opt_list_boards)
+
+    if (options.opt_install):
+        install(options.opt_install)
+
+    if (options.opt_show_dmi):
+        show_dmi()
+
+    if (options.opt_install_archive):
+        install_archive(options.opt_install_archive)
+
+    if (options.opt_uninstall_archive):
+        uninstall_archive()
+
+    if (options.opt_find_board):
+        find_vendor(options.opt_dmi_vendor, options.opt_dmi_board)
+
+    if (options.opt_fetch_configs):
+        fetch_configs()
+
+except (OSError), e:
+    print e
+
+sys.exit(0)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
