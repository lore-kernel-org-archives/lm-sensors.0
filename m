From: komoriya@paken.org (Takeru KOMORIYA)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: [PATCH 2.6] it87 Part2(reset option)
Message-Id: <20040226184435.18c4e01c.komoriya@paken.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040225111219.1c117787.komoriya@paken.org>
In-Reply-To: <20040225111219.1c117787.komoriya@paken.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Wed, 25 Feb 2004 14:12:39 +0100
Jean Delvare <khali@linux-fr.org> wrote:

> > +/* Reset the registers on init */
> > +static int reset = 0;
> 
> Do not initialize it explicitely to 0. It's done for you (if I'm not
> mistaking).

OK, I think update_vbat should be the same then. 

> > +	if ( reset ) {
> 
> No spaces inside the parentheses please (I know that the 2.4 driver
> do have spaces, I'll fix that).

Sorry, I fixed it.

> >  	it87_write_value(client, IT87_REG_VIN_MIN(0),
> >  			 IN_TO_REG(IT87_INIT_IN_MIN_0));
> 
> While we're at it, I'd suggest that you remove all limit
> initializations. They are already gone in the 2.4 driver, and almost
> all 2.6 drivers. The prefered way of setting these is from
> user-space(sensors -s). Don't forget to remove the associated
> comment (I'll do it in 2.4).

I agree with you. I've deleted these initializations.

> Also, now that the reset is optional, the rest of the init (enable
> all voltages, all temperatures and all fans) should depend on it. If
> you do not reset the registers, the values are supposed to be
> already correct. In the 2.4 driver, these initialisations are even
> completely gone. We should take a look at the datasheets. Maybe the
> value we are writing are the default (post-reset) values anyway, so
> writing them again is useless?

According to the datasheet, voltage scan, temperature channels and fan
tachometers are disabled at reset. We can enable temperature channels
from user-space, but not for voltages and thachometers.
So I think we should keep initializations for voltages and
thachometers, even if reset option is not given, because it may not be
guaranteed that these are always set by BIOS(especially if hardware
monitor features are disabled by BIOS settings).

> The only thing that should be kept (and has been in 2.4) is the
> monitoring start, of course (with or without reset). That said, I
> think that the 0xb7 mask is wrong and should be 0x36 (that too
> should be verified with the datasheets).

I looked into the datasheet and I think 0x36 is the right value(though
0xb7 may not cause problems).

> Please provide a new version of your patch doing all this. It will
> of course be a bit longer than your initial attempt.

I've attached my next trial patch below.

> Aligato.

Wow, you speak Japanese! Aligato!

--- it87.c.sensor_type	2004-02-25 10:27:21.000000000 +0900
+++ it87.c	2004-02-26 17:04:57.000000000 +0900
@@ -55,7 +55,10 @@
 
 
 /* Update battery voltage after every reading if true */
-static int update_vbat = 0;
+static int update_vbat;
+
+/* Reset the registers on init if true */
+static int reset;
 
 /* Many IT87 constants specified below */
 
@@ -825,77 +828,24 @@
 /* Called when we have found a new IT87. It should set limits, etc. */
 static void it87_init_client(struct i2c_client *client, struct it87_data *data)
 {
-	/* Reset all except Watchdog values and last conversion values
-	   This sets fan-divs to 2, among others */
-	it87_write_value(client, IT87_REG_CONFIG, 0x80);
-	it87_write_value(client, IT87_REG_VIN_MIN(0),
-			 IN_TO_REG(IT87_INIT_IN_MIN_0));
-	it87_write_value(client, IT87_REG_VIN_MAX(0),
-			 IN_TO_REG(IT87_INIT_IN_MAX_0));
-	it87_write_value(client, IT87_REG_VIN_MIN(1),
-			 IN_TO_REG(IT87_INIT_IN_MIN_1));
-	it87_write_value(client, IT87_REG_VIN_MAX(1),
-			 IN_TO_REG(IT87_INIT_IN_MAX_1));
-	it87_write_value(client, IT87_REG_VIN_MIN(2),
-			 IN_TO_REG(IT87_INIT_IN_MIN_2));
-	it87_write_value(client, IT87_REG_VIN_MAX(2),
-			 IN_TO_REG(IT87_INIT_IN_MAX_2));
-	it87_write_value(client, IT87_REG_VIN_MIN(3),
-			 IN_TO_REG(IT87_INIT_IN_MIN_3));
-	it87_write_value(client, IT87_REG_VIN_MAX(3),
-			 IN_TO_REG(IT87_INIT_IN_MAX_3));
-	it87_write_value(client, IT87_REG_VIN_MIN(4),
-			 IN_TO_REG(IT87_INIT_IN_MIN_4));
-	it87_write_value(client, IT87_REG_VIN_MAX(4),
-			 IN_TO_REG(IT87_INIT_IN_MAX_4));
-	it87_write_value(client, IT87_REG_VIN_MIN(5),
-			 IN_TO_REG(IT87_INIT_IN_MIN_5));
-	it87_write_value(client, IT87_REG_VIN_MAX(5),
-			 IN_TO_REG(IT87_INIT_IN_MAX_5));
-	it87_write_value(client, IT87_REG_VIN_MIN(6),
-			 IN_TO_REG(IT87_INIT_IN_MIN_6));
-	it87_write_value(client, IT87_REG_VIN_MAX(6),
-			 IN_TO_REG(IT87_INIT_IN_MAX_6));
-	it87_write_value(client, IT87_REG_VIN_MIN(7),
-			 IN_TO_REG(IT87_INIT_IN_MIN_7));
-	it87_write_value(client, IT87_REG_VIN_MAX(7),
-			 IN_TO_REG(IT87_INIT_IN_MAX_7));
-	/* Note: Battery voltage does not have limit registers */
-	it87_write_value(client, IT87_REG_FAN_MIN(0),
-			 FAN_TO_REG(IT87_INIT_FAN_MIN_1, 2));
-	it87_write_value(client, IT87_REG_FAN_MIN(1),
-			 FAN_TO_REG(IT87_INIT_FAN_MIN_2, 2));
-	it87_write_value(client, IT87_REG_FAN_MIN(2),
-			 FAN_TO_REG(IT87_INIT_FAN_MIN_3, 2));
-	it87_write_value(client, IT87_REG_TEMP_HIGH(0),
-			 TEMP_TO_REG(IT87_INIT_TEMP_HIGH_1));
-	it87_write_value(client, IT87_REG_TEMP_LOW(0),
-			 TEMP_TO_REG(IT87_INIT_TEMP_LOW_1));
-	it87_write_value(client, IT87_REG_TEMP_HIGH(1),
-			 TEMP_TO_REG(IT87_INIT_TEMP_HIGH_2));
-	it87_write_value(client, IT87_REG_TEMP_LOW(1),
-			 TEMP_TO_REG(IT87_INIT_TEMP_LOW_2));
-	it87_write_value(client, IT87_REG_TEMP_HIGH(2),
-			 TEMP_TO_REG(IT87_INIT_TEMP_HIGH_3));
-	it87_write_value(client, IT87_REG_TEMP_LOW(2),
-			 TEMP_TO_REG(IT87_INIT_TEMP_LOW_3));
+	if (reset) {
+		/* Reset all except Watchdog values and last conversion values
+		   This sets fan-divs to 2, among others */
+		it87_write_value(client, IT87_REG_CONFIG, 0x80);
+
+	}
 
 	/* Enable voltage monitors */
 	it87_write_value(client, IT87_REG_VIN_ENABLE, 0xff);
 
-	/* Enable Temp1-Temp3 */
-	data->sensor = (it87_read_value(client, IT87_REG_TEMP_ENABLE) & 0xc0);
-	data->sensor |= 0x2a; /* Temp1,Temp3=thermistor; Temp2=thermal diode */
-	it87_write_value(client, IT87_REG_TEMP_ENABLE, data->sensor);
-
-	/* Enable fans */
+	/* Enable fan tachometers */
 	it87_write_value(client, IT87_REG_FAN_CTRL,
 			(it87_read_value(client, IT87_REG_FAN_CTRL) & 0x8f)
 			| 0x70);
 
 	/* Start monitoring */
 	it87_write_value(client, IT87_REG_CONFIG,
-			 (it87_read_value(client, IT87_REG_CONFIG) & 0xb7)
+			 (it87_read_value(client, IT87_REG_CONFIG) & 0x36)
 			 | (update_vbat ? 0x41 : 0x01));
 }
 
@@ -988,6 +938,8 @@
 MODULE_DESCRIPTION("IT8705F, IT8712F, Sis950 driver");
 MODULE_PARM(update_vbat, "i");
 MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup value");
+MODULE_PARM(reset, "i");
+MODULE_PARM_DESC(reset, "Reset the chip's registers, default no");
 MODULE_LICENSE("GPL");
 
 module_init(sm_it87_init);


Thanks in advance,
-----------------------
Takeru Komoriya
 komoriya@paken.org
 http://www.paken.org/
