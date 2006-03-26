From: jim.cromie@gmail.com (Jim Cromie)
Date: Sun, 26 Mar 2006 22:52:47 +0000
Subject: [lm-sensors] [patch 2/2] hwmon/pc87360 combine sysfs callbacks to
Message-Id: <44271B3F.80404@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



2. hwmon-pc87360-sysfs-combo-callbacks.patch

This combines individual  show_Sensor_Attr callbacks into
show_Sensor callbacks that handle all that Sensor's Attrs.
Does same for set_Sensor_Attr callbacks, where appropriate.
They use the .nr field to determine what attribute they were called for.

Combining callbacks results in a non-trivial size reduction (b4, after)
14588    3224      16   17828    45a4 A-2/drivers/hwmon/pc87360.ko
13124    3224      16   16364    3fec A-3/drivers/hwmon/pc87360.ko
ie about 9%

Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>
---
$ diffstat pc-set-uc/hwmon-pc87360-sysfs-combo-callbacks.patch
 pc87360.c |  570 
+++++++++++++++++++++++++++++---------------------------------
 1 files changed, 271 insertions(+), 299 deletions(-)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-pc87360-sysfs-combo-callbacks.patch
Type: text/x-patch
Size: 31627 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060327/6b55be17/hwmon-pc87360-sysfs-combo-callbacks-0001.bin
