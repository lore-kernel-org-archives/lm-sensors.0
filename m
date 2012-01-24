From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:48:39 +0000
Subject: [lm-sensors] [PATCH v2 00/79] hwmon: Fix checkpatch issues and other patches
Message-Id: <1327373398-997-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

The following series of patches fixes most of the checkpatch issues in
drivers/hwmon.

Previously, I sent out three separate series of patches - one to fix checkpatch
issues, one to update multi-line comments to follow the comment guidelines in
Documentation/CodingStyle, and one with additional fixes.

Version 2 of this series is a combination of the previously sent series.
Patches already queued for upstream integration are not included. Checkpatch
fixes and multi-line comment patches were merged into a single patch per file.
I also added the person listed as author to Cc: if I was able to find a current
e-mail, and if the individual has been an active participant in kernel
development in the previous three years.

Other changes:
- Dropped some patches with superficial changes (specifically some of the
  multi-line comment patches).
- Undid some of the multi-line comment changes; some were just too aggressive
  and unnecessary.
- Fixed some additional coding style issues overlooked earlier.
- The vrm value range was often not checked or limited in the original code,
  which could result in unexpected values to be assigned to vrm. This problem
  was fixed as part of the checkpatch changes. This is not really appropriate
  since this is a bug fix, so the respective changes were moved into separate
  patches.

This patch series will reside in my hwmon-next branch for the time being. I will
submit patches upstream after I get a Reviewed-by: or Acked-by: feedback.
Any leftover patches will end up in 3.4. Some of the patches may also end up
in Jean's tree if that is more convenient.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
