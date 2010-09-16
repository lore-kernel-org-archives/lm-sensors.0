From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 16 Sep 2010 02:07:13 +0000
Subject: [lm-sensors] [PATCH 0/2] hwmon: Replace update_rate sysfs attribute
Message-Id: <1284602835-7605-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Randy Dunlap <rdunlap@xenotime.net>, lm-sensors@lm-sensors.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <guenter.roeck@ericsson.com>

Two sysfs attributes are currently used to reflect sensor reading update
intervals: update_rate and rate. In all uses, the attribute reflects
an interval, not a rate.

To reflect this, replace the sysfs ABI attribute update_rate with
update_interval, and modify affected drivers to use update_interval.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
