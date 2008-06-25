From: Frank Myhr <fmyhr@fhmtech.com>
Date: Wed, 25 Jun 2008 17:51:41 +0000
Subject: [lm-sensors] Are single- or multi- function functions preferred?
Message-Id: <486285AD.4040902@fhmtech.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I'm in the process of cleaning up a patch that adds auto pwm mode
to it87. In the existing it87 driver each sysfs attribute maps to
exactly one (if read-only) or 2 (if read/write) functions. Whereas
in the vt1211 driver (for instance) multiple sysfs attributes map
to a single pair of "show_*" and "set_*" "multi-functions" that
switch on sensor_attr_2->nr to determine what to do. Is one of
these styles preferred over the other, and why?

Thanks,
Frank





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
