From: <Yuantian.Tang@freescale.com>
Date: Wed, 19 Jun 2013 06:50:20 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (ina2xx) Add device tree support to pass the shunt resistor
Message-Id: <1371624620-14254-1-git-send-email-Yuantian.Tang@freescale.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@roeck-us.net
Cc: Tang Yuantian <Yuantian.Tang@freescale.com>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, lm-sensors@lm-sensors.org

From: Tang Yuantian <yuantian.tang@freescale.com>

Adding another way that is device tree to pass the shunt resistor
value to driver except for platform data.

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
v2:
	- add device tree bindings file
	- refine the code per Guenter's suggestion

 Documentation/devicetree/bindings/i2c/ina2xx.txt | 22 ++++++++++++++++++++++
 Documentation/hwmon/ina2xx                       |  4 +++-
 drivers/hwmon/ina2xx.c                           |  4 ++++
 3 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/ina2xx.txt

diff --git a/Documentation/devicetree/bindings/i2c/ina2xx.txt b/Documentation/devicetree/bindings/i2c/ina2xx.txt
new file mode 100644
index 0000000..a2ad85d
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/ina2xx.txt
@@ -0,0 +1,22 @@
+ina2xx properties
+
+Required properties:
+- compatible: Must be one of the following:
+	- "ti,ina219" for ina219
+	- "ti,ina220" for ina220
+	- "ti,ina226" for ina226
+	- "ti,ina230" for ina230
+- reg: I2C address
+
+Optional properties:
+
+- shunt-resistor
+	Shunt resistor value in micro-Ohm
+
+Example:
+
+ina220@44 {
+	compatible = "ti,ina220";
+	reg = <0x44>;
+	shunt-resistor = <1000>;
+};
diff --git a/Documentation/hwmon/ina2xx b/Documentation/hwmon/ina2xx
index 03444f9..4223c2d 100644
--- a/Documentation/hwmon/ina2xx
+++ b/Documentation/hwmon/ina2xx
@@ -44,4 +44,6 @@ The INA226 monitors both a shunt voltage drop and bus supply voltage.
 The INA230 is a high or low side current shunt and power monitor with an I2C
 interface. The INA230 monitors both a shunt voltage drop and bus supply voltage.
 
-The shunt value in micro-ohms can be set via platform data.
+The shunt value in micro-ohms can be set via platform data or device tree.
+Please refer to the Documentation/devicetree/bindings/i2c/ina2xx.txt for bindings
+if the device tree is used.
diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
index 4958b2f..a52d5f0 100644
--- a/drivers/hwmon/ina2xx.c
+++ b/drivers/hwmon/ina2xx.c
@@ -221,6 +221,7 @@ static int ina2xx_probe(struct i2c_client *client,
 	struct ina2xx_data *data;
 	struct ina2xx_platform_data *pdata;
 	int ret;
+	u32 val;
 	long shunt = 10000; /* default shunt value 10mOhms */
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_WORD_DATA))
@@ -234,6 +235,9 @@ static int ina2xx_probe(struct i2c_client *client,
 		pdata  		  (struct ina2xx_platform_data *)client->dev.platform_data;
 		shunt = pdata->shunt_uohms;
+	} else if (!of_property_read_u32(client->dev.of_node,
+				"shunt-resistor", &val)) {
+			shunt = val;
 	}
 
 	if (shunt <= 0)
-- 
1.8.0



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
