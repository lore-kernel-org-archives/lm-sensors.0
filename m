From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 30 Aug 2011 05:57:56 +0000
Subject: [lm-sensors] [PATCH RFC] hwmon: (max16065) Add chip access warning
Message-Id: <1314683876-16557-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The chips supported by the max16065 driver should not be accessed using direct
i2ctools commands. Add warning to driver documentation to alert users.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
RFC: Do we want this kind of warning in driver documentation ?

 Documentation/hwmon/max16065 |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/hwmon/max16065 b/Documentation/hwmon/max16065
index 44b4f61..c11f64a 100644
--- a/Documentation/hwmon/max16065
+++ b/Documentation/hwmon/max16065
@@ -62,6 +62,13 @@ can be safely used to identify the chip. You will have to instantiate
 the devices explicitly. Please see Documentation/i2c/instantiating-devices for
 details.
 
+WARNING: Do not access chip registers using the i2cdump command, and do not use
+any of the i2ctools commands on a command register (0xa5 to 0xac). The chips
+supported by this driver interpret any access to a command register (including
+read commands) as request to execute the command in question. This may result in
+power loss, board resets, and/or Flash corruption. Worst case, your board may
+turn into a brick.
+
 
 Sysfs entries
 -------------
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
