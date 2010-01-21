From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 21 Jan 2010 13:40:24 +0000
Subject: [lm-sensors] [PATCH 0/8] it87 patches
Message-Id: <20100121144024.3c84c954@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Here comes an 8-piece patchset for the it87 driver. This is a mix of
feature additions and code cleanups.

[PATCH 1/8] hwmon: (it87) Display fan outputs in automatic mode as such
[PATCH 2/8] hwmon: (it87) Expose the PWM/temperature mappings
[PATCH 3/8] hwmon: (it87) Refactor attributes creation and removal
[PATCH 4/8] hwmon: (it87) Create vid attributes by group
[PATCH 5/8] hwmon: (it87) Add support for beep on alarm
[PATCH 6/8] hwmon: (it87) Fix many checkpatch errors and warnings
[PATCH 7/8] hwmon: (it87) Use strict_strtol instead of simple_strtol
[PATCH 8/8] hwmon: (it87) Add an entry in MAINTAINERS

Reviews, comments and testing welcome.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
