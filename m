From: Axel Lin <axel.lin@gmail.com>
Date: Tue, 09 Nov 2010 08:22:02 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (gpio-fan) Fix fan_ctrl_init error
Message-Id: <AANLkTim9mNy+ocftWn0ZiGPyefjhc-eXj3gunFw1Q04s@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1289279919.14461.7.camel@mola> <20101109090147.155dd1e9@endymion.delvare>
In-Reply-To: <20101109090147.155dd1e9@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Guenter Roeck <guenter.roeck@ericsson.com>, Simon Guinot <sguinot@lacie.com>, lm-sensors@lm-sensors.org

2010/11/9 Jean Delvare <khali@linux-fr.org>:
> On Tue, 09 Nov 2010 13:18:39 +0800, Axel Lin wrote:
>> Remove sysfs entries before return -ENODEV.
>>
>> Signed-off-by: Axel Lin <axel.lin@gmail.com>
>> ---
>> =A0drivers/hwmon/gpio-fan.c | =A0 =A04 +++-
>> =A01 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
>> index aa701a1..d2e66b4 100644
>> --- a/drivers/hwmon/gpio-fan.c
>> +++ b/drivers/hwmon/gpio-fan.c
>> @@ -388,11 +388,13 @@ static int fan_ctrl_init(struct gpio_fan_data *fan=
_data,
>> =A0 =A0 =A0 fan_data->speed_index =3D get_fan_speed_index(fan_data);
>> =A0 =A0 =A0 if (fan_data->speed_index < 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENODEV;
>> - =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_gpio;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_remove_sysfs;
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 return 0;
>>
>> +err_remove_sysfs:
>> + =A0 =A0 sysfs_remove_group(&pdev->dev.kobj, &gpio_fan_ctrl_group);
>> =A0err_free_gpio:
>> =A0 =A0 =A0 for (i =3D i - 1; i >=3D 0; i--)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(ctrl[i]);
>
> Oh, and while you're here, fan_alarm_init() needs some love as well.
> There's a "return 0" in the middle which clearly can't be correct.
I think this part is correct. see the comment:
        /*
         * If the alarm GPIO don't support interrupts, just leave
         * without initializing the fail notification support.
         */

Regards,
Axel

>
> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
