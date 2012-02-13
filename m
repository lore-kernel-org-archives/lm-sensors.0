From: Chris <silverchris@gmail.com>
Date: Mon, 13 Feb 2012 05:56:00 +0000
Subject: Re: [lm-sensors] [Patch] hwmon: (max6639) Set Pulse per revolution loop for both channels
Message-Id: <CAO7tRnjNt+eRZkPkwrMPU9qa_i9SFZpK5sHLU=ezX9c26W7wwQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
In-Reply-To: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Removed initialization to leave bios or hardware defaults alone.
---
diff -uprN -X linux-3.2.5/Documentation/dontdiff
old/linux-3.2.5/drivers/hwmon/max6639.c
new/linux-3.2.5/drivers/hwmon/max6639.c
--- old/linux-3.2.5/drivers/hwmon/max6639.c	2012-02-06 12:47:00.000000000 -=
0500
+++ new/linux-3.2.5/drivers/hwmon/max6639.c	2012-02-12 23:16:21.770059276 -=
0500
@@ -90,16 +90,13 @@ struct max6639_data {
 	bool temp_fault[2];	/* Detected temperature diode failure */
 	u8 fan[2];		/* Register value: TACH count for fans >=3D30 */
 	u8 status;		/* Detected channel alarms and fan failures */
+	u8 rpm_range[2];		/* Index in above rpm_ranges table */

 	/* Register values only written to */
 	u8 pwm[2];		/* Register value: Duty cycle 0..120 */
 	u8 temp_therm[2];	/* THERM Temperature, 0..255 C (->_max) */
 	u8 temp_alert[2];	/* ALERT Temperature, 0..255 C (->_crit) */
 	u8 temp_ot[2];		/* OT Temperature, 0..255 C (->_emergency) */
-
-	/* Register values initialized only once */
-	u8 ppr;			/* Pulses per rotation 0..3 for 1..4 ppr */
-	u8 rpm_range;		/* Index in above rpm_ranges table */
 };

 static struct max6639_data *max6639_update_device(struct device *dev)
@@ -136,6 +133,10 @@ static struct max6639_data *max6639_upda
 			data->fan[i] =3D res;

 			res =3D i2c_smbus_read_byte_data(client,
+					MAX6639_REG_FAN_CONFIG1(i));
+			data->rpm_range[i] =3D 0x03&res;
+
+			res =3D i2c_smbus_read_byte_data(client,
 					MAX6639_REG_TEMP_EXT(i));
 			if (res < 0) {
 				ret =3D ERR_PTR(res);
@@ -408,117 +409,6 @@ static const struct attribute_group max6
 	.attrs =3D max6639_attributes,
 };

