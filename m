From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 30 Oct 2012 19:13:16 +0000
Subject: [lm-sensors] [PATCH v5 0/3] hwmon: it87 patch series
Message-Id: <1351624399-22595-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This series started with the idea of adding temperature offset registers.
It ended with fixing all checkpatch warnings and errors, and reducing
object file size by more than 2k on x86_64.

v5: More review feedback; dropped applied patches from series
v4: Review feedback
v3: Fixed broken temperature offset code.
    Tested patch series with IT8728F.
    Add patch to support reporting Intel PECI temperature sensors
v2: Added one more patch to the series, and don't introduce has_16bit_fans
    flag (which was dropped in the latest patch anyway).

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
