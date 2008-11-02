From: Wolfgang Pichl <wolfgang.pichl@univie.ac.at>
Date: Sun, 02 Nov 2008 21:34:13 +0000
Subject: [lm-sensors] Andigilog driver by George Joseph
Message-Id: <Pine.LNX.4.64.0811022213310.5906@belenos.adsl.univie.ac.at>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
I would be extremely interested in the driver for the asc7621 which is 
under development, because I have the Intel 975XBX2 motherboard. I tried
to install the driver, but the patch does not apply, neither to 2.6.25.4 
nor to a newer kernel. The following error  message appears:

patching file drivers/hwmon/Makefile
Hunk #1 FAILED at 27.
1 out of 1 hunk FAILED -- saving rejects to file 
drivers/hwmon/Makefile.rej

and this is the content of Makefile.rej :

***************
*** 27,32 ****
   obj-$(CONFIG_SENSORS_ADT7473)  += adt7473.o
   obj-$(CONFIG_SENSORS_APPLESMC) += applesmc.o
   obj-$(CONFIG_SENSORS_AMS)      += ams/
   obj-$(CONFIG_SENSORS_ATXP1)    += atxp1.o
   obj-$(CONFIG_SENSORS_CORETEMP) += coretemp.o
   obj-$(CONFIG_SENSORS_DME1737)  += dme1737.o
--- 27,33 ----
   obj-$(CONFIG_SENSORS_ADT7473)  += adt7473.o
   obj-$(CONFIG_SENSORS_APPLESMC) += applesmc.o
   obj-$(CONFIG_SENSORS_AMS)      += ams/
+ obj-$(CONFIG_SENSORS_ASC7621)  += asc7621.o
   obj-$(CONFIG_SENSORS_ATXP1)    += atxp1.o
   obj-$(CONFIG_SENSORS_CORETEMP) += coretemp.o
   obj-$(CONFIG_SENSORS_DME1737)  += dme1737.o

Looks like a minor problem, but I could not yet find the reason.

N.B. Is there any userspace support for this driver, perhaps a patch to 
libsensors, already available?

best regards
Wolfgang Pichl


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
