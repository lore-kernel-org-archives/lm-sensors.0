From: daniel.n.nilsson@home.se (Daniel Nilsson)
Date: Mon, 28 Nov 2005 20:07:56 +0000
Subject: [lm-sensors] Kernel hangs with i2c-i801 driver?
Message-Id: <20051128190617.GA9730@oden.homeip.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051123100021.GA29473@oden.homeip.net>
In-Reply-To: <20051123100021.GA29473@oden.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

On Mon, Nov 28, 2005 at 01:31:34PM +0100, Jean Delvare wrote:
> > - 	device_create_file_fan(new_client, 6);
> > +	if ( val1 & 0x40 )
> > +		device_create_file_fan(new_client, 6);
> >
> > Because fan6 and fan7 - mean their pins are programmable so correct would
> > be to create their files when they actual outputs are really used for
> > fans...
> 
> Same is true for fan4 and fan5 according to the datasheet, they can be
> used as GPIO pins. Register to check is 0x1A, mask 0x40 for fan4 and
> 0x20 for fan5.

This is the complete patch I've been using against what is in kernel
2.6.14, it should include the previous changes as well as the above
checks for fan4 and fan5 (if I understood the datasheet and your
comments correctly):

--- w83792d.c.orig	2005-11-28 19:15:13.000000000 +0100
+++ w83792d.c	2005-11-28 19:16:05.000000000 +0100
@@ -193,6 +193,7 @@
 	  0xE2 }	/* (bit3-0) SmartFanII: Fan3 Level 3 */
 };
 
+#define W83792D_REG_GPIO		0x1A
 #define W83792D_REG_CONFIG		0x40
 #define W83792D_REG_VID_FANDIV		0x47
 #define W83792D_REG_CHIPID		0x49
