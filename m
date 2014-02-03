From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 03 Feb 2014 01:21:46 +0000
Subject: [lm-sensors] [PATCH v2 0/4] hwmon: (lm63) Convert to use devm_hwmon_device_register_with_groups
Message-Id: <1391390510-19238-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The following patch series converts the lm63 driver to use
devm_hwmon_device_register_with_groups. The change is split
into three patches to simplify review.

With this series applied, object file size is reduced by ~1k.

v2: Split introduction of 'dev = &client->dev;' and its use into
    a separate patch.
    Do not merge temp2_type into extra_lut group but create separate group
    instead.
    Associate log messages with hwmon device as much as possible.
    Retain original code where possible to reduce scope of changes;
    specifically do not drop local client variables.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
