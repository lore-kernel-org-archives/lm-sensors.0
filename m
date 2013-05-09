From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 09 May 2013 17:09:48 +0000
Subject: [lm-sensors] [PATCH 0/3] pm: Introduce __pm to mark power management code
Message-Id: <1368119391-13837-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1368119366-8716-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1368119366-8716-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Jingoo Han <jg1.han@samsung.com>, Guenter Roeck <linux@roeck-us.net>

The following patch series introduces a marker for power management functions
and data. This this marker, #ifdef CONFIG_PM and #ifdef CONFIG_PM_SLEEP
can be removed from most of the code. This ensures that the conditional code
still compiles but is not included in the object file.

As a side effect, drivers declaring struct dev_pm_ops unconditionally
get a bit smaller if CONFIG_PM_SLEEP is not configured.

The first patch in the series introduces the marker, the following
two patches introduce the marker in two drivers to demonstrate its use.

The patch series depends on the "PM: Add pm_ops_ptr() macro" patch
submitted by Jingoo Han.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