@@ -257,7 +258,7 @@
 {
 	int i;
 	val = SENSORS_LIMIT(val, 1, 128) >> 1;
-	for (i = 0; i < 6; i++) {
+	for (i = 0; i < 7; i++) {
 		if (val = 0)
 			break;
 		val >>= 1;
@@ -1284,9 +1285,9 @@
 	w83792d_init_client(new_client);
 
 	/* A few vars need to be filled upon startup */
-	for (i = 1; i <= 7; i++) {
-		data->fan_min[i - 1] = w83792d_read_value(new_client,
-					W83792D_REG_FAN_MIN[i]);
+	for (i = 0; i < 7; i++) {
+	  data->fan_min[i] = w83792d_read_value(new_client,
+						W83792D_REG_FAN_MIN[i]);
 	}
 
 	/* Register sysfs hooks */
@@ -1308,10 +1309,20 @@
 	device_create_file_fan(new_client, 1);
 	device_create_file_fan(new_client, 2);
 	device_create_file_fan(new_client, 3);
-	device_create_file_fan(new_client, 4);
-	device_create_file_fan(new_client, 5);
-	device_create_file_fan(new_client, 6);
-	device_create_file_fan(new_client, 7);
+
+	/* Read GPIO register to check if inputs for fan 4,5 are used as GPIO */
+	val1 = w83792d_read_value(new_client, W83792D_REG_GPIO);
+	if (!( val1 & 0x40 ))
+	  device_create_file_fan(new_client, 4);
+	if (!( val1 & 0x20 ))
+	  device_create_file_fan(new_client, 5);
+
+	val1 = w83792d_read_value(new_client, W83792D_REG_PIN);
+	if ( val1 & 0x40 )
+	  device_create_file_fan(new_client, 6);
+	if ( val1 & 0x04 )
+	  device_create_file_fan(new_client, 7);
+
 
 	device_create_file_temp1(new_client);		/* Temp1 */
 	device_create_file_temp_add(new_client, 2);	/* Temp2 */

> Daniel, we are progressing but I still have no clear idea about what
> exactly is causing the hang. One interesting test would be to try direct
> SMBus writes without using the w83792d driver. If you can reproduce the
> hang, then the w83792d driver is not faulty. If you cannot, they we
> probably have a bug in the w83792d driver. This wouldn't be all that
> surprising, the driver is relatively new and the chip is quite complex.
> 
> You can use the i2cset program to write to the W83792D chip directly. You
> can try using the following commands in your script, without loading the
> w83792d driver. Let us know if it hangs of not.
> 
> i2cset -y 0 0x2c 0x2b 0xff # in0_max
> i2cset -y 0 0x2c 0x2c 0x00 # in0_min
> i2cset -y 0 0x2c 0x2d 0xff # in1_max
> i2cset -y 0 0x2c 0x2e 0x00 # in1_min
> i2cset -y 0 0x2c 0x2f 0xff # in2_max
> i2cset -y 0 0x2c 0x30 0x00 # in2_min
> i2cset -y 0 0x2c 0x31 0xff # in3_max
> i2cset -y 0 0x2c 0x32 0x00 # in3_min
> i2cset -y 0 0x2c 0x33 0xff # in4_max
> i2cset -y 0 0x2c 0x34 0x00 # in4_min
> i2cset -y 0 0x2c 0x35 0xff # in5_max
> i2cset -y 0 0x2c 0x36 0x00 # in5_min
> i2cset -y 0 0x2c 0x37 0xff # in6_max
> i2cset -y 0 0x2c 0x38 0x00 # in6_min
> i2cset -y 0 0x2c 0xb4 0xff # in7_max
> i2cset -y 0 0x2c 0xb5 0x00 # in7_min
> i2cset -y 0 0x2c 0xb6 0xff # in8_max
> i2cset -y 0 0x2c 0xb7 0x00 # in8_min
> i2cset -y 0 0x2c 0x39 0x7f # temp1_max
> i2cset -y 0 0x2c 0x3a 0x00 # temp1_min
> i2cset -y 0 0x2c 0xc3 0x7c # temp2_max_hyst
> i2cset -y 0 0x2c 0xc5 0x7f # temp2_max
> i2cset -y 0 0x2c 0xcb 0x7c # temp3_max_hyst
> i2cset -y 0 0x2c 0xcd 0x7f # temp3_max
> i2cset -y 0 0x2c 0x3b 0xff # fan1_min
> i2cset -y 0 0x2c 0x3c 0xff # fan2_min
> i2cset -y 0 0x2c 0x3d 0xff # fan3_min
> i2cset -y 0 0x2c 0xbb 0xff # fan4_min
> i2cset -y 0 0x2c 0xbc 0xff # fan5_min
> i2cset -y 0 0x2c 0xbd 0xff # fan6_min
> i2cset -y 0 0x2c 0xbf 0xff # fan7_min

[snip]

So I tried the direct SMBus writes without even loading the w83792d
driver after a reboot. The machine still hangs... I don't get the hang
at the exact same place, but the order in which you have the writes
suggested is slighly different then my own scripts so that probably
doesn't say much.

This is the output of the script:

oden:~# ./set_safe_direct.sh
+ i2cset -y 0 0x2c 0x2b 0xff
No size specified (using byte-data access)
Value 0xff written, readback matched
+ i2cset -y 0 0x2c 0x2c 0x00
No size specified (using byte-data access)
Value 0x00 written, readback matched
+ i2cset -y 0 0x2c 0x2d 0xff
No size specified (using byte-data access)
Value 0xff written, readback matched
+ i2cset -y 0 0x2c 0x2e 0x00
No size specified (using byte-data access)
Value 0x00 written, readback matched
+ i2cset -y 0 0x2c 0x2f 0xff
No size specified (using byte-data access)
Value 0xff written, readback matched
+ i2cset -y 0 0x2c 0x30 0x00
No size specified (using byte-data access)
Value 0x00 written, readback matched
+ i2cset -y 0 0x2c 0x31 0xff
No size specified (using byte-data access)
Value 0xff written, readback matched
+ i2cset -y 0 0x2c 0x32 0x00
No size specified (using byte-data access)
Value 0x00 written, readback matched
+ i2cset -y 0 0x2c 0x33 0xff
No size specified (using byte-data access)
Value 0xff written, readback matched
+ i2cset -y 0 0x2c 0x34 0x00
No size specified (using byte-data access)
Value 0x00 written, readback matched
+ i2cset -y 0 0x2c 0x35 0xff
No size specified (using byte-data access)
Value 0xff written, readback matched
+ i2cset -y 0 0x2c 0x36 0x00
No size specified (using byte-data access)
Value 0x00 written, readback matched
+ i2cset -y 0 0x2c 0x37 0xff
No size specified (using byte-data access)
Value 0xff written, readback matched
+ i2cset -y 0 0x2c 0x38 0x00
No size specified (using byte-data access)
Value 0x00 written, readback matched
+ i2cset -y 0 0x2c 0xb4 0xff
No size specified (using byte-data access)
Value 0xff written, readback matched
+ i2cset -y 0 0x2c 0xb5 0x00
No size specified (using byte-data access)
Value 0x00 written, readback matched
+ i2cset -y 0 0x2c 0xb6 0xff
No size specified (using byte-data access)
Value 0xff written, readback matched
+ i2cset -y 0 0x2c 0xb7 0x00
No size specified (using byte-data access)
Value 0x00 written, readback matched
+ i2cset -y 0 0x2c 0x39 0x7f
No size specified (using byte-data access)
Value 0x7f written, readback matched
+ i2cset -y 0 0x2c 0x3a 0x00
No size specified (using byte-data access)
Value 0x00 written, readback matched
+ i2cset -y 0 0x2c 0xc3 0x7c
No size specified (using byte-data access)
Value 0x7c written, readback matched
+ i2cset -y 0 0x2c 0xc5 0x7f
No size specified (using byte-data access)
Value 0x7f written, readback matched
+ i2cset -y 0 0x2c 0xcb 0x7c
No size specified (using byte-data access)
Value 0x7c written, readback matched
+ i2cset -y 0 0x2c 0xcd 0x7f
No size specified (using byte-data access)
Value 0x7f written, readback matched
+ i2cset -y 0 0x2c 0x3b 0xff
No size specified (using byte-data access)
Value 0xff written, readback matched
+ i2cset -y 0 0x2c 0x3c 0xff
No size specified (using byte-data access)
Value 0xff written, readback matched
+ i2cset -y 0 0x2c 0x3d 0xff
No size specified (using byte-data access)
Value 0xff written, readback matched
+ i2cset -y 0 0x2c 0xbb 0xff
No size specified (using byte-data access)
Value 0xff written, readback matched
+ i2cset -y 0 0x2c 0xbc 0xff
No size specified (using byte-data access)
Value 0xff written, readback matched
+ i2cset -y 0 0x2c 0xbd 0xff
No size specified (using byte-data access)
Value 0xff written, readback matched
+ i2cset -y 0 0x2c 0xbf 0xff
No size specified (using byte-data access)
<here the machine hangs>

I guess we can rule out the w83792d driver since that one isn't even
loaded at this point.

Best regards
-- 
Daniel Nilsson
