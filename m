From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 26 Sep 2011 03:37:40 +0000
Subject: [lm-sensors] CONFIG_THERMAL_HWMON configuration option removal
Message-Id: <20110926033740.GA5637@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: Rene Herman <rene.herman@gmail.com>, linux-kernel@vger.kernel.org

Hi,

I just noticed the folllowing in feature-removal-schedule.txt:

What:   CONFIG_THERMAL_HWMON
When:   January 2009
Why:    This option was introduced just to allow older lm-sensors userspace
        to keep working over the upgrade to 2.6.26. At the scheduled time of
        removal fixed lm-sensors (2.x or 3.x) should be readily available.
Who:    Rene Herman <rene.herman@gmail.com>

I don't know what the lm-sensors changes are, and if they have been implemented.
Is it time to remove the configuration option ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
