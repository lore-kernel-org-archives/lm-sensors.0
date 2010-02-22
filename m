From: Andre Prendel <andre.prendel@gmx.de>
Date: Mon, 22 Feb 2010 20:31:11 +0000
Subject: Re: [lm-sensors] [RFC PATCH v1 0/2] Add the sensors-config tool
Message-Id: <20100222203111.GB1937@andre-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100219193821.GA1917@andre-laptop>
In-Reply-To: <20100219193821.GA1917@andre-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add the sensors-config tool

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
+++ prog/detect/sensors-config.py	2010-02-22 20:11:42.495418369 +0100
@@ -0,0 +1,304 @@
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
+def install(src, dst = '', force = False):
+    if (force = False):
+        sys.stdout.write('This will delete older configurations. Do you want to proceed? [y/N]: ')
+        line = sys.stdin.readline()
+        if (line[0] = 'N' or line[0] = 'n' or line[0] = '\n'):
+            return
+
+    clear_config_dir()
+
+    if (dst = ''):
+        dst = src.split('/')[1]
+
+    os.system('cp %s %s' % (config_dir + '/' + src, '/etc/sensors.d/' + dst));
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
+def find_vendor(vendor, board, force = False):
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
+
+                if (force = False):
+                    sys.stdout.write('Do you want to install this configuration? [y/N]: ')
+                    line = sys.stdin.readline()
+                    if (line[0] = 'Y' or line[0] = 'y'):
+                        install(config, 'automobo.conf');
+                else:
+                    install(config, 'automobo.conf', True);
+
+
+def get_config_names():
+    configs = []
+    url_vendors = urllib.urlopen(wiki_url + '/Configurations/Configurations')
+    data = url_vendors.read()
+    it  = re.finditer(r"<a href=\"/wiki/Configurations/.*?\">(.*?)</a>", data)
+    for m in it:
+        print m.group(1)
+        url_boards = urllib.urlopen(wiki_url + '/' + m.group(1))
+        board_data = url_boards.read()
+        print board_data
+        board_it  = re.finditer(r"<a href=\"/wiki/Configurations/.*?\">(Configurations/.*?)</a>", board_data)
+        for boards_m in board_it:
+            configs.append(boards_m.group(1))
+
+    return configs
+
+
+def parse_dmi(lines):
+    dmi = {'sys_vendor': '',
+           'product_name': '',
+           'product_version': '',
+           'board_vendor': '',
+           'board_name': [],
+           'board_version': '',
+           'chassis_type': ''}
+
+    for line in lines:
+        if line[0] = '#':
+            for key in dmi:
+                start = line.find(key + ':')
+                if start != -1:
+                    name = line.split(':')[1]
+                    if (key = 'board_name'):
+                        dmi[key].append(name.strip())
+                    else:
+                        dmi[key] = name.strip()
+
+    return dmi
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
+def create_file(dmi, lines):
+    if (dmi['board_vendor'] != '' and dmi['board_name'] != ''):
+        strip_lines(lines)
+        if (os.path.exists(dmi['board_vendor']) = False):
+            os.mkdir(dmi['board_vendor'])
+
+        for board in dmi['board_name']:
+            path = dmi['board_vendor'] + '/' + board
+            if (os.path.exists(path)):
+                print 'A config file for ' + dmi['board_vendor'] + '/' + \
+                board + ' already exists. Will be overwritten.'
+            f = open(path , 'w')
+            f.writelines(lines)
+            f.close()
+
+
+def fetch_configs():
+    configs = get_config_names()
+
+    for board in configs:
+        print 'Fetch config for ' + board
+        url = urllib.urlopen(wiki_url + '/' + board.replace(' ', '_')
+                             + '?format=txt')
+
+        lines = url.readlines()
+        dmi = parse_dmi(lines)
+        if (len(dmi['board_name']) > 0):
+            print dmi
+
+        create_file(dmi, lines);
+        url.close()
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
+    parser.add_option('-y', '--always-yes', dest='opt_always_yes',
+                      action='store_true',
+                      help='Answer all question with yes')
+
+    return parser.parse_args()
+
+
+# Main
+try:
+    (options, args) = parse_cmdline()
+
+    force = False
+    if (options.opt_always_yes):
+        force = True
+
+    if (options.opt_list_vendors):
+        list_vendors()
+
+    if (options.opt_list_boards):
+        list_boards(options.opt_list_boards)
+
+    if (options.opt_install):
+        install(options.opt_install, '', force)
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
+        find_vendor(options.opt_dmi_vendor, options.opt_dmi_board, force)
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
