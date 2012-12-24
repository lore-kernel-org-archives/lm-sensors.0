From: "Simon J. Rowe" <srowe@mose.org.uk>
Date: Mon, 24 Dec 2012 08:37:57 +0000
Subject: [lm-sensors] RFC: Intel QST driver
Message-Id: <50D81465.9060802@mose.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've written a driver for the Intel Quiet System Technology (QST)
function of the Management Engine Interface found on recent Intel
chipsets.

The git repo can be found here:

     http://mose.dyndns.org/mei.git

A few questions / observations,

1) The code was developed and tested on 2.6.39. I would hope it
compiles and runs on 3.x but I haven't tried it.

2) The main hwmon code is in qst-hwmon.c. This implements QST v1, I
don't have access to hardware that supports v2. I would imagine that
implementing v2 would result in a new module (qst2-hwmon) which would
be almost identical.

3) I've gone a bit overboard with preprocessor macros but it does mean
that the amount of duplicated code is kept to a minimum.

3) I've not implemented any PWM methods yet.

4) I don't believe the MEI (HECI) implementation that Intel have
already submitted to the mainline kernel is usable by other kernel
modules. I have re-implemented it in a way that is accessible to
either the kernel or userspace.

5) I had to patch libsensors to work with a new bus type

diff -ur lm_sensors-3.3.1.org//lib/sysfs.c lm_sensors-3.3.1/lib/sysfs.c
--- lm_sensors-3.3.1.org//lib/sysfs.c   2011-03-04 20:37:43.000000000 +0000
+++ lm_sensors-3.3.1/lib/sysfs.c        2012-11-14 21:48:52.144860375 +0000
@@ -701,6 +701,12 @@
                 /* As of kernel 2.6.32, the hid device names don't look 
good */
                 entry.chip.bus.nr = bus;
                 entry.chip.addr = id;
+       } else
+       if (subsys && !strcmp(subsys, "intel-mei") &&
+           sscanf(dev_name, "mei%d:%d", &bus, &fn) = 2) {
+               entry.chip.bus.type = SENSORS_BUS_TYPE_PCI;
+               entry.chip.bus.nr = bus;
+               entry.chip.addr = fn;
         } else {
                 /* Ignore unknown device */
                 err = 0;

surely this sort of knowledge belongs in the driver not userspace?
Could drivers not provide another set of sysfs attributes which expose
bus type, number, addr etc?

Please let me know if there's any changes or improvements I can make
to it.

Simon

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
