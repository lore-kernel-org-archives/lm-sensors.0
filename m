From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: [PATCH 2.4] i2c cleanups, third wave (1/8)
Message-Id: <20040111145150.3e1d04fc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040111144214.7a6a4e59.khali@linux-fr.org>
In-Reply-To: <20040111144214.7a6a4e59.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@stimpy.netroedge.com>

This patch fixes a few errors in drivers/i2c/Config.in:
* missing dependancy
* empty line, indentation, typo

The thin part of this patch that also applies to linux 2.6 has been sent
to Greg KH.


--- linux-2.4.24-pre3/drivers/i2c/Config.in.orig	Wed Dec 31 17:22:11 2003
+++ linux-2.4.24-pre3/drivers/i2c/Config.in	Sun Jan  4 20:00:59 2004
@@ -7,7 +7,6 @@
 tristate 'I2C support' CONFIG_I2C
 
 if [ "$CONFIG_I2C" != "n" ]; then
-
    dep_tristate 'I2C bit-banging interfaces'  CONFIG_I2C_ALGOBIT $CONFIG_I2C
    if [ "$CONFIG_I2C_ALGOBIT" != "n" ]; then
       dep_tristate '  Philips style parallel port adapter' CONFIG_I2C_PHILIPSPAR $CONFIG_I2C_ALGOBIT $CONFIG_PARPORT
@@ -36,7 +35,7 @@
    if [ "$CONFIG_8xx" = "y" ]; then
       dep_tristate 'MPC8xx CPM I2C interface' CONFIG_I2C_ALGO8XX $CONFIG_I2C
       if [ "$CONFIG_RPXLITE" = "y" -o "$CONFIG_RPXCLASSIC" = "y" ]; then
-         dep_tristate '  Embedded Planet RPX Lite/Classic suppoort' CONFIG_I2C_RPXLITE $CONFIG_I2C_ALGO8XX
+         dep_tristate '  Embedded Planet RPX Lite/Classic support' CONFIG_I2C_RPXLITE $CONFIG_I2C_ALGO8XX
       fi
    fi
    if [ "$CONFIG_405" = "y" ]; then
@@ -55,14 +54,14 @@
       dep_tristate '  MAX1617 Temperature Sensor' CONFIG_I2C_MAX1617 $CONFIG_I2C_ALGO_SIBYTE
    fi
 
-  if [ "$CONFIG_SGI_IP22" = "y" ]; then
-     dep_tristate 'I2C SGI interfaces' CONFIG_I2C_ALGO_SGI $CONFIG_I2C
-  fi
+   if [ "$CONFIG_SGI_IP22" = "y" ]; then
+      dep_tristate 'I2C SGI interfaces' CONFIG_I2C_ALGO_SGI $CONFIG_I2C
+   fi
  
 # This is needed for automatic patch generation: sensors code starts here
 # This is needed for automatic patch generation: sensors code ends here
 
    dep_tristate 'I2C device interface' CONFIG_I2C_CHARDEV $CONFIG_I2C
-   dep_tristate 'I2C /proc interface (required for hardware sensors)' CONFIG_I2C_PROC $CONFIG_I2C
+   dep_tristate 'I2C /proc interface (required for hardware sensors)' CONFIG_I2C_PROC $CONFIG_I2C $CONFIG_SYSCTL
 fi
 endmenu

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
