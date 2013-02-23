From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 23 Feb 2013 02:19:29 +0000
Subject: [lm-sensors] [PATCH 1/7] hwmon: Update my e-mail address in driver documentation
Message-Id: <1361585975-5604-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Most of the hwmon driver documentation still listed my old invalid e-mail
address. Fix it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/adm1275     |    2 +-
 Documentation/hwmon/jc42        |    2 +-
 Documentation/hwmon/lineage-pem |    2 +-
 Documentation/hwmon/lm25066     |    2 +-
 Documentation/hwmon/ltc2978     |    2 +-
 Documentation/hwmon/ltc4261     |    2 +-
 Documentation/hwmon/max16064    |    2 +-
 Documentation/hwmon/max16065    |    2 +-
 Documentation/hwmon/max34440    |    2 +-
 Documentation/hwmon/max8688     |    2 +-
 Documentation/hwmon/pmbus       |    2 +-
 Documentation/hwmon/smm665      |    2 +-
 Documentation/hwmon/ucd9000     |    2 +-
 Documentation/hwmon/ucd9200     |    2 +-
 Documentation/hwmon/zl6100      |    2 +-
 15 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/hwmon/adm1275 b/Documentation/hwmon/adm1275
index 2cfa256..15b4a20 100644
--- a/Documentation/hwmon/adm1275
+++ b/Documentation/hwmon/adm1275
@@ -15,7 +15,7 @@ Supported chips:
     Addresses scanned: -
     Datasheet: www.analog.com/static/imported-files/data_sheets/ADM1276.pdf
 
-Author: Guenter Roeck <guenter.roeck@ericsson.com>
+Author: Guenter Roeck <linux@roeck-us.net>
 
 
 Description
diff --git a/Documentation/hwmon/jc42 b/Documentation/hwmon/jc42
index 1650771..868d74d 100644
--- a/Documentation/hwmon/jc42
+++ b/Documentation/hwmon/jc42
@@ -49,7 +49,7 @@ Supported chips:
     Addresses scanned: I2C 0x18 - 0x1f
 
 Author:
-	Guenter Roeck <guenter.roeck@ericsson.com>
+	Guenter Roeck <linux@roeck-us.net>
 
 
 Description
diff --git a/Documentation/hwmon/lineage-pem b/Documentation/hwmon/lineage-pem
index 2ba5ed1..83b2ddc 100644
--- a/Documentation/hwmon/lineage-pem
+++ b/Documentation/hwmon/lineage-pem
@@ -8,7 +8,7 @@ Supported devices:
     Documentation:
         http://www.lineagepower.com/oem/pdf/CPLI2C.pdf
 
-Author: Guenter Roeck <guenter.roeck@ericsson.com>
+Author: Guenter Roeck <linux@roeck-us.net>
 
 
 Description
diff --git a/Documentation/hwmon/lm25066 b/Documentation/hwmon/lm25066
index a21db81..26025e4 100644
--- a/Documentation/hwmon/lm25066
+++ b/Documentation/hwmon/lm25066
@@ -19,7 +19,7 @@ Supported chips:
     Datasheet:
 	http://www.national.com/pf/LM/LM5066.html
 
-Author: Guenter Roeck <guenter.roeck@ericsson.com>
+Author: Guenter Roeck <linux@roeck-us.net>
 
 
 Description
diff --git a/Documentation/hwmon/ltc2978 b/Documentation/hwmon/ltc2978
index c365f9b..1642348 100644
--- a/Documentation/hwmon/ltc2978
+++ b/Documentation/hwmon/ltc2978
@@ -11,7 +11,7 @@ Supported chips:
     Addresses scanned: -
     Datasheet: http://cds.linear.com/docs/Datasheet/3880f.pdf
 
-Author: Guenter Roeck <guenter.roeck@ericsson.com>
+Author: Guenter Roeck <linux@roeck-us.net>
 
 
 Description
diff --git a/Documentation/hwmon/ltc4261 b/Documentation/hwmon/ltc4261
index eba2e2c..9378a75 100644
--- a/Documentation/hwmon/ltc4261
+++ b/Documentation/hwmon/ltc4261
@@ -8,7 +8,7 @@ Supported chips:
     Datasheet:
         http://cds.linear.com/docs/Datasheet/42612fb.pdf
 
-Author: Guenter Roeck <guenter.roeck@ericsson.com>
+Author: Guenter Roeck <linux@roeck-us.net>
 
 
 Description
diff --git a/Documentation/hwmon/max16064 b/Documentation/hwmon/max16064
index f8b4780..d59cc78 100644
--- a/Documentation/hwmon/max16064
+++ b/Documentation/hwmon/max16064
@@ -7,7 +7,7 @@ Supported chips:
     Addresses scanned: -
     Datasheet: http://datasheets.maxim-ic.com/en/ds/MAX16064.pdf
 
