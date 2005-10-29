From: gregkh@suse.de (Greg KH)
Date: Sat, 29 Oct 2005 01:30:50 +0000
Subject: [lm-sensors] [PATCH] hwmon: Fix w83627ehf/hf vs PNPACPI conflict
Message-Id: <11305336603994@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] hwmon: Fix w83627ehf/hf vs PNPACPI conflict (bug #4014)

This patch changes w83627hf and w83627ehf drivers to reserve only ports
0x295-0x296, instead of full 0x290-0x297 range.  While some other
sensors chips respond to all addresses in 0x290-0x297 range, Winbond
chips respond to 0x295-0x296 only (this behavior is implied by
documentation, and matches behavior observed on real systems).  This is
not problem alone, as no BIOS was found to put something at these unused
addresses, and sensors chip itself provides nothing there as well.

But in addition to only respond to these two addresses, also BIOS
vendors report in their ACPI-PnP structures that there is some resource
at I/O address 0x295 of length 2.  And when later this hwmon driver
attempts to request region with base 0x290/length 8, it fails as one
request_region cannot span more than one device.

Due to this we have to ask only for region this hardware really
occupies, otherwise driver cannot be loaded on systems with ACPI-PnP
enabled.

Signed-off-by: Petr Vandrovec <vandrove@vc.cvut.cz>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit ada0c2f8fa087dc1dbc34e096c318739b1d6381a
tree e7f80d1336e2190c138fd4226438195e2f67839d
parent bf813b314a2271c3f3903eb3279ebf5e09b3d27a
author Petr Vandrovec <vandrove@vc.cvut.cz> Fri, 07 Oct 2005 23:11:03 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 28 Oct 2005 14:02:09 -0700

 drivers/hwmon/w83627ehf.c |   13 ++++++++-----
 drivers/hwmon/w83627hf.c  |   21 +++++++++++++--------
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index b60efe8..685eeb7 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -105,7 +105,9 @@ superio_exit(void)
  * ISA constants
  */
 
-#define REGION_LENGTH		8
+#define REGION_ALIGNMENT	~7
+#define REGION_OFFSET		5
+#define REGION_LENGTH		2
 #define ADDR_REG_OFFSET		5
 #define DATA_REG_OFFSET		6
 
@@ -673,7 +675,8 @@ static int w83627ehf_detect(struct i2c_a
 	struct w83627ehf_data *data;
 	int i, err = 0;
 
-	if (!request_region(address, REGION_LENGTH, w83627ehf_driver.name)) {
+	if (!request_region(address + REGION_OFFSET, REGION_LENGTH,
+	                    w83627ehf_driver.name)) {
 		err = -EBUSY;
 		goto exit;
 	}
@@ -762,7 +765,7 @@ exit_detach:
 exit_free:
 	kfree(data);
 exit_release:
-	release_region(address, REGION_LENGTH);
+	release_region(address + REGION_OFFSET, REGION_LENGTH);
 exit:
 	return err;
 }
@@ -776,7 +779,7 @@ static int w83627ehf_detach_client(struc
 
 	if ((err = i2c_detach_client(client)))
 		return err;
-	release_region(client->addr, REGION_LENGTH);
+	release_region(client->addr + REGION_OFFSET, REGION_LENGTH);
 	kfree(data);
 
 	return 0;
@@ -807,7 +810,7 @@ static int __init w83627ehf_find(int sio
 	superio_select(W83627EHF_LD_HWM);
 	val = (superio_inb(SIO_REG_ADDR) << 8)
 	    | superio_inb(SIO_REG_ADDR + 1);
-	*addr = val & ~(REGION_LENGTH - 1);
+	*addr = val & REGION_ALIGNMENT;
 	if (*addr = 0) {
 		superio_exit();
 		return -ENODEV;
diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
index 7f6f728..494274d 100644
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -142,10 +142,14 @@ superio_exit(void)
 #define WINB_BASE_REG 0x60
 /* Constants specified below */
 
-/* Length of ISA address segment */
-#define WINB_EXTENT 8
+/* Alignment of the base address */
+#define WINB_ALIGNMENT		~7
 
-/* Where are the ISA address/data registers relative to the base address */
+/* Offset & size of I/O region we are interested in */
+#define WINB_REGION_OFFSET	5
+#define WINB_REGION_SIZE	2
+
+/* Where are the sensors address/data registers relative to the base address */
 #define W83781D_ADDR_REG_OFFSET 5
 #define W83781D_DATA_REG_OFFSET 6
 
@@ -981,7 +985,7 @@ static int __init w83627hf_find(int sioa
 	superio_select(W83627HF_LD_HWM);
 	val = (superio_inb(WINB_BASE_REG) << 8) |
 	       superio_inb(WINB_BASE_REG + 1);
-	*addr = val & ~(WINB_EXTENT - 1);
+	*addr = val & WINB_ALIGNMENT;
 	if (*addr = 0 && force_addr = 0) {
 		superio_exit();
 		return -ENODEV;
@@ -1000,9 +1004,10 @@ static int w83627hf_detect(struct i2c_ad
 	const char *client_name = "";
 
 	if(force_addr)
-		address = force_addr & ~(WINB_EXTENT - 1);
+		address = force_addr & WINB_ALIGNMENT;
 
-	if (!request_region(address, WINB_EXTENT, w83627hf_driver.name)) {
+	if (!request_region(address + WINB_REGION_OFFSET, WINB_REGION_SIZE,
+	                    w83627hf_driver.name)) {
 		err = -EBUSY;
 		goto ERROR0;
 	}
@@ -1148,7 +1153,7 @@ static int w83627hf_detect(struct i2c_ad
       ERROR2:
 	kfree(data);
       ERROR1:
-	release_region(address, WINB_EXTENT);
+	release_region(address + WINB_REGION_OFFSET, WINB_REGION_SIZE);
       ERROR0:
 	return err;
 }
@@ -1163,7 +1168,7 @@ static int w83627hf_detach_client(struct
 	if ((err = i2c_detach_client(client)))
 		return err;
 
-	release_region(client->addr, WINB_EXTENT);
+	release_region(client->addr + WINB_REGION_OFFSET, WINB_REGION_SIZE);
 	kfree(data);
 
 	return 0;

