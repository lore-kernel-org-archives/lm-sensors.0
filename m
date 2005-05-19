From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: [RFC PATCH] Re: [OOPS] w83781d during rmmod (2.5.69-bk17)
Message-Id: <3EDCFA7B.4030906@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030524183748.GA3097@earth.solarsys.private>	 <3ED8067E.1050503@paradyne.com>	 <20030601143808.GA30177@earth.solarsys.private>	 <20030602172040.GC4992@kroah.com> <1054617753.5269.44.camel@workshop.saharacpt.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schlemmer <azarah@gentoo.org>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Sensors <sensors@Stimpy.netroedge.com>

Martin Schlemmer wrote:
> On Mon, 2003-06-02 at 19:20, Greg KH wrote:
> 
> Hiya Greg
> 
> While sorda on the topic ... since I did the w83781d driver some time
> ago, I changed boards for a P4C800 (Intel 875 chipset), that have a
> ICH5 southbridge, and not a ICH4 one ....  I tried to add the ID's
> to the i810 driver, and although it does load (even without the
> ID's added), the I2C bus/sensor does not show in /sys.  The w83781d
> driver also load fine btw.

My system (SuperMicro) with an '875 and ICH5 reports the ICH5 as an 
'801EB' which means you should be using the i2c-i801 driver not i2c-i810...

I'm also betting that you need to set 'isich4' to true in the case of 
the ich5 as well...

Try the attached patch...  NOTE: I have *not* consulted the Intel DOC's 
on the ICH4 and ICH5 to see if the register interface has changed in 
other interesting ways...

> Any ideas ? Anybody working on 875 support that I can help test ?

Unfortuntately, the SuperMicro has a Winbond '627HF chip on the ISA bus 
and no other SMBus sensors, so the i2c-i801 support didn't help me much.

:v)

-- 
Philip Pokorny, Director of Engineering
Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
-------------- next part --------------
diff -ru lm_sensors-2.7.0/kernel/busses/i2c-i801.c lm_sensors-2.7.0.ich5/kernel/busses/i2c-i801.c
--- lm_sensors-2.7.0/kernel/busses/i2c-i801.c	2002-08-10 11:29:40.000000000 -0700
+++ lm_sensors-2.7.0.ich5/kernel/busses/i2c-i801.c	2003-06-02 21:11:32.000000000 -0700
@@ -27,6 +27,7 @@
     82801BA		2443           
     82801CA/CAM		2483           
     82801DB		24C3   (HW PEC supported, 32 byte buffer not supported)
+    82801EB		24D3   (HW PEC supported, 32 byte buffer not supported)
 
     This driver supports several versions of Intel's I/O Controller Hubs (ICH).
     For SMBus support, they are similar to the PIIX4 and are part
@@ -71,11 +72,16 @@
 #define PCI_DEVICE_ID_INTEL_82801CA_SMBUS	0x2483
 #define PCI_DEVICE_ID_INTEL_82801DB_SMBUS	0x24C3
 
+#ifndef PCI_DEVICE_ID_INTEL_82801EB_SMBUS
+#define PCI_DEVICE_ID_INTEL_82801EB_SMBUS	0x24D3
+#endif
+
 static int supported[] = {PCI_DEVICE_ID_INTEL_82801AA_3,
                           PCI_DEVICE_ID_INTEL_82801AB_3,
                           PCI_DEVICE_ID_INTEL_82801BA_2,
 			  PCI_DEVICE_ID_INTEL_82801CA_SMBUS,
 			  PCI_DEVICE_ID_INTEL_82801DB_SMBUS,
+			  PCI_DEVICE_ID_INTEL_82801EB_SMBUS,
                           0 };
 
 /* I801 SMBus address offsets */
@@ -214,7 +220,9 @@
 		error_return = -ENODEV;
 		goto END;
 	}
-	isich4 = *num = PCI_DEVICE_ID_INTEL_82801DB_SMBUS;
+	isich4 = (*num = PCI_DEVICE_ID_INTEL_82801DB_SMBUS)
+		|| (*num = PCI_DEVICE_ID_INTEL_82801EB_SMBUS)
+		;
 
 /* Determine the address of the SMBus areas */
 	if (force_addr) {
