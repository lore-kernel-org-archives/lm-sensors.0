From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 22 Apr 2011 08:33:59 +0000
Subject: [lm-sensors] CONFIG_THERMAL_HWMON
Message-Id: <20110422103359.02a4b6fd@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rene,

From Documentation/feature-removal-schedule.txt:

What:	CONFIG_THERMAL_HWMON
When:	January 2009
Why:	This option was introduced just to allow older lm-sensors userspace
	to keep working over the upgrade to 2.6.26. At the scheduled time of
	removal fixed lm-sensors (2.x or 3.x) should be readily available.
Who:	Rene Herman <rene.herman@gmail.com>

It's about time, isn't it? If you still feel that this configuration
option should be removed, please proceed. If not, please at least drop
the entry from feature-removal-schedule.txt.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
