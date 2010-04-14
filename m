From: Andre Prendel <andre.prendel@gmx.de>
Date: Wed, 14 Apr 2010 18:28:40 +0000
Subject: [lm-sensors] [PATCH v4 1/2] Add sensors config fetching tool
Message-Id: <20100414182840.GB1985@andre-laptop>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use this tool to:

* Fetch config files from lm-sensors.org
* Build an tarball containing the configs
* Install/Deinstall config archives
* Manually install config files to /etc/sensors.d/
* List available configs

---
Index: prog/detect/sensors-config.py
=================================--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ prog/detect/sensors-config.py	2010-04-14 20:11:35.130562450 +0200
@@ -0,0 +1,225 @@
+#!/usr/bin/python
+
+import os
+import sys
+import optparse
+import urllib
+import re
+
+config_dir = '/var/lib/sensors/conf'
+config_install_dir = '/etc/sensors.d'
+dmi_dir = '/sys/class/dmi/id'
+sensors_url = 'http://www.lm-sensors.org'
+#sensors_url = 'http://localhost'
+wiki_url = sensors_url + '/' + 'wiki'
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
+        if os.path.isdir(config_dir + '/' + name):
+            print name
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
+def install(src):
+    sys.stdout.write('This will delete older configurations. Do you want to proceed? [y/N]: ')
+    line = sys.stdin.readline()
+    if (line[0] = 'N' or line[0] = 'n' or line[0] = '\n'):
+        return
+
+    clear_config_dir()
+
+    os.system('cp %s %s' % (config_dir + '/' + src, '/etc/sensors.d/' +
+                            src.split('/')[1]));
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
+def get_config_names():
+    configs = []
+    url_vendors = urllib.urlopen(wiki_url + '/Configurations/Configurations')
+    data = url_vendors.read()
+    it  = re.finditer(r"<a href=\"/wiki/Configurations/.*?\">(.*?)</a>", data)
+    for m in it:
+        url_boards = urllib.urlopen(wiki_url + '/' + m.group(1))
+        board_data = url_boards.read()
+        board_it  = re.finditer(r"<a href=\"/wiki/Configurations/.*?\">(Configurations/.*?)</a>", board_data)
+        for boards_m in board_it:
+            configs.append(boards_m.group(1))
+
+    return configs
+
+
+def parse_dmi(lines):
+    boards = []
+    board = {}
+    block_started = False
+
+    for line in lines:
+        if line[0] = '#':
+            if line.find('board_vendor') != -1 or line.find('sys_vendor') != -1:
+                block_started = True
+                board = {}
+                board['vendor'] = line.split(':')[1].strip()
+
+            elif line.find('board_name') != -1 or line.find('product_name') != -1:
+                board['name'] = line.split(':')[1].strip()
+
+            elif line.find('board_version') != -1 or line.find('product_version') != -1:
+                board['version'] = line.split(':')[1].strip()
+        else:
+            if block_started = True:
+                boards.append(board)
+                block_started = False
+
+    return boards
+
+
+def strip_lines(lines):
+    start = end = 0;
+    for i in range(len(lines)):
+        if (lines[i].find('{{{') != -1):
+            start = i + 1
+
+        if (lines[i].find('}}}') != -1):
+            end = i - start
+
+    del lines[0:start]
+    del lines[end:]
+
+
+def create_file(boards, lines):
+    orig_path = boards[0]['vendor'] + '/' + boards[0]['name']
+    if 'version' in boards[0]:
+        orig_path += '-' + boards[0]['version']
+
+    for board in boards:
+        strip_lines(lines)
+        if (os.path.exists(board['vendor']) = False):
+            os.mkdir(board['vendor'])
+
+        if (os.path.exists(orig_path) = False):
+            f = open(orig_path , 'w')
+            f.writelines(lines)
+            f.close()
+
+        link = board['vendor'] + '_' + board['name']
+        if 'version' in board:
+            link += '_' + board['version']
+        os.symlink(orig_path, link)
+
+
+def fetch_configs():
+    configs = get_config_names()
+
+    for board in configs:
+        print 'Fetch config for ' + board
+        url = urllib.urlopen(wiki_url + '/' + board + '?format=txt')
+
+        lines = url.readlines()
+        boards = parse_dmi(lines)
+        print boards
+        print '\n'
+
+        create_file(boards, lines);
+        url.close()
+
+    if len(os.listdir('.')) > 0:
+        os.system('tar czf configuration.tar.gz *')
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
+    parser.add_option('-a', '--install-archive', dest='opt_install_archive',
+                      help='installs the given archive')
+    parser.add_option('-u', '--uninstall-archive',
+                      dest='opt_uninstall_archive', action='store_true',
+                      help='removes configurations from archive')
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
+    if (options.opt_install_archive):
+        install_archive(options.opt_install_archive)
+
+    if (options.opt_uninstall_archive):
+        uninstall_archive()
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
