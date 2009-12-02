From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Dec 2009 15:16:02 +0000
Subject: [lm-sensors] [PATCH 00/11] Improvements to the adt7475 driver
Message-Id: <20091202161602.05f9ec47@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Here are 11 patches improving the adt7475 driver. Most importantly,
support for the ADT7490 and ADT7476 is added. In the process, I also
added support for features which the ADT7473 and ADT7475 also have.

[PATCH 01/11] hwmon: (adt7475) Rework voltage inputs handling
[PATCH 02/11] hwmon: (adt7475) Add missing static marker
[PATCH 03/11] hwmon: (adt7475) Improve device detection
[PATCH 04/11] hwmon: (adt7475) Add support for the ADT7490
[PATCH 05/11] hwmon: (adt7475) Move sysfs files removal to a separate function
[PATCH 06/11] hwmon: (adt7475) Handle alternative pin functions
[PATCH 07/11] hwmon: (adt7475) Print device information on probe
[PATCH 08/11] hwmon: (adt7475) Voltage attenuators can be bypassed
[PATCH 09/11] hwmon: (adt7475) Add support for the ADT7476
[PATCH 10/11] hwmon: (adt7475) Add an entry in MAINTAINERS
[PATCH 11/11] hwmon: (adt7475) Add VID support for the ADT7476


This patch series applies on top of the previous 3 adt7475 patches I
sent on November 14th. You can find all the patches here:
  ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-hwmon/

Review and testing welcome.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
