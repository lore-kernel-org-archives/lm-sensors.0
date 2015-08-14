From: Dustin Byford <dustin@cumulusnetworks.com>
Date: Fri, 14 Aug 2015 19:37:14 +0000
Subject: [lm-sensors] [RFC 1/1] i2c: acpi: revert setting a "stable" device name
Message-Id: <1439581034-5972-2-git-send-email-dustin@cumulusnetworks.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1439581034-5972-1-git-send-email-dustin@cumulusnetworks.com>
In-Reply-To: <1439581034-5972-1-git-send-email-dustin@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jarkko.nikula@linux.intel.com, jdelvare@suse.com, linux@roeck-us.net, lm-sensors@lm-sensors.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org

70762ab from 11/2014 (i2c: Use stable dev_name for ACPI enumerated I2C
slaves) modified the sysfs-visible dev_name() for ACPI enumerated I2C
devices.  With that change, /sys/bus/i2c/devices/i2c-0-004a, for
example, became /sys/bus/i2c/devices/i2c-PNPXXXX:xx

That causes problems for userspace code such as 'sensors' which does
this:

lib/sysfs.c:665:
if ((!subsys || !strcmp(subsys, "i2c")) &&
    sscanf(dev_name, "%hd-%x", &entry.chip.bus.nr,
           &entry.chip.addr) = 2) {
...

Fix 'sensors' by reverting the kernel change.

Signed-off-by: Dustin Byford <dustin@cumulusnetworks.com>
---
 drivers/i2c/i2c-core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index c83e4d1..fb77031 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -916,13 +916,6 @@ EXPORT_SYMBOL_GPL(i2c_unlock_adapter);
 static void i2c_dev_set_name(struct i2c_adapter *adap,
 			     struct i2c_client *client)
 {
-	struct acpi_device *adev = ACPI_COMPANION(&client->dev);
-
-	if (adev) {
-		dev_set_name(&client->dev, "i2c-%s", acpi_dev_name(adev));
-		return;
-	}
-
 	/* For 10-bit clients, add an arbitrary offset to avoid collisions */
 	dev_set_name(&client->dev, "%d-%04x", i2c_adapter_id(adap),
 		     client->addr | ((client->flags & I2C_CLIENT_TEN)
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
