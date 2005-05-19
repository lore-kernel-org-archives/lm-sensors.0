From: komoriya@paken.org (Takeru KOMORIYA)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: [PATCH 2.6] it87 Part2(reset option)
Message-Id: <20040228143951.64a99796.komoriya@paken.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040225111219.1c117787.komoriya@paken.org>
In-Reply-To: <20040225111219.1c117787.komoriya@paken.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > I feel this is good idea. I added the code to check if all
> > voltages (or tachometers) are disabled.
> 
> This make me think of something. You do not handle the temperatures
> at all, because the user can configure them from user-space. Doesn't
> it sound a bit strange though that upon reset, all inputs but
> temperatures are forcibly enabled?

I feel so when one comes to think of it.

> We could save the settings before reset (for temperatures only) and
> restore them right after.
> 
> Or we could forcibly enable temperatures with what used to be the
> default value in older versions of the driver (0x2a if my memory is
> correct).
> 
> Or we could mix both (restore values for enabled channels, and use
> the default values for disabled temperature channels).
> 
> What do you think? This is a true question, I don't have strong
> opinion(although solution 2 is the more similar to what is done for
> voltages and fan tachometers). Even doing nothing (the way it is) is
> OK for me if you like it that way.

I like the second one though I don't have strong opinion too.
If we use reset option, I think this means that register settings by
BIOS may be broken or can not be reliable.

> > I know such videos are called Japanimation:)
> 
> In France we often refer to them simply as "anime" and everyone
> understands we speak about Japanese ones.

Well, I guess it's because of special abbreviation way of Japanese.
We abbreviate many foreign words in similar way. telebi(television),
paso-com(personal computer), nego-ru(make negotiation), and so on.

> > I wonder why you know the word "dicho" (intestinum crassum?)...
> 
> Oh well, I must have been spelling it incorrectly. I only ever heard
> it, never seen it written. Maybe it's "disho" or "dijo"? The word I
> know is supposed to mean "dictionary".

I see:) "disho" is correct for dictionary, though "jisho" is formal
spelling for Japanse.

> > +	/* Check if tachometers are reset manually or by some reason
> > */+	if ((it87_read_value(client, IT87_REG_FAN_CTRL) & 0x70) = 0)
> > {+		/* Enable all fan tachometers */
> > +		it87_write_value(client, IT87_REG_FAN_CTRL,
> > +	(it87_read_value(client, IT87_REG_FAN_CTRL) & 0x8f)
> 
> You can spare the second read by saving the value returned by the
> previous read of the same register in a local variable. Remember
> that register reads are relatively slow (especially on I2C busses)
> so we want to spare them each time we can.

Thanks. I haven't thought of the access speed to registers.

Here's new version.

Merci:)

--- it87.c.sensor_type	2004-02-25 10:27:21.000000000 +0900
+++ it87.c	2004-02-28 13:38:21.982649612 +0900
@@ -55,7 +55,10 @@
 
 
 /* Update battery voltage after every reading if true */
-static int update_vbat = 0;
+static int update_vbat;
+
+/* Reset the registers on init if true */
+static int reset;
 
 /* Many IT87 constants specified below */
 
@@ -822,80 +825,45 @@
 		return i2c_smbus_write_byte_data(client, reg, value);
 }
 
-/* Called when we have found a new IT87. It should set limits, etc. */
+/* Called when we have found a new IT87. */
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
-
-	/* Enable voltage monitors */
-	it87_write_value(client, IT87_REG_VIN_ENABLE, 0xff);
-
-	/* Enable Temp1-Temp3 */
-	data->sensor = (it87_read_value(client, IT87_REG_TEMP_ENABLE) & 0xc0);
-	data->sensor |= 0x2a; /* Temp1,Temp3=thermistor; Temp2=thermal diode */
-	it87_write_value(client, IT87_REG_TEMP_ENABLE, data->sensor);
+	int tmp;
+
+	if (reset) {
+		/* Reset all except Watchdog values and last conversion values
+		   This sets fan-divs to 2, among others */
+		it87_write_value(client, IT87_REG_CONFIG, 0x80);
+
+	}
 
-	/* Enable fans */
-	it87_write_value(client, IT87_REG_FAN_CTRL,
-			(it87_read_value(client, IT87_REG_FAN_CTRL) & 0x8f)
-			| 0x70);
+	/* Check if temperature channnels are reset manually or by some reason */
+	tmp = it87_read_value(client, IT87_REG_TEMP_ENABLE);
+	if ((tmp & 0x3f) = 0) {
+		/* Temp1,Temp3=thermistor; Temp2=thermal diode */
+		tmp = (tmp & 0xc0) | 0x2a;
+		it87_write_value(client, IT87_REG_TEMP_ENABLE, tmp);
+	}
+	data->sensor = tmp;
+
+	/* Check if voltage monitors are reset manually or by some reason */
+	tmp = it87_read_value(client, IT87_REG_VIN_ENABLE);
+	if ((tmp & 0xff) = 0) {
+		/* Enable all voltage monitors */
+		it87_write_value(client, IT87_REG_VIN_ENABLE, 0xff);
+	}
+
+	/* Check if tachometers are reset manually or by some reason */
+	tmp = it87_read_value(client, IT87_REG_FAN_CTRL);
+	if ((tmp & 0x70) = 0) {
+		/* Enable all fan tachometers */
+		tmp = (tmp & 0x8f) | 0x70;
+		it87_write_value(client, IT87_REG_FAN_CTRL, tmp);
+	}
 
 	/* Start monitoring */
 	it87_write_value(client, IT87_REG_CONFIG,
-			 (it87_read_value(client, IT87_REG_CONFIG) & 0xb7)
+			 (it87_read_value(client, IT87_REG_CONFIG) & 0x36)
 			 | (update_vbat ? 0x41 : 0x01));
 }
 
@@ -988,6 +956,8 @@
 MODULE_DESCRIPTION("IT8705F, IT8712F, Sis950 driver");
 MODULE_PARM(update_vbat, "i");
 MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup value");
+MODULE_PARM(reset, "i");
+MODULE_PARM_DESC(reset, "Reset the chip's registers, default no");
 MODULE_LICENSE("GPL");
 
 module_init(sm_it87_init);



-----------------------
Takeru Komoriya
 komoriya@paken.org
 http://www.paken.org/
