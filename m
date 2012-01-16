From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:02 +0000
Subject: [lm-sensors] [PATCH 00/39] hwmon: Fix checkpatch issues
Message-Id: <1326703781-14272-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch series is the result of playing with coccinelle. It is based on a
series of coccinelle script runs written to fix the following checkpatch issues.

WARNING: simple_strtol is obsolete, use kstrtol instead
WARNING: simple_strtoul is obsolete, use kstrtoul instead
ERROR: do not use assignment in if condition

The files in drivers/hwmon were processed with coccinelle to fix above issues. 
Subsequently, all files touched by coccinelle were edited manually to fix any
remaining checkpatch warnings and errors.

The changelog for each patch describes which checkpatch issues were fixed,
and lists any remaining checkpatch issues as well as (in most cases) the reasons
why those were not fixed.

The series applies to the tip of Linus's tree. Some of the changes overlap with
the pending checkpatch cleanup fixes, but "git am -3" on top of those should
work.

Since the patch series is quite large, I am sure I got something wrong, even
though I reviewed the changes several times. So the plan is to put the series
into my hwmon-next branch immediately after -rc1 is released, and only submit
patches upstream after I get a Reviewed-by: or Acked-by: feedback. Any leftover
patches will end up in 3.4. Some of the patches may also end up in Jean's tree
if that is more convenient.

Note that two of the patches generate false checkpatch errors/warnings in
comments.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
