From: CC <ccomren@gmail.com>
Date: Sat, 28 Jan 2012 12:25:07 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83627ehf) Disable setting DC mode for pwm2, pwm3 on NCT6776F
Message-Id: <CAH4eiUjnLYd5jASGfn3-FAxdWUbAmA-Fwi5Z4DyLPi+mGJ6eDw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327715876-3605-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1327715876-3605-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, Jan 28, 2012 at 9:49 AM, Jean Delvare <khali@linux-fr.org> wrote:
> On Fri, 27 Jan 2012 17:57:56 -0800, Guenter Roeck wrote:
>> NCT6776F only supports pwm mode for pwm2 and pwm3. Return error if an at=
tempt
>> is made to set those pwm channels to DC mode.
>>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> =A0drivers/hwmon/w83627ehf.c | =A0 =A06 ++++++
>> =A01 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
>> index c0ef1a3..4f58202 100644
>> --- a/drivers/hwmon/w83627ehf.c
>> +++ b/drivers/hwmon/w83627ehf.c
>> @@ -1318,6 +1318,7 @@ store_pwm_mode(struct device *dev, struct device_a=
ttribute *attr,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *buf, size_t coun=
t)
>> =A0{
>> =A0 =A0 =A0 struct w83627ehf_data *data =3D dev_get_drvdata(dev);
>> + =A0 =A0 struct w83627ehf_sio_data *sio_data =3D dev->platform_data;
>> =A0 =A0 =A0 struct sensor_device_attribute *sensor_attr =3D to_sensor_de=
v_attr(attr);
>> =A0 =A0 =A0 int nr =3D sensor_attr->index;
>> =A0 =A0 =A0 unsigned long val;
>> @@ -1330,6 +1331,11 @@ store_pwm_mode(struct device *dev, struct device_=
attribute *attr,
>>
>> =A0 =A0 =A0 if (val > 1)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 /* On NCT67766F, DC mode is only supported for pwm1 */
>> + =A0 =A0 if (sio_data->kind =3D=3D nct6776 && nr && val !=3D 1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> =A0 =A0 =A0 mutex_lock(&data->update_lock);
>> =A0 =A0 =A0 reg =3D w83627ehf_read_value(data, W83627EHF_REG_PWM_ENABLE[=
nr]);
>> =A0 =A0 =A0 data->pwm_mode[nr] =3D val;
>
> Good catch. Might even be a candidate for -stable.
>
> Acked-by: Jean Delvare <khali@linux-fr.org>
>
> --
> Jean Delvare

It's great to disable writing to the attribute, but as per my report,
I am still confident that it cannot be PWM the fans are controlled
with. So it must be "DC".

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
