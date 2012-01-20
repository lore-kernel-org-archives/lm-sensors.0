From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 20 Jan 2012 19:39:12 +0000
Subject: [lm-sensors] [PATCH 00/13] hwmon: More cleanup patches
Message-Id: <1327088365-11149-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch series fixes more checkpatch isues found in drivers/hwmon.

The series applies on top of the other pending patches sent out earlier.

Most of the changes are straightforward, with the exception of patches fixing
"do not use assignment in if condition" errors. Those warrant detailed review
and testing if possible.

As with the other patches submitted earlier, I will apply the series to my
hwmon-next branch. I will submit patches upstream after I get Reviewed-by: or
Acked-by: feedback. Any leftover patches will end up in 3.4. Some of the patches
may also end up in Jean's tree if that is more convenient.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
