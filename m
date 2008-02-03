From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Sun, 03 Feb 2008 02:26:22 +0000
Subject: [lm-sensors] The new thermal management sysfs class, and hwmon
Message-Id: <20080203022622.GA995@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org
Cc: Zhang Rui <rui.zhang@intel.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Jean Delvare <khali@linux-fr.org>, Len Brown <lenb@kernel.org>

The new thermal managemeny sysfs class that was just merged into acpi-test,
especially when dealing with temperature measurement and fan control, has a
lot of common ground with the hwmon interface.

However, the ACPI model for thermal cooling devices (fans, etc) and thermal
zones (temp sensors) as currently implemented in the sysfs class appears at
first glance to be a lot more simplified than what is available through the
hwmon sysfs ABI (for a lack of a better term to describe the sysfs attribute
specifications).

And the two sysfs ABIs are incompatible.  The ACPI one uses low-precision
units, (temperature in 10^0 degrees Celcius), while the hwmon ABI uses
medium precision units (10^-3 degrees Celcius), for example.  There is also
no tachometer feedback for fans, etc.

Missing functionality in the new thermal class are apparently mainly related
to the idea of hardware-based temperature limits and alarms, plus any
non-trivial fan control schemes (many chips, and in case of thinkpad-acpi,
EC firmware, have auto-cruise modes, some have more than one automatic fan
control scheme, etc).   If I am wrong about this, please correct me.

IMHO, we can probably do better than two incompatible sysfs ABIs for what
ammounts to the same functionality for many userspace applications (i.e.
thermal monitor apps, and fan control and monitoring apps).  And it would be
really neat if the new thermal management stuff could just plug into the
already available temperature sensors and fan controllers that follow the
hwmon sysfs ABI.

Any thoughs on this?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