-/*
- *  returns respective index in rpm_ranges table
- *  1 by default on invalid range
- */
-static int rpm_range_to_reg(int range)
-{
-	int i;
-
-	for (i =3D 0; i < ARRAY_SIZE(rpm_ranges); i++) {
-		if (rpm_ranges[i] =3D=3D range)
-			return i;
-	}
-
-	return 1; /* default: 4000 RPM */
-}
-
-static int max6639_init_client(struct i2c_client *client)
-{
-	struct max6639_data *data =3D i2c_get_clientdata(client);
-	struct max6639_platform_data *max6639_info =3D
-		client->dev.platform_data;
-	int i =3D 0;
-	int rpm_range =3D 1; /* default: 4000 RPM */
-	int err =3D 0;
-
-	/* Reset chip to default values, see below for GCONFIG setup */
-	err =3D i2c_smbus_write_byte_data(client, MAX6639_REG_GCONFIG,
-				  MAX6639_GCONFIG_POR);
-	if (err)
-		goto exit;
-
-	/* Fans pulse per revolution is 2 by default */
-	if (max6639_info && max6639_info->ppr > 0 &&
-			max6639_info->ppr < 5)
-		data->ppr =3D max6639_info->ppr;
-	else
-		data->ppr =3D 2;
-	data->ppr -=3D 1;
-	err =3D i2c_smbus_write_byte_data(client,
-			MAX6639_REG_FAN_PPR(i),
-			data->ppr << 5);
-	if (err)
-		goto exit;
-
-	if (max6639_info)
-		rpm_range =3D rpm_range_to_reg(max6639_info->rpm_range);
-	data->rpm_range =3D rpm_range;
-
-	for (i =3D 0; i < 2; i++) {
-
-		/* Fans config PWM, RPM */
-		err =3D i2c_smbus_write_byte_data(client,
-			MAX6639_REG_FAN_CONFIG1(i),
-			MAX6639_FAN_CONFIG1_PWM | rpm_range);
-		if (err)
-			goto exit;
-
-		/* Fans PWM polarity high by default */
-		if (max6639_info && max6639_info->pwm_polarity =3D=3D 0)
-			err =3D i2c_smbus_write_byte_data(client,
-				MAX6639_REG_FAN_CONFIG2a(i), 0x00);
-		else
-			err =3D i2c_smbus_write_byte_data(client,
-				MAX6639_REG_FAN_CONFIG2a(i), 0x02);
-		if (err)
-			goto exit;
-
-		/*
-		 * /THERM full speed enable,
-		 * PWM frequency 25kHz, see also GCONFIG below
-		 */
-		err =3D i2c_smbus_write_byte_data(client,
-			MAX6639_REG_FAN_CONFIG3(i),
-			MAX6639_FAN_CONFIG3_THERM_FULL_SPEED | 0x03);
-		if (err)
-			goto exit;
-
-		/* Max. temp. 80C/90C/100C */
-		data->temp_therm[i] =3D 80;
-		data->temp_alert[i] =3D 90;
-		data->temp_ot[i] =3D 100;
-		err =3D i2c_smbus_write_byte_data(client,
-				MAX6639_REG_THERM_LIMIT(i),
-				data->temp_therm[i]);
-		if (err)
-			goto exit;
-		err =3D i2c_smbus_write_byte_data(client,
-				MAX6639_REG_ALERT_LIMIT(i),
-				data->temp_alert[i]);
-		if (err)
-			goto exit;
-		err =3D i2c_smbus_write_byte_data(client,
-				MAX6639_REG_OT_LIMIT(i), data->temp_ot[i]);
-		if (err)
-			goto exit;
-
-		/* PWM 120/120 (i.e. 100%) */
-		data->pwm[i] =3D 120;
-		err =3D i2c_smbus_write_byte_data(client,
-				MAX6639_REG_TARGTDUTY(i), data->pwm[i]);
-		if (err)
-			goto exit;
-	}
-	/* Start monitoring */
-	err =3D i2c_smbus_write_byte_data(client, MAX6639_REG_GCONFIG,
-		MAX6639_GCONFIG_DISABLE_TIMEOUT | MAX6639_GCONFIG_CH2_LOCAL |
-		MAX6639_GCONFIG_PWM_FREQ_HI);
-exit:
-	return err;
-}
-
 /* Return 0 if detection is successful, -ENODEV otherwise */
 static int max6639_detect(struct i2c_client *client,
 			  struct i2c_board_info *info)
@@ -555,11 +445,6 @@ static int max6639_probe(struct i2c_clie
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);

-	/* Initialize the max6639 chip */
-	err =3D max6639_init_client(client);
-	if (err < 0)
-		goto error_free;
-
 	/* Register sysfs hooks */
 	err =3D sysfs_create_group(&client->dev.kobj, &max6639_group);
 	if (err)

