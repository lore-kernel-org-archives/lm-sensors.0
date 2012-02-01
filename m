From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Feb 2012 19:10:48 +0000
Subject: [lm-sensors] [PATCH 0/24] hwmon: Remove vrm sysfs attribute
Message-Id: <1328123472-27816-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The vrm value is system-wide and only needs to be calculated once. Do it when
the module is loaded. Provide a module parameter to enable overwriting the
default value in case it is wrong or can not be calculated.

The first patch modifies hwmon-vid and its API to support and use a locally
generated value for vrm or a module parameter specifying it. The vrm API
parameter is made optional and ignored if provided. This ensures that the patch
can be applied without affecting drivers which are calling the API functions.

Subsequent patches update the various hwmon drivers to remove vrm attribute
support. At the same time, the cpuX_vid attribute is made optional and only
supported if vrm is known.

The last patch finalizes the series by removing the optional vrm parameter from
the hwmon-vid API functions.

This patch series applies to the top of my hwmon-next tree.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
