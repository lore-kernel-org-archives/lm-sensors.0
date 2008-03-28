From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Fri, 28 Mar 2008 21:06:04 +0000
Subject: [lm-sensors] [PATCH] adt7473: Minor documentation update
Message-Id: <20080328210604.GA7183@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Add a sentence about when fan speed increases to maximum.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 Documentation/hwmon/adt7473 |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/hwmon/adt7473 b/Documentation/hwmon/adt7473
index 22d8b19..2126de3 100644
--- a/Documentation/hwmon/adt7473
+++ b/Documentation/hwmon/adt7473
@@ -69,7 +69,8 @@ point2: Set the pwm speed at a higher temperature bound.
 
 The ADT7473 will scale the pwm between the lower and higher pwm speed when
 the temperature is between the two temperature boundaries.  PWM values range
-from 0 (off) to 255 (full speed).
+from 0 (off) to 255 (full speed).  Fan speed will be set to maximum when the
+temperature sensor associated with the PWM control exceeds temp#_max.
 
 Notes
 -----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
