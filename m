From: thearni@online.no (Arne Vidar Sj=?ISO-8859-1?Q?=F8n=F8st?=)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: Ticket 892: No sensors found!
Message-Id: <3CE21B56@epostleser.online.no>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ref: Ticket 892

The kernel dont support modules, thats why I have patched this into the 
kernel. Everything built in, no modules. Its running Slackware 7.

Kernelsetup:
[Y] I2C support
[Y] I2C mainboard interfaces       
[Y]   VIA Technologies, Inc. VT596A/B, 686A/B, 8233 (NEW)
[Y] I2C device interface
[Y] I2C /proc interface (required for hardware sensors)

[Y] Hardware sensors support
[Y]   Winbond W83781D, W83782D, W83783S, W83627HF, Asus AS99127F

dmesg:
i2c-core.o: i2c core module version 2.6.3 (20020322)
i2c-dev.o: i2c /dev entries driver module version 2.6.3 (20020322)
i2c-proc.o version 2.6.3 (20020322)
No other things regarding sensors


sensors:
No sensors found!

sensors-detect:
Can't access /proc/modules! at /usr/local/sbin/sensors-detect line 991.

lsmod:
Module                  Size  Used by
lsmod: QM_MODULES: Function not implemented
