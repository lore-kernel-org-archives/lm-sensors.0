From: greg@kroah.com (Greg KH)
Date: Wed, 27 Sep 2006 01:01:47 +0000
Subject: [lm-sensors] [PATCH 16/30] i2c: Plan i2c-isa for removal
Message-Id: <11593189773584-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

i2c: Plan i2c-isa for removal

i2c-isa doesn't make much sense in the device driver model. Drivers
relying on it are better implemented as platform drivers. We must
wait for recent versions of libsensors (2.10.0 or later) to be widely
deployed beforehand, though. This move should also make it easier to
convert i2c-core to the device driver model.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 Documentation/feature-removal-schedule.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index 611acc3..afe3d01 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -321,3 +321,12 @@ Why:	The stacking of class devices makes
 Who:	Kay Sievers <kay.sievers at suse.de>
 
 ---------------------------
+
+What:	i2c-isa
+When:	December 2006
+Why:	i2c-isa is a non-sense and doesn't fit in the device driver
+	model. Drivers relying on it are better implemented as platform
+	drivers.
+Who:	Jean Delvare <khali at linux-fr.org>
+
+---------------------------
-- 
1.4.2.1


