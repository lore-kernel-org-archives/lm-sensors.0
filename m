From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: [PATCH] prog/sensors and CONFIG_SYSCTL
Message-Id: <20040416194744.GD31563@pc.aurel32.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all !

On a 2.4 kernel, the sensors program displays an error message when in
can't open the /proc/sys/dev/sensors/. It suggests to load the i2c-proc
module. However the problem could also comes from the CONFIG_SYSCTL 
parameter which is not enabled in the kernel.

The attached patch make the error message a little more verbose. Please
feel free to apply it or not.

Cheers,
Aurelien

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
diff -urN lm_sensors2.orig/prog/sensors/main.c lm_sensors2/prog/sensors/main.c
--- lm_sensors2.orig/prog/sensors/main.c	2004-04-16 20:32:04.000000000 +0200
+++ lm_sensors2/prog/sensors/main.c	2004-04-16 20:33:19.000000000 +0200
@@ -272,7 +272,9 @@
               "Unable to find i2c bus information;\n"
               "For 2.6 kernels, make sure you have mounted sysfs and done\n"
               "'modprobe i2c_sensor'!\n"
-              "For older kernels, make sure you have done 'modprobe i2c-proc'!\n");
+              "For older kernels, make sure your kernel has sysctl support\n"
+              "enabled (parameter CONFIG_SYSCTL) and you have done 'modprobe\n"
+              "i2c-proc'!\n");
     exit(1);
   }
 
