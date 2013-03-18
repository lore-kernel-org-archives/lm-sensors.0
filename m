From: "Simon J. Rowe" <srowe@mose.org.uk>
Date: Mon, 18 Mar 2013 21:20:53 +0000
Subject: [lm-sensors] RFC (v2): Intel QST sensor driver
Message-Id: <51478535.8080107@mose.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: linux@roeck-us.net, tomas.winkler@intel.com, linux-kernel@vger.kernel.org

Hello,

I've made changes to my driver for the Intel Quiet System Technology
(QST) function that I posted at the end of last year and would again
appreciate feedback on it.

As before the git repo can be found here:

     http://mose.dyndns.org/mei.git


Changes from v1
---------------

The module has been re-written to be data-driven rather than use
macros. Only v1 of the protocol is implemented but adding support for
v2 only requires three arrays and nine stub functions to be defined.

The code has been compiled and tested on 3.9 rc2.

The code has been fixed up after running checkpatch.pl.

I've added documents that explain the QST protocol and also the design
of the driver.


Unchanged from v1
-----------------

The driver still uses my MEI implementation. I've taken a look at the
Intel-written driver in 3.9 and it still has no obvious way to be used
by another driver, in the same directory or otherwise. The lack of
documentation may mean I've overlooked something obvious.

The following patch is still required to prevent libsensors from
ignoring the hwmon directory

diff -ur lm_sensors-3.3.1.org/lib/sysfs.c lm_sensors-3.3.1/lib/sysfs.c
--- lm_sensors-3.3.1.org/lib/sysfs.c   2011-03-04 20:37:43.000000000 +0000
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

PWM is still unimplemented.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
