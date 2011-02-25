From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 25 Feb 2011 17:21:23 +0000
Subject: [lm-sensors] [PATCH v3 0/4] hwmon: Add support for EMC6D103S
Message-Id: <1298654487-30232-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patchset adds support for EMC6D103S, plus some additional cleanups.

v3:
- Separated patch into multiple patches to limit amount of changes per patch.
- In driver documentation, don't refer to chip registers but only to affected
  sysfs attributes.
- No longer update temp_auto_hyst and temp_auto_off if auto_temp_min is set.
- Add macro to determine if vid5 is configured on adt7463 and adt7468.
- Remove sysfs attribute files in a separate function. Only remove sysfs files
  if previously created.

v2:
- Fixed typo in subject
  Added EMC66D103 and EMC6D103S to driver documentation


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
