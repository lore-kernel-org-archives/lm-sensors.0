From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 28 May 2011 04:51:13 +0000
Subject: [lm-sensors] MAX6642 chip detection and other stuff
Message-Id: <20110528045113.GA8833@ericsson.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by imr3.ericy.com id p4S4pDxH000834

Hi all,

I finally got MAX6642 samples, so I am able to play around with the chip.

The attached patch (on top of Per's most recent patch) works quite nicely.
Per, maybe you can just merge it with your patch and resubmit it.

While testing the chip, I found another little problem: the fault attribu=
te is named
temp_fault. That will have to be renamed to temp2_fault, first because it=
 reflects
a fault with the external diode and second to match the ABI. We will need=
 a separate
patch to fix this problem.

Here is the output of i2cdump for the MAX6642 (with open/unconnected exte=
rnal sensor).

root@groeck-desktop:/home/groeck# i2cdump -y 5 0x48
No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 18 ff 84 10 10 46 46 78 78 78 78 78 78 78 78 78    ?.???FFxxxxxxxxx
10: c0 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40    ?@@@@@@@@@@@@@@@
20: 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40    @@@@@@@@@@@@@@@@
30: 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40    @@@@@@@@@@@@@@@@
40: 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40    @@@@@@@@@@@@@@@@
50: 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40    @@@@@@@@@@@@@@@@
60: 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40    @@@@@@@@@@@@@@@@
70: 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40    @@@@@@@@@@@@@@@@
80: 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40    @@@@@@@@@@@@@@@@
90: 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40    @@@@@@@@@@@@@@@@
a0: 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40    @@@@@@@@@@@@@@@@
b0: 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40    @@@@@@@@@@@@@@@@
c0: 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40    @@@@@@@@@@@@@@@@
d0: 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40    @@@@@@@@@@@@@@@@
e0: 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40 40    @@@@@@@@@@@@@@@@
f0: 40 40 40 40 40 40 40 40 40 40 40 40 40 40 4d 4d    @@@@@@@@@@@@@@MM
root@groeck-desktop:/home/groeck# modprobe max6642
root@groeck-desktop:/home/groeck# sensors
max6642-i2c-5-48
Adapter: i2c-devantech-iss at bus 001 device 007
temp1:        +24.0=B0C  (high =3D +70.0=B0C)
temp2:          FAULT  (high =3D +120.0=B0C)

Thanks,
Guenter

--0F1p//8PRICkK4MW
Content-Type: text/x-diff; charset="us-ascii"
Content-Disposition: attachment;
	filename="0001-hwmon-max6642-Improve-chip-detection.patch"

From 197b9b4fb23c372de6d08afad4a0ebd72cfaadc6 Mon Sep 17 00:00:00 2001
From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 27 May 2011 21:39:59 -0700
Subject: [PATCH] hwmon: (max6642) Improve chip detection

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/max6642.c |   35 ++++++++++++++++++-----------------
 1 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/hwmon/max6642.c b/drivers/hwmon/max6642.c
index 872155e..160853c 100644
--- a/drivers/hwmon/max6642.c
+++ b/drivers/hwmon/max6642.c
@@ -64,14 +64,6 @@ static const unsigned short normal_i2c[] = {
 #define MAX6642_REG_W_REMOTE_HIGH	0x0D
 
 /*
- * Registers for detection tests. These registers are not present and,
- * when read, will only return the last valid register read.
- */
-#define MAX6642_REG_R_DUMMY_1          0x04
-#define MAX6642_REG_R_DUMMY_2          0x06
-#define MAX6642_REG_R_DUMMY_3          0xFF
-
-/*
  * Conversions
  */
 
@@ -134,7 +126,7 @@ static int max6642_detect(struct i2c_client *client,
 			  struct i2c_board_info *info)
 {
 	struct i2c_adapter *adapter = client->adapter;
-	u8 reg_config, reg_status, man_id, dummy_reg;
+	u8 reg_config, reg_status, man_id;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
@@ -145,16 +137,13 @@ static int max6642_detect(struct i2c_client *client,
 		return -ENODEV;
 
 	/* sanity check */
-	dummy_reg = i2c_smbus_read_byte_data(client, MAX6642_REG_R_DUMMY_1);
-	if (dummy_reg != 0x4D)
+	if (i2c_smbus_read_byte_data(client, 0x04) != 0x4D)
 		return -ENODEV;
 
-	dummy_reg = i2c_smbus_read_byte_data(client, MAX6642_REG_R_DUMMY_2);
-	if (dummy_reg != 0x4D)
+	if (i2c_smbus_read_byte_data(client, 0x06) != 0x4D)
 		return -ENODEV;
 
-	dummy_reg = i2c_smbus_read_byte_data(client, MAX6642_REG_R_DUMMY_3);
-	if (dummy_reg != 0x4D)
+	if (i2c_smbus_read_byte_data(client, 0xff) != 0x4D)
 		return -ENODEV;
 
 	/*
@@ -163,9 +152,21 @@ static int max6642_detect(struct i2c_client *client,
 	 * zero in the status register.
 	 */
 	reg_config = i2c_smbus_read_byte_data(client, MAX6642_REG_R_CONFIG);
+	if ((reg_config & 0x0f) != 0x00)
+		return -ENODEV;
+
+	/* in between, another round of sanity checks */
+	if (i2c_smbus_read_byte_data(client, 0x04) != reg_config)
+		return -ENODEV;
+
+	if (i2c_smbus_read_byte_data(client, 0x06) != reg_config)
+		return -ENODEV;
+
+	if (i2c_smbus_read_byte_data(client, 0xff) != reg_config)
+		return -ENODEV;
+
 	reg_status = i2c_smbus_read_byte_data(client, MAX6642_REG_R_STATUS);
-	if (((reg_config & 0x0f) != 0x00) ||
-	    ((reg_status & 0x2b) != 0x00))
+	if ((reg_status & 0x2b) != 0x00)
 		return -ENODEV;
 
 	strlcpy(info->type, "max6642", I2C_NAME_SIZE);
-- 
1.7.3.1


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--0F1p//8PRICkK4MW--
