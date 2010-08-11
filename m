From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 Aug 2010 14:52:26 +0000
Subject: [lm-sensors] [PATCH 0/6] Improvements to the pc87427 driver
Message-Id: <20100811165226.5820f53c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I have been working on the pc87427 driver last month, here are the 6
patches I have come up with, if anyone wants to review them:

[PATCH 1/6] hwmon: (pc87427) Handle disabled fan inputs properly
[PATCH 2/6] hwmon: (pc87427) Minor style cleanups
[PATCH 3/6] hwmon: (pc87427) Add support for manual fan speed control
[PATCH 4/6] hwmon: (pc87427) Add support for the second logical device
[PATCH 5/6] hwmon: (pc87427) Add temperature monitoring support
[PATCH 6/6] hwmon: (pc87427) Move sysfs file removal to a separate function

I plan to push them upstream quickly, as they already received some
testing.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
