From: Chris <silverchris@gmail.com>
Date: Mon, 13 Feb 2012 05:53:42 +0000
Subject: Re: [lm-sensors] [Patch] hwmon: (max6639) Set Pulse per revolution loop for both channels
Message-Id: <CAO7tRni_T9xT5KqBR8eL2r4Nosuhh3VTxo0dJFmi4QbBFrXnUA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
In-Reply-To: <CAO7tRnjoSKUKoL4445e+Gud7Dhe=K9K1MYnGNCYcBs-d4X2O6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Fixed RPM calculations to not use ppr, and to be closer to what the
data sheet specifies.
Signed-off-by: Chris D Schimp <silverchris@gmail.com>
---
You would be very correct about the second bug. I have fixed that bug,
and removed the use of ppr in this patch attached. I have also changed
the behavior of the driver as to not change or initialize any
settings, so that it will leave all the bios or default settings in
place and clean up the things left over.


diff -uprN -X linux-3.2.5/Documentation/dontdiff
old/linux-3.2.5/drivers/hwmon/max6639.c
new/linux-3.2.5/drivers/hwmon/max6639.c
--- old/linux-3.2.5/drivers/hwmon/max6639.c	2012-02-06 12:47:00.000000000 -=
0500
+++ new/linux-3.2.5/drivers/hwmon/max6639.c	2012-02-12 23:16:21.770059276 -=
0500
@@ -72,8 +72,8 @@ static unsigned short normal_i2c[] =3D { 0

 static const int rpm_ranges[] =3D { 2000, 4000, 8000, 16000 };

-#define FAN_FROM_REG(val, div, rpm_range)	((val) =3D=3D 0 ? -1 : \
-	(val) =3D=3D 255 ? 0 : (rpm_ranges[rpm_range] * 30) / ((div + 1) * (val)))
+#define FAN_FROM_REG(val, rpm_range)	((val) =3D=3D 0 ? -1 : \
+	(val) =3D=3D 255 ? 0 : (rpm_ranges[rpm_range] * 30) / val)
 #define TEMP_LIMIT_TO_REG(val)	SENSORS_LIMIT((val) / 1000, 0, 255)

 /*
@@ -333,7 +334,7 @@ static ssize_t show_fan_input(struct dev
 		return PTR_ERR(data);

 	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[attr->index],
-		       data->ppr, data->rpm_range));
+		       data->rpm_range[attr->index]));
 }

 static ssize_t show_alarm(struct device *dev,


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
