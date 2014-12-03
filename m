From: Bartosz Golaszewski <bartekgola@gmail.com>
Date: Wed, 03 Dec 2014 10:54:14 +0000
Subject: [lm-sensors] [PATCH v3 3/3] hwmon: ina2xx: documentation update for new sysfs attributes
Message-Id: <1417604054-8694-4-git-send-email-bartekgola@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1417604054-8694-1-git-send-email-bartekgola@gmail.com>
In-Reply-To: <1417604054-8694-1-git-send-email-bartekgola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Benoit Cousson <bcousson@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, LM Sensors <lm-sensors@lm-sensors.org>, Bartosz Golaszewski <bartekgola@gmail.com>

Include the rshunt and avg sysfs attributes for ina2xx in the documentation.

Signed-off-by: Bartosz Golaszewski <bartekgola@gmail.com>
---
 Documentation/hwmon/ina2xx | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/hwmon/ina2xx b/Documentation/hwmon/ina2xx
index 4223c2d..c100c24 100644
--- a/Documentation/hwmon/ina2xx
+++ b/Documentation/hwmon/ina2xx
@@ -44,6 +44,10 @@ The INA226 monitors both a shunt voltage drop and bus supply voltage.
 The INA230 is a high or low side current shunt and power monitor with an I2C
 interface. The INA230 monitors both a shunt voltage drop and bus supply voltage.
 
-The shunt value in micro-ohms can be set via platform data or device tree.
-Please refer to the Documentation/devicetree/bindings/i2c/ina2xx.txt for bindings
-if the device tree is used.
+The shunt value in micro-ohms can be set via platform data or device tree in
+compile-time or via the shunt_resistor attribute in sysfs in run-time. Please
+refer to the Documentation/devicetree/bindings/i2c/ina2xx.txt for bindings if
+the device tree is used.
+
+The averaging rate of INA226 and INA230 can be changed via the avg_rate sysfs
+attribute. The available rates are: 1, 4, 16, 64, 128, 256, 512 and 1024.
-- 
2.1.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
