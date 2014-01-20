From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 20 Jan 2014 18:38:43 +0000
Subject: [lm-sensors] [PATCH 0/3] hwmon: (lm63) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <1390243126-19519-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The following patch series converts the lm63 driver to use
devm_hwmon_device_register_with_groups. The change is split
into three patches to simplify review.

With this series applied, object file size is reduced by ~1k.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
