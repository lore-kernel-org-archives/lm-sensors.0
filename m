From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: Sensors-detect fail to detect devfs (with patch)
Message-Id: <20040507084158.GA31429@pc.aurel32.lan>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

When running sensors-detect on a system with devfs enabled, and the 
/proc/mounts report its device different from 'none' (for example devfsd
uses 'devfs' as device name), sensors-detect don't detect devfs and try
to use normal names for i2c devices.

The attached patch fixes that.

Bye,
Aurelien

-- 
  .''`.  Aurelien Jarno               GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net

-------------- next part --------------
--- lm_sensors2/prog/detect/sensors-detect	30 Apr 2004 16:56:41 -0000	1.315
+++ lm_sensors2/prog/detect/sensors-detect	7 May 2004 08:40:16 -0000
@@ -1736,3 +1736,3 @@ sub initialize_conf
   while (<INPUTFILE>) {
-    if (m@^none /dev devfs @) {
+    if (m@^\w+ /dev devfs @) {
       $use_devfs = 1;
