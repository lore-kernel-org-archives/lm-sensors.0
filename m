From: Andre Prendel <andre_prendel@gmx.de>
Date: Thu, 05 Feb 2009 09:03:31 +0000
Subject: [lm-sensors] [Patch] libsensors: Ignore directories and symlinks in
Message-Id: <20090205090331.GA5150@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sysfs directory of the hwmon devices contains directories and symlinks.

Here is the output on my Thinkpad:

  andre@ubuntu:/sys/class/hwmon/hwmon0/device$ ls -l
  insgesamt 0
  lrwxrwxrwx 1 root root    0 2009-02-04 19:44 bus -> ../../../bus/platform
  lrwxrwxrwx 1 root root    0 2009-02-04 19:42 driver ->
  ../../../bus/platform/drivers/thinkpad_hwmon 
  -r--r--r-- 1 root root 4096 2009-02-04 19:44 fan1_input
  lrwxrwxrwx 1 root root    0 2009-02-04 19:44 hwmon:hwmon0 ->
  ../../../class/hwmon/hwmon0 
  -r--r--r-- 1 root root 4096 2009-02-04 19:44 modalias
  -r--r--r-- 1 root root 4096 2009-02-04 19:44 name
  drwxr-xr-x 2 root root    0 2009-02-04 19:44 power
  -rw-r--r-- 1 root root 4096 2009-02-04 19:44 pwm1
  -rw-r--r-- 1 root root 4096 2009-02-04 19:44 pwm1_enable
  lrwxrwxrwx 1 root root    0 2009-02-04 19:42 subsystem ->
  ../../../bus/platform 
  -r--r--r-- 1 root root 4096 2009-02-04 19:44 temp10_input
  -r--r--r-- 1 root root 4096 2009-02-04 19:44 temp11_input
  -r--r--r-- 1 root root 4096 2009-02-04 19:44 temp12_input
  [...]

IMO we can ignore them looking for subfeatures (in
sensors_read_dynamic_chip()), can't we?

I assume there are no hidden files in the directory, right? That's the
reason why I have removed this from condition.

Any comments or improvements?

---
--- lm-sensors-dev/lib/sysfs.c	2009-01-26 17:43:43.000000000 +0100
+++ my-sensors-dev/lib/sysfs.c	2009-02-04 21:59:44.000000000 +0100
@@ -360,7 +360,8 @@ static int sensors_read_dynamic_chip(sen
 		char *name = ent->d_name;
 		int nr;
 
-		if (ent->d_name[0] = '.')
+		/* Skip directories and symlinks.  */
+		if (ent->d_type = DT_DIR || ent->d_type = DT_LNK)
 			continue;
 
 		sftype = sensors_subfeature_get_type(name, &nr);

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
