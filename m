From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 12 Nov 2007 21:14:47 +0000
Subject: [lm-sensors] lm-sensors-3.0.0 patch for (gnome) sensors-applet
Message-Id: <4738C247.4030501@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

A patch for compiling sensors-applet against lm_sensors-3.0.0 is now available 
from: http://www.lm-sensors.org/wiki/Download

Note that this patch also adds support to the lm_sensors-2.x code for reading 
the low and high (sensors-applet speak for min and max) values from libsensors 
instead of using hardcoded defaults depending on the sensor type.

This is thrown into the mix as the lm_sensors-3x support patch is incremental 
to the min/max reading patch for the 2.x code.

Both patches have been send upstream.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
