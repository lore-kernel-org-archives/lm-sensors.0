From: Peter Meerwald <pmeerw@pmeerw.net>
Date: Tue, 02 Oct 2012 13:05:26 +0000
Subject: [lm-sensors] [PATCH] doc: hwmon: fix spelling of celsius
Message-Id: <1349183126-9222-1-git-send-email-pmeerw@pmeerw.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Peter Meerwald <p.meerwald@bct-electronic.com>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 Documentation/hwmon/da9052             |    2 +-
 Documentation/hwmon/twl4030-madc-hwmon |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/da9052 b/Documentation/hwmon/da9052
index ef89855..5bc5134 100644
--- a/Documentation/hwmon/da9052
+++ b/Documentation/hwmon/da9052
@@ -56,6 +56,6 @@ The junction temperature is calculated:
 The junction temperature attribute is supported by the driver.
 
 The battery temperature is calculated:
-	Degree Celcius = 1 / (t1 + 1/298)- 273
+	Degree Celsius = 1 / (t1 + 1/298)- 273
 where t1 = (1/B)* ln(( ADCval * 2.5)/(R25*ITBAT*255))
 Default values of R25, B, ITBAT are 10e3, 3380 and 50e-6 respectively.
diff --git a/Documentation/hwmon/twl4030-madc-hwmon b/Documentation/hwmon/twl4030-madc-hwmon
index ef79843..215babd 100644
--- a/Documentation/hwmon/twl4030-madc-hwmon
+++ b/Documentation/hwmon/twl4030-madc-hwmon
@@ -41,5 +41,5 @@ Channel Signal
 
 The Sysfs nodes will represent the voltage in the units of mV,
 the temperature channel shows the converted temperature in
-degree celcius. The Battery charging current channel represents
+degree celsius. The Battery charging current channel represents
 battery charging current in mA.
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
