From: komoriya@paken.org (Takeru KOMORIYA)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: [PATCH 2.6] it87 Part2(reset option)
Message-Id: <20040227144621.11d570bb.komoriya@paken.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040225111219.1c117787.komoriya@paken.org>
In-Reply-To: <20040225111219.1c117787.komoriya@paken.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Thu, 26 Feb 2004 16:34:26 +0100
Jean Delvare <khali@linux-fr.org> wrote:

> > According to the datasheet, voltage scan, temperature channels and
> > fan tachometers are disabled at reset. We can enable temperature
> > channels from user-space, but not for voltages and thachometers.
> 
> This would mean that the reset option of the 2.4 driver is unusable
> at the moment (since it would also disable all readings)?

I commented out the code for initializing voltages and thachometers,
and tested with reset=1, and I say yes though I have tested for 2.6
but not for 2.4.  
Sensor values stopped updating without these initializations.

> > So I think we should keep initializations for voltages and
> > thachometers, even if reset option is not given, because it may
> > not be guaranteed that these are always set by BIOS(especially if
> > hardware monitor features are disabled by BIOS settings).
> 
> This could be done on purpose by the BIOS. For example, the BIOS
> could know that a given voltage input isn't wired on the
> motherboard, and disable that particular input. I regret that we
> would lose this information if we were to force all inputs on by
> default.

I agree with you. I don't like to lose such information.
Voltages and thachometers could be sensed without initialization even
if I set "ignore this sensor" in BIOS settings. My assumption was not
correct.

> Maybe we could first check whether all voltage inputs and
> tachometers are disabled. If they are (which is the case after a
> reset), enable them all. If not, don't touch anything. That way, we
> would respect the choices of the BIOS in the case they are correct.
> 
> This is only a suggestion, you might not agree with it.

I feel this is good idea. I added the code to check if all voltages(or
tachometers) are disabled.

> > Wow, you speak Japanese! Aligato!
> 
> Not really. I think I know three words: "ushi", "dicho" and
> "aligato". Only the last one is obviously usable on a regular basis
> ;) My grilfriend, on the other hand, knows quite a bit of Jananese,
> and we like watching original Japanese animation videos together.

I know such videos are called Japanimation:) 
I wonder why you know the word "dicho" (intestinum crassum?)...

> > @@ -825,77 +828,24 @@
> >  /* Called when we have found a new IT87. It should set limits,
> >  etc.
> > */
> 
> The second part of this comment doesn't make sense anymore.

Sure. I fixed it.

Here's new version with your suggestions.


--- it87.c.sensor_type	2004-02-25 10:27:21.000000000 +0900
+++ it87.c	2004-02-27 14:11:23.140629745 +0900
@@ -55,7 +55,10 @@
 
 
 /* Update battery voltage after every reading if true */
-static int update_vbat = 0;
+static int update_vbat;
+
+/* Reset the registers on init if true */
+static int reset;
 
 /* Many IT87 constants specified below */
 
@@ -822,80 +825,33 @@
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
+	/* Check if voltage monitors are reset manually or by some reason */
+	if (it87_read_value(client, IT87_REG_VIN_ENABLE) = 0) {
+		/* Enable all voltage monitors */
+		it87_write_value(client, IT87_REG_VIN_ENABLE, 0xff);
+	}
+
+	/* Check if tachometers are reset manually or by some reason */
+	if ((it87_read_value(client, IT87_REG_FAN_CTRL) & 0x70) = 0) {
+		/* Enable all fan tachometers */
+		it87_write_value(client, IT87_REG_FAN_CTRL,
+				(it87_read_value(client, IT87_REG_FAN_CTRL) & 0x8f)
+				| 0x70);
+	}
 
 	/* Start monitoring */
 	it87_write_value(client, IT87_REG_CONFIG,
-			 (it87_read_value(client, IT87_REG_CONFIG) & 0xb7)
+			 (it87_read_value(client, IT87_REG_CONFIG) & 0x36)
 			 | (update_vbat ? 0x41 : 0x01));
 }
 
@@ -988,6 +944,8 @@
 MODULE_DESCRIPTION("IT8705F, IT8712F, Sis950 driver");
 MODULE_PARM(update_vbat, "i");
 MODULE_PARM_DESC(update_vbat, "Update vbat if set else return powerup value");
+MODULE_PARM(reset, "i");
+MODULE_PARM_DESC(reset, "Reset the chip's registers, default no");
 MODULE_LICENSE("GPL");
 
 module_init(sm_it87_init);


Thanks,
-----------------------
Takeru Komoriya
 komoriya@paken.org
 http://www.paken.org/
