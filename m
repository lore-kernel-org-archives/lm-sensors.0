From: "Ivo Manca" <pinkel@gmail.com>
Date: Fri, 08 Jun 2007 14:34:28 +0000
Subject: [lm-sensors] [PATCH 3/3] doc/prog & doc/sensors_detect: Add new
Message-Id: <02e701c7a9da$1fd8e020$0601a8c0@pinkeltje>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Creates a file sensors_detect in the doc directory, explaining the
differences between this and the old version, and some more infromation
useful when working with the script.
Also updates the information in doc/progs.

Ivo Manca
---
diff -ubrN lm-sensors-3.0.0/doc/progs lm-sensors.new/doc/progs
--- lm-sensors-3.0.0/doc/progs 2007-04-27 13:15:20.000000000 +0200
+++ lm-sensors.new/doc/progs 2007-06-07 16:52:56.000000000 +0200
@@ -26,9 +26,13 @@
   to list all installed busses).

 * prog/detect/sensors-detect (written in Perl, installed by 'make install')
-  This program tries to detect the available SMBus adapters and the chips
-  connected to them, as well as Super-I/O and misc chips. It also generates
-  modprobe lines and module options. This program is interactive.
+ This program looks up DMI information by using the 'dmidecode' program. It
+ then tries to find a match with known motherboard configurations stored in
a
+ local database. If it can't find any suitable match, it will try to detect
the
+ available SMBus adapters and the chips connected to them, as well as
Super-I/O
+ and misc chips.
+ It also generates modprobe lines and module options. This program can be
used
+ both with an interactive and automatic mode.

 * prog/doc/doc-features.pl (written in Perl, not installed)
   This program is used to help us generate driver documentation; it scans
diff -ubrN lm-sensors-3.0.0/doc/sensors_detect
lm-sensors.new/doc/sensors_detect
--- lm-sensors-3.0.0/doc/sensors_detect 1970-01-01 01:00:00.000000000 +0100
+++ lm-sensors.new/doc/sensors_detect 2007-06-07 21:20:04.000000000 +0200
@@ -0,0 +1,103 @@
+Starting from lmsensors 3.x.x, a new version of sensors-detect is provided.
+This version supports looking up of known motherboard configurations by
reading
+the DMI information provided by the motherboard manufacturer, and matching
this
+with downloaded configurations.
+
+This document only describes the changes between this version and the
previous
+versions!
+
+
+= Command line parameters =
+-a  --automatic       Don't ask anything, use defaults
+                      This mode will only use the new way of detection
+                      (with DMI) to find a match. If it fails, it will
quit.
+-m, --manual          Only use old way of probing
+-u  --update          Update the database, then quit
+-v  --verbose         Display extra information useful for debugging
+-?, --help            Display help
+    --version         Display the program version
+
+= Modes =
+* Interactive mode
+  The default mode is the interactive mode. This mode will ask the user
+  before doing _anything_. It will start asking the user to enter the dmi-
+  detection mode. If the user agrees, it will ask if it is allowed to
update.
+  When the DMI detection has finished, there are mainly two paths left
over:
+  1. It succeeded in finding a match, will ask if it is allowed to detect
+     CPU sensors (which is also a completely safe detection) and will
process
+     the found information.
+  2. It will continue with sensors-detect "how it used to be".
+
+* Automatic mode
+  This mode will proceed with the safest way of detection. It will state
what's
+  happening and will quit if it fails.
+  The safest way is:
+  - Enter the DMI-detection mode.
+  - Do not look for updates on the internet.
+  - Do not try to load alternate revisions of the same motherboard.
+  - Load found modprobes
+  - Detect CPU sensors
+  - write down /etc/sysconfig/lm_sensors, after making a backup
+  - write down /etc/sensors.conf, after making a backup
+
+* Manual mode
+  This mode is actually just the same as sensors-detect used to be.
+
+= How the dmi-detection functions =
+The dmi-detection will go through the following steps:
+
+Initialize:
+1.  Call 'dmidecode' and save the output in a global variable.
+2.  Check if a database is available.
+2a. Database not available: ask user to download, if not: quit mode.
+2b. Database available: ask user to download an updated version: if not,
+    skip next stage. (go to step 6)
+
+Update:
+3.  Detect architecture of current installation and try to locate the
remote
+    tarball corresponding to this architecture, if not found: use the
general
+    tarball.
+4.  Check if tarball is updated. If not, go to step 6.
+5.  Download and extract the new tarball; create the database directory
+    (/usr/share/lmsensors/motherboards) if needed.
+
+Find config file
+6.  Look for a file matching: systemManufacturer-baseboardManufacturer-
+    systemProductName-baseboardProductName-systemVersion-baseboardVersion
+    If found, continue to next stage (step 9).
+7.  Look for alternate configurations by stripping the version (revision of
the
+    Motherboard) fields. If none are found, quit mode.
+8.  If alternate configurations are are found, list them all and let the
user
+    decided whether to load one or quit mode.
+
+Process config file
+9.  Rename /etc/sensors.conf to /etc/sensors.conf.sensorsdetect, if the
+    sensors.conf.sensorsdetect does not exist yet.
+10. Copy new config file to /etc/sensors.conf.
+11. Parse config file to find annotated comments (see next sub)
+11. Try to load the modules found
+12. Quit mode, enter CPU scan, quit CPU scan and process found modules the
old
+    way
+
+= Notes for processing the config file =
+An important thing to realize, is that the config files use annotated
comments
+to give sensors-detect more information about how to process them. The
+following (case sensitive) comments will currently be processed:
+
+# modprobe module1 parameter1 parameter2
+This generally tells sensors-detect to load 'module1' with the parameters
+'paramaeter1' and 'parameter2'. If this succeeds, sensors-detect will copy
+these instructions to the lmsensors etc files, the same with it was done in
+previous versions of sensors-detect.
+
+# minimum-kernel-version 2.6.20
+Sensors-detect will check the current kernel version against the required
+verion specified in this comment, which is '2.6.20' in this cae.
+If the required version is higher than the current version, sensors-detect
+will show an error message and quit immidiatly.
+
+# comment This motherboard has no temperature sensors
+The 'comment' comment can be useful to give the user more information about
+the current configuration. These lines are printed directly upon finding
them
+and can help the user, i.e. when something is simply not supported by the
+motherboard, or not yet supported by lmsensors.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
