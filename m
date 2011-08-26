From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 26 Aug 2011 16:19:01 +0000
Subject: [lm-sensors] [PATCH v2 0/4] hwmon: (pmbus) Updates for
Message-Id: <1314375545-18335-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The following two patches improve support for ADM1275 and add support for
ADM1276.

v2:
- Added patch to document internal API in more detail.
- Added patch changing pmbus_do_remove() from returning an int to void.
- Replaced error return code EINVAL with ENXIO as this is more appropriate.
- Validate page number in adm1275_read_byte_data() and return error if the page
  is non-zero.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
