From: Alexey Torkhov <atorkhov@gmail.com>
Date: Mon, 23 Feb 2009 09:23:40 +0000
Subject: [lm-sensors] Add resume hook for lm_sensors
Message-Id: <1235381020.3454.20.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi.

When system is resumed from suspend or hibernate all sensors limits are
got reset. This could lead to wrong alarms, etc.
To prevent this, simple resume hook doing "sensors -s" could be put in
/usr/lib/pm-utils/sleep.d/99lm_sensors.
This file could be put into distribution to be reused.
 uyh
Alexey

---
#!/bin/sh
# Set sensors limits after resume

. "${PM_FUNCTIONS}"

[ -f /usr/bin/sensors ] || exit $NA

case "$1" in
        hibernate|suspend)
                ;;
        thaw|resume)
                /usr/bin/sensors -s
                ;;
        *) exit $NA
                ;;
esac



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
