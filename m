From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 21 Oct 2012 17:53:07 +0000
Subject: [lm-sensors] [PATCH v2 0/8] hwmon: it87 patch series
Message-Id: <1350841995-5748-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This series started with the idea of adding temperature offset registers.
It ended with fixing all checkpatch warnings and errors, and reducing
object file size by more than 2k on x86_64.

v2: Added one more patch to the series, and don't introduce has_16bit_fans
    flag (which was dropped in the latest patch anyway).

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
