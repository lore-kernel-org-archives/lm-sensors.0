From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 04 Mar 2012 15:59:04 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: Add detection of ITE IT8510E, IT8511E, IT8513E, and IT8518E
Message-Id: <1330876744-8447-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110217195640.GA20934@ericsson.com>
In-Reply-To: <20110217195640.GA20934@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Trying again, this time more in line with detection of other IT85xx chips.
IT8510 and IT8512 datasheets suggest that there is no special sequence
to enable superio acccess, so let's just assume that this applies to all chips
from the same series.

 CHANGES                    |    1 +
 prog/detect/sensors-detect |   20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/CHANGES b/CHANGES
index 10e62f5..8981e69 100644
--- a/CHANGES
+++ b/CHANGES
@@ -21,6 +21,7 @@ SVN HEAD
                   Add detection of National Semiconductor LM96080
                   Add detection of ITE IT8771E
                   Add detection of ITE IT8781F, IT8782F and IT8783F
+                  Add detection of ITE IT8510E/TE/G, IT8511E/TE/G, IT8513E/F/G, and IT8518E
 
 3.3.1 (2011-07-21)
   isadump: Add support for word (16-bit) and long (32-bit) reads
diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
index bffd5c3..93621ad 100755
--- a/prog/detect/sensors-detect
+++ b/prog/detect/sensors-detect
@@ -1595,15 +1595,35 @@ use constant FEAT_SMBUS	=> (1 << 7);
 		logdev => 0x14,
 		features => FEAT_IN | FEAT_TEMP,
 	}, {
+		name => "ITE IT8510E/TE/G Super IO",
+		driver => "to-be-written",
+		devid => 0x8510,
+		features => FEAT_IN | FEAT_FAN,
+	}, {
+		name => "ITE IT8511E/TE/G Super IO",
+		driver => "to-be-written",
+		devid => 0x8511,
+		features => FEAT_IN | FEAT_FAN,
+	}, {
 		name => "ITE IT8512E/F/G Super IO",
 		driver => "to-be-written",
 		devid => 0x8512,
 		features => FEAT_IN | FEAT_FAN,
 	}, {
+		name => "ITE IT8513E/F/G Super IO",
+		driver => "to-be-written",
+		devid => 0x8513,
+		features => FEAT_IN | FEAT_FAN,
+	}, {
 		name => "ITE IT8516E/F/G Super IO",
 		driver => "to-be-written",
 		devid => 0x8516,
 		features => FEAT_IN | FEAT_FAN,
+	}, {
+		name => "ITE IT8518E Super IO",
+		driver => "to-be-written",
+		devid => 0x8518,
+		features => FEAT_IN | FEAT_FAN,
 	}
 );
 
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