-Author: Guenter Roeck <guenter.roeck@ericsson.com>
+Author: Guenter Roeck <linux@roeck-us.net>
 
 
 Description
diff --git a/Documentation/hwmon/max16065 b/Documentation/hwmon/max16065
index c11f64a..208a29e 100644
--- a/Documentation/hwmon/max16065
+++ b/Documentation/hwmon/max16065
@@ -24,7 +24,7 @@ Supported chips:
 	http://datasheets.maxim-ic.com/en/ds/MAX16070-MAX16071.pdf
 
 
-Author: Guenter Roeck <guenter.roeck@ericsson.com>
+Author: Guenter Roeck <linux@roeck-us.net>
 
 
 Description
diff --git a/Documentation/hwmon/max34440 b/Documentation/hwmon/max34440
index 47651ff..37cbf47 100644
--- a/Documentation/hwmon/max34440
+++ b/Documentation/hwmon/max34440
@@ -27,7 +27,7 @@ Supported chips:
     Addresses scanned: -
     Datasheet: http://datasheets.maximintegrated.com/en/ds/MAX34461.pdf
 
-Author: Guenter Roeck <guenter.roeck@ericsson.com>
+Author: Guenter Roeck <linux@roeck-us.net>
 
 
 Description
diff --git a/Documentation/hwmon/max8688 b/Documentation/hwmon/max8688
index fe84987..e780786 100644
--- a/Documentation/hwmon/max8688
+++ b/Documentation/hwmon/max8688
@@ -7,7 +7,7 @@ Supported chips:
     Addresses scanned: -
     Datasheet: http://datasheets.maxim-ic.com/en/ds/MAX8688.pdf
 
-Author: Guenter Roeck <guenter.roeck@ericsson.com>
+Author: Guenter Roeck <linux@roeck-us.net>
 
 
 Description
diff --git a/Documentation/hwmon/pmbus b/Documentation/hwmon/pmbus
index 3d3a0f9..cf756ed 100644
--- a/Documentation/hwmon/pmbus
+++ b/Documentation/hwmon/pmbus
@@ -34,7 +34,7 @@ Supported chips:
     Addresses scanned: -
     Datasheet: n.a.
 
-Author: Guenter Roeck <guenter.roeck@ericsson.com>
+Author: Guenter Roeck <linux@roeck-us.net>
 
 
 Description
diff --git a/Documentation/hwmon/smm665 b/Documentation/hwmon/smm665
index 59e3161..a341eee 100644
--- a/Documentation/hwmon/smm665
+++ b/Documentation/hwmon/smm665
@@ -29,7 +29,7 @@ Supported chips:
       http://www.summitmicro.com/prod_select/summary/SMM766/SMM766_2086.pdf
       http://www.summitmicro.com/prod_select/summary/SMM766B/SMM766B_2122.pdf
 
-Author: Guenter Roeck <guenter.roeck@ericsson.com>
+Author: Guenter Roeck <linux@roeck-us.net>
 
 
 Module Parameters
diff --git a/Documentation/hwmon/ucd9000 b/Documentation/hwmon/ucd9000
index 0df5f27..805e33e 100644
--- a/Documentation/hwmon/ucd9000
+++ b/Documentation/hwmon/ucd9000
@@ -11,7 +11,7 @@ Supported chips:
 	http://focus.ti.com/lit/ds/symlink/ucd9090.pdf
 	http://focus.ti.com/lit/ds/symlink/ucd90910.pdf
 
-Author: Guenter Roeck <guenter.roeck@ericsson.com>
+Author: Guenter Roeck <linux@roeck-us.net>
 
 
 Description
diff --git a/Documentation/hwmon/ucd9200 b/Documentation/hwmon/ucd9200
index fd7d07b..1e8060e 100644
--- a/Documentation/hwmon/ucd9200
+++ b/Documentation/hwmon/ucd9200
@@ -15,7 +15,7 @@ Supported chips:
 	http://focus.ti.com/lit/ds/symlink/ucd9246.pdf
 	http://focus.ti.com/lit/ds/symlink/ucd9248.pdf
 
-Author: Guenter Roeck <guenter.roeck@ericsson.com>
+Author: Guenter Roeck <linux@roeck-us.net>
 
 
 Description
diff --git a/Documentation/hwmon/zl6100 b/Documentation/hwmon/zl6100
index 3d924b6..756b57c 100644
--- a/Documentation/hwmon/zl6100
+++ b/Documentation/hwmon/zl6100
@@ -54,7 +54,7 @@ http://archive.ericsson.net/service/internet/picov/get?DocNo(701-EN/LZT146401
 http://archive.ericsson.net/service/internet/picov/get?DocNo(701-EN/LZT146256
 
 
-Author: Guenter Roeck <guenter.roeck@ericsson.com>
+Author: Guenter Roeck <linux@roeck-us.net>
 
 
 Description
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
