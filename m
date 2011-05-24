From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 May 2011 19:48:29 +0000
Subject: [lm-sensors] [PATCH 0/5] hwmon: Initialize dynamically allocated
Message-Id: <1306267814-31505-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The following sequence of patches initializes dynamically allocated sysfs attributes
in several hwmon drivers before device_create_file() calls to avoid lockdep_init_map()
warnings seen if lockdep debugging is enabled.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
