From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: [PATCH] sensors-detect and udev
Message-Id: <20040810225714.GA2700@pc.aurel32.lan>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all!

sensors-detect currently checks at the beginning of its execution if the
i2c device nodes exists. It can't work on a system using udev as the 
nodes are created when the i2c-dev module is inserted.

The attached patch fixes that.

Bye,
Aurelien

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
Index: prog/detect/sensors-detect
=================================RCS file: /home/cvs/lm_sensors2/prog/detect/sensors-detect,v
retrieving revision 1.338
diff -u -1 -b -p -r1.338 sensors-detect
--- prog/detect/sensors-detect	31 Jul 2004 16:09:37 -0000	1.338
+++ prog/detect/sensors-detect	10 Aug 2004 23:10:18 -0000
@@ -1805,2 +1805,8 @@ sub initialize_conf
 
+  my $use_udev = 0;
+  if (-d './dev') {
+    $use_udev = 1;
+    $dev_i2c = '/dev/i2c-';
+  } 
+
   if (-f '/etc/modules.conf') {
@@ -1813,3 +1819,3 @@ sub initialize_conf
 
-  if (!$use_devfs) {
+  if ((!$use_devfs) and (!$use_udev)) {
     if (-c '/dev/i2c-0') {
