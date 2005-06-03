From: BGardner@Wabtec.com (BGardner@Wabtec.com)
Date: Fri, 03 Jun 2005 19:41:54 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc5-mm2 5/5] w1 enhancements
Message-Id: <F06EB2894F3F0D45AD9BEA7246DE9C9076C6AF@WCSEXCMBS1.ad.wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <F06EB2894F3F0D45AD9BEA7246DE9C9076C5EE@WCSEXCMBS1.ad.wabtec.com>
In-Reply-To: <F06EB2894F3F0D45AD9BEA7246DE9C9076C5EE@WCSEXCMBS1.ad.wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Updates the w1 documentation (w1.generic)

Signed-off-by: Ben Gardner <bgardner@wabtec.com>

--- linux-2.6.12-rc5-mm2-clean/Documentation/w1/w1.generic
2005-03-02 01:38:19.000000000 -0600
+++ linux-2.6.12-rc5-mm2/Documentation/w1/w1.generic	2005-06-03
10:22:39.451162409 -0500
@@ -1,19 +1,92 @@
-Any w1 device must be connected to w1 bus master device - for example
-ds9490 usb device or w1-over-GPIO or RS232 converter.
-Driver for w1 bus master must provide several functions(you can find
-them in struct w1_bus_master definition in w1.h) which then will be
-called by w1 core to send various commands over w1 bus(by default it is
-reset and search commands). When some device is found on the bus, w1
core
-checks if driver for it's family is loaded.
-If driver is loaded w1 core creates new w1_slave object and registers
it
-in the system(creates some generic sysfs files(struct w1_family_ops in
-w1_family.h), notifies any registered listener and so on...).
-It is device driver's business to provide any communication method
-upstream.
-For example w1_therm driver(ds18?20 thermal sensor family driver)
-provides temperature reading function which is bound to ->rbin() method
-of the above w1_family_ops structure.
-w1_smem - driver for simple 64bit memory cell provides ID reading
-method.
+The 1-wire (w1) subsystem 
+------------------------------------------------------------------
+The 1-wire bus is a simple master-slave bus that communicates via a
single
+signal wire (plus ground, so two wires).
+
+Devices communicate on the bus by pulling the signal to ground via an
open 
+drain output and by sampling the logic level of the signal line.
+
+The w1 subsystem provides the framework for managing w1 masters and 
+communication with slaves.
+
+All w1 slave devices must be connected to a w1 bus master device.
+
+Example w1 master devices:
+    DS9490 usb device 
+    W1-over-GPIO
+    DS2482 (i2c to w1 bridge)
+    Emulated devices, such as a RS232 converter, parallel port adapter,
etc
+
+
+What does the w1 subsystem do?
+------------------------------------------------------------------
+When a w1 master driver registers with the w1 subsystem, the following
occurs:
+
+ - sysfs entries for that w1 master are created
+ - the w1 bus is periodically searched for new slave devices
+ 
+When a device is found on the bus, w1 core checks if driver for it's
family is 
+loaded. If so, the family driver is attached to the slave.
+If there is no driver for the family, a simple sysfs entry is created
+for the slave device.
+
+
+W1 device families
+------------------------------------------------------------------
+Slave devices are handled by a driver written for a family of w1
devices.
+
+A family driver populates a struct w1_family_ops (see w1_family.h) and 
+registers with the w1 subsystem.
+
+Current family drivers:
+w1_therm - (ds18?20 thermal sensor family driver) 
+    provides temperature reading function which is bound to ->rbin()
method 
+    of the above w1_family_ops structure.
+    
+w1_smem - driver for simple 64bit memory cell provides ID reading
method.
 
 You can call above methods by reading appropriate sysfs files.
+
+
+What does a w1 master driver need to implement?
+------------------------------------------------------------------
+  
+The driver for w1 bus master must provide at minimum two functions.
+
+Emulated devices must provide the ability to set the output signal
level 
+(write_bit) and sample the signal level (read_bit).
+
+Devices that support the 1-wire natively must provide the ability to
write and
+sample a bit (touch_bit) and reset the bus (reset_bus).
+
+Most hardware provides higher-level functions that offload w1 handling.
+See struct w1_bus_master definition in w1.h for details.
+
+
+w1 master sysfs interface
+------------------------------------------------------------------
+<xx-xxxxxxxxxxxxx> - a directory for a found device. The format is
family-serial
+bus                - (standard) symlink to the w1 bus
+driver             - (standard) symlink to the w1 driver
+w1_master_attempts - the number of times a search was attempted
+w1_master_max_slave_count
+                   - the maximum slaves that may be attached to a
master
+w1_master_name     - the name of the device (w1_bus_masterX)
+w1_master_search   - the number of searches left to do, -1=continual
(default)
+w1_master_slave_count
+                   - the number of slaves found
+w1_master_slaves   - the names of the slaves, one per line
+w1_master_timeout  - the delay in seconds between searches
+
+If you have a w1 bus that never changes (you don't add or remove
devices), 
+you can set w1_master_search to a positive value to disable searches.
+
+
+w1 slave sysfs interface
+------------------------------------------------------------------
+bus                - (standard) symlink to the w1 bus
+driver             - (standard) symlink to the w1 driver
+name               - the device name, usually the same as the directory
name
+w1_slave           - (optional) a binary file whose meaning depends on
the 
+                     family driver
+

