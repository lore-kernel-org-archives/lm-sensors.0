From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 19 Jul 2007 13:57:20 +0000
Subject: [lm-sensors] PATCH: hwmon-fscher-bugfix-read-control.patch
Message-Id: <469F6DC0.8070401@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060606020306020508020401"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------060606020306020508020401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Mark,

Here is a small fscher bugfix for 2.6.23 merging, lifted from my other fscher
work, as requested by Jean. The current driver has a control sysfs attribute,
which shows the contents of the control register, but the underlying
global_control value in the data structure currently never gets filled with
the actual contents of this register.

Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Regards,

Hans

--------------060606020306020508020401
Content-Type: text/x-patch;
 name="hwmon-fscher-bugfix-read-control.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="hwmon-fscher-bugfix-read-control.patch"

Mark,

Here is a small fscher bugfix for 2.6.23 merging, lifted from my other fscher
work, as requested by Jean. The current driver has a control sysfs attribute,
which shows the contents of the control register, but the underlying
global_control value in the data structure currently never gets filled with
the actual contents of this register.

Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
diff -up linux-2.6.22-rc4/drivers/hwmon/fscher.c.orig linux-2.6.22-rc4/drivers/hwmon/fscher.c
--- linux-2.6.23-rc0.git1/drivers/hwmon/fscher.c.orig	2007-07-09 13:18:28.000000000 +0200
+++ linux-2.6.23-rc0.git1/drivers/hwmon/fscher.c	2007-07-09 13:23:52.000000000 +0200
@@ -441,6 +441,8 @@ static struct fscher_data *fscher_update
 		data->watchdog[2] = fscher_read_value(client, FSCHER_REG_WDOG_CONTROL);
 
 		data->global_event = fscher_read_value(client, FSCHER_REG_EVENT_STATE);
+		data->global_control = fscher_read_value(client,
+							FSCHER_REG_CONTROL);
 
 		data->last_updated = jiffies;
 		data->valid = 1;                 

--------------060606020306020508020401
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------060606020306020508020401--