On Sun, Feb 12, 2012 at 4:30 AM, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Chris,
>
> On Sat, 11 Feb 2012 22:00:39 -0500, Chris wrote:
>> Moved Fan Pulse per revolution into a loop so that both channel 1 and
>> channel 2 get set, instead of just channel 1
>
> You are right that the code is broken. However your fix is
> unnecessarily expensive, as you end up setting data->ppr twice. What
> needs to be moved inside the loop is the register write and only that.
>
> Note that this bug wasn't spotted earlier because i (and err, for that
> matter) are initialized at the beginning of the function when they
> did not have to. I guess I will never repeat that enough: do not
> initialize variables "just in case", or gcc can no longer help you when
> you get things wrong.
>
> Also note that I find it highly discussable that the driver initializes
> the chip with arbitrary values in the absence of platform data. The
> usual policy of hwmon drivers is to leave the chip untouched by
> default, assuming that the hardware defaults or firmware/BIOS settings
> are OK. Here some configuration bits are even set to 0 simply because
> simple register writes are used instead of read-modify-write cycles.
> I'm not even sure if this is intended.
>
>> Signed-off-by: Chris D Schimp <silverchris@gmail.com>
>>
>> ---
>> diff -uprN -X vanilla/linux-3.2.5/Documentation/dontdiff
>> vanilla/linux-3.2.5/drivers/hwmon/max6639.c
>> devel/linux-3.2.5/drivers/hwmon/max6639.c
>> --- vanilla/linux-3.2.5/drivers/hwmon/max6639.c =A0 =A0 =A0 2012-02-06
>> 12:47:00.000000000 -0500
>> +++ devel/linux-3.2.5/drivers/hwmon/max6639.c 2012-02-11
>> 21:40:02.399127171 -0500
>> @@ -439,25 +439,24 @@ static int max6639_init_client(struct i2
>> =A0 =A0 =A0 if (err)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit;
>>
>> - =A0 =A0 /* Fans pulse per revolution is 2 by default */
>> - =A0 =A0 if (max6639_info && max6639_info->ppr > 0 &&
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max6639_info->ppr < 5)
>> - =A0 =A0 =A0 =A0 =A0 =A0 data->ppr =3D max6639_info->ppr;
>> - =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 data->ppr =3D 2;
>> - =A0 =A0 data->ppr -=3D 1;
>> - =A0 =A0 err =3D i2c_smbus_write_byte_data(client,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MAX6639_REG_FAN_PPR(i),
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->ppr << 5);
>> - =A0 =A0 if (err)
>> - =A0 =A0 =A0 =A0 =A0 =A0 goto exit;
>> -
>> =A0 =A0 =A0 if (max6639_info)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 rpm_range =3D rpm_range_to_reg(max6639_info-=
>rpm_range);
>> =A0 =A0 =A0 data->rpm_range =3D rpm_range;
>>
>> =A0 =A0 =A0 for (i =3D 0; i < 2; i++) {
>>
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Fans pulse per revolution is 2 by default */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (max6639_info && max6639_info->ppr > 0 &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max6639_info->=
ppr < 5)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->ppr =3D max6639_info->pp=
r;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->ppr =3D 2;
>> + =A0 =A0 =A0 =A0 =A0 =A0 data->ppr -=3D 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D i2c_smbus_write_byte_data(client,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MAX6639_REG_FAN_PPR(i),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->ppr << 5);
>
> I think there is a second bug here. According to the datasheet the
> shift should be 6 not 5. I'm not sure how this managed to go unnoticed
> so far. Maybe there is another bug somewhere in the driver? I see that
> FAN_FROM_REG() takes data->ppr as a parameter, which it should not
> according to the datasheet. If the PPR setting is set correctly for the
> fan being used, then it doesn't show in the formula:
>
> Tachometer count value =3D internal clock frequency * 60 / actual RPM
>
> where internal clock frequency =3D fan rpm range / 2, so:
>
> Actual RPM =3D fan rpm range * 30 / tachometer count value
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (err)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto exit;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Fans config PWM, RPM */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D i2c_smbus_write_byte_data(client,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MAX6639_REG_FAN_CONFIG1(i),
>
> Assuming I am correct, can you please send two patches, one clearing
> the initialization of i and moving the write to MAX6639_REG_FAN_PPR(i)
> inside the loop, and a second one fixing the bit shift and the
> definition of FAN_FROM_REG?
>
> Note that data->ppr will be unused at this point, so it might as well
> be dropped, a local variable will be enough.
>
> Thanks,
> --
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
