From: Kyle McMartin <kyle@redhat.com>
Date: Wed, 28 Mar 2012 19:11:47 +0000
Subject: [lm-sensors] [PATCH] acpi_power_meter: fix lockdep spew due to non-static lock class
Message-Id: <20120328191147.GK25886@redacted.bos.redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: khali@linux-fr.org, guenter.roeck@ericsson.com, lm-sensors@lm-sensors.org, djwong@us.ibm.com

Similar to a30dcb4f which fixed asus_atk0110.ko, I recently received a
bug report from someone hitting the same issue in acpi_power_meter.

[   13.963168] power_meter ACPI000D:00: Found ACPI power meter.
[   13.963900] BUG: key ffff8802161f3920 not in .data!
[   13.963904] ------------[ cut here ]------------
[   13.963915] WARNING: at kernel/lockdep.c:2986
	lockdep_init_map+0x52f/0x560()

So let's fix that up for them by statically declaring the
lockdep_class_key.

Signed-off-by: Kyle McMartin <kyle@redhat.com>

--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -632,6 +632,7 @@ static int register_ro_attrs(struct acpi_power_meter_resource *resource,
 		sensors->dev_attr.show = ro->show;
 		sensors->index = ro->index;
 
+		sysfs_attr_init(&sensors->dev_attr.attr);
 		res = device_create_file(dev, &sensors->dev_attr);
 		if (res) {
 			sensors->dev_attr.attr.name = NULL;
@@ -661,6 +662,7 @@ static int register_rw_attrs(struct acpi_power_meter_resource *resource,
 		sensors->dev_attr.store = rw->set;
 		sensors->index = rw->index;
 
+		sysfs_attr_init(&sensors->dev_attr.attr);
 		res = device_create_file(dev, &sensors->dev_attr);
 		if (res) {
 			sensors->dev_attr.attr.name = NULL;

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
