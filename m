From: CC <ccomren@gmail.com>
Date: Sat, 28 Jan 2012 12:28:04 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83627ehf) Disable setting DC mode for pwm2, pwm3 on NCT6776F
Message-Id: <CAH4eiUiY7hQzuh9HVysNoBNagLcphWNQus44W-Ab7LbTA2MN7g@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327715876-3605-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1327715876-3605-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, Jan 28, 2012 at 1:25 PM, CC <ccomren@gmail.com> wrote:
> On Sat, Jan 28, 2012 at 9:49 AM, Jean Delvare <khali@linux-fr.org> wrote:
>> On Fri, 27 Jan 2012 17:57:56 -0800, Guenter Roeck wrote:
>>> NCT6776F only supports pwm mode for pwm2 and pwm3. Return error if an a=
ttempt
>>> is made to set those pwm channels to DC mode.
>>>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>> =A0drivers/hwmon/w83627ehf.c | =A0 =A06 ++++++
>>> =A01 files changed, 6 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
>>> index c0ef1a3..4f58202 100644
>>> --- a/drivers/hwmon/w83627ehf.c
>>> +++ b/drivers/hwmon/w83627ehf.c
>>> @@ -1318,6 +1318,7 @@ store_pwm_mode(struct device *dev, struct device_=
attribute *attr,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *buf, size_t cou=
nt)
>>> =A0{
>>> =A0 =A0 =A0 struct w83627ehf_data *data =3D dev_get_drvdata(dev);
>>> + =A0 =A0 struct w83627ehf_sio_data *sio_data =3D dev->platform_data;
>>> =A0 =A0 =A0 struct sensor_device_attribute *sensor_attr =3D to_sensor_d=
ev_attr(attr);
>>> =A0 =A0 =A0 int nr =3D sensor_attr->index;
>>> =A0 =A0 =A0 unsigned long val;
>>> @@ -1330,6 +1331,11 @@ store_pwm_mode(struct device *dev, struct device=
_attribute *attr,
>>>
>>> =A0 =A0 =A0 if (val > 1)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>> +
>>> + =A0 =A0 /* On NCT67766F, DC mode is only supported for pwm1 */
>>> + =A0 =A0 if (sio_data->kind =3D=3D nct6776 && nr && val !=3D 1)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>> +
>>> =A0 =A0 =A0 mutex_lock(&data->update_lock);
>>> =A0 =A0 =A0 reg =3D w83627ehf_read_value(data, W83627EHF_REG_PWM_ENABLE=
[nr]);
>>> =A0 =A0 =A0 data->pwm_mode[nr] =3D val;
>>
>> Good catch. Might even be a candidate for -stable.
>>
>> Acked-by: Jean Delvare <khali@linux-fr.org>
>>
>> --
>> Jean Delvare
>
> It's great to disable writing to the attribute, but as per my report,
> I am still confident that it cannot be PWM the fans are controlled
> with. So it must be "DC".

What's more important than terminology is the fact that setting pwm2
to other modes works (as is to be expected since this one has a 4-pin
connector with a PWM signal, and the others don't). It's pwm1 and pwm3
that should be disabled. Maybe the code got the enumeration somewhere
else wrong?

Best,  CC

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
