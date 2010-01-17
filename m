From: Luca Tettamanti <kronos.it@gmail.com>
Date: Sun, 17 Jan 2010 22:05:34 +0000
Subject: [lm-sensors] [PATCH] hwmon: (asus_atk0110) Do not fail if MBIF is
Message-Id: <20100117220534.GA6226@nb-core2.darkstar.lan>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

MBIF (motherboard identification) is only used to print the name of the board,
it's not essential for the driver; do not fail if it's missing.
Based on Juan's patch.

Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>
---
Juan, can sign off the patch?

 drivers/hwmon/asus_atk0110.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
index fe4fa29..0729022 100644
--- a/drivers/hwmon/asus_atk0110.c
+++ b/drivers/hwmon/asus_atk0110.c
@@ -921,17 +921,16 @@ static int atk_add(struct acpi_device *device)
 			&buf, ACPI_TYPE_PACKAGE);
 	if (ret != AE_OK) {
 		dev_dbg(&device->dev, "atk: method MBIF not found\n");
-		err = -ENODEV;
-		goto out;
-	}
-
-	obj = buf.pointer;
-	if (obj->package.count >= 2 &&
-			obj->package.elements[1].type = ACPI_TYPE_STRING) {
-		dev_dbg(&device->dev, "board ID = %s\n",
-				obj->package.elements[1].string.pointer);
+	} else {
+		obj = buf.pointer;
+		if (obj->package.count >= 2) {
+			union acpi_object *id = &obj->package.elements[1];
+			if (id->type = ACPI_TYPE_STRING)
+				dev_dbg(&device->dev, "board ID = %s\n",
+					id->string.pointer);
+		}
+		ACPI_FREE(buf.pointer);
 	}
-	ACPI_FREE(buf.pointer);
 
 	/* Check for hwmon methods: first check "old" style methods; note that
 	 * both may be present: in this case we stick to the old interface;

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
