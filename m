From: Riku Voipio <riku.voipio@movial.fi>
Date: Wed, 27 Jun 2007 13:23:52 +0000
Subject: Re: [lm-sensors] Help needed for implementing&testing Fintek F75375
Message-Id: <468264E8.8010102@movial.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <5327.79319.qm@web25109.mail.ukl.yahoo.com>
In-Reply-To: <5327.79319.qm@web25109.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>>> Did pwmconfig work?
>>>      =20
>> I get it working now, i just have to set FCTEMPS and FCFANS correct in /=
etc/fancontrol now it work.
>> The only problem is, that if i stop fancontrol, the program set pwm1_ena=
ble to 0, but
>> after this the fan turns at 23rpm. This also happens if i set pwm1_enabl=
e to 0 by hand.
>>    =20
>
> Sounds like a bug in the driver then. Setting pwm1_enable to 0 should
> turn the fan to full speed.
>  =20
The sysfs interface states that pwm_enable to 0 turns off pwm control...=20
How would that turn fans to full speed?

>
>  =20
>>> Lastly, you really shouldn't have to divide the values by 1000. This
>>> suggests that the magnitude wasn't set properly in libsensors (it
>>> should be 3, I suggest it is 0). This issue is most probably related to
>>> the incorrect symbol names.
>>>      =20
>> I saw values >800V so i thought i have to divide it by 1000 in sensors.c=
onf.
>> Magnitude is 3 and the symbol name is correct now, but the values are st=
ill
>> over 800V. What's the reason?
>>    =20
>
> I guess that's a bug in the driver. What values do you see in the
> in*_input sysfs files?
>
>  =20
Fixed.
>>> This means that the driver isn't reporting the values in RPM as it
>>> should. Usually no compute statement is needed for fans.
>>>      =20
>> That's correct, the value is not in RPM, in the document '2005111153128.=
pdf' you can download on the fintek page
>> ( http://www.fintek.com.tw/eng/products.asp?BID=3D4&SID=3D5 )its written=
 on page 8:
>> "Determine the fan counter according to:
>> Count =3D (1.5=D710^6) / RPM "
>> That means that the driver is reporting the count value, not the rpm.
>> So i have to compute in sensors.conf:
>> RPM =3D (1.5=D710^6)/ Count
>>    =20
>
> Almost all chips do that, but that's not the point. Our sysfs-interface
> standard says that the conversion to RPM must occur in the driver and
> not in user-space. So the f75375 driver needs to be updated.
>  =20
Will be fixed..
>>> +#define SENSORS_F75373_FAN_FEATURES(nr) \
>>> +        { { SENSORS_F75373_FAN(nr), "fan" #nr, \
>>> +                NOMAP, NOMAP, R }, \
>>> +                NOSYSCTL, VALUE(2), 0 }, \
>>> +        { { SENSORS_F75373_FAN_MAX(nr), "fan" #nr "_max", \
>>> +                SENSORS_F75373_FAN(nr), SENSORS_F75373_FAN(nr), RW }, \
>>> +                NOSYSCTL, VALUE(1), 0 }, \
>>>
>>> Strange, I've never seen a fan speed sensor with a high limit. What
>>> does it correspond to exactly? Why don't you display this value in
>>> "sensors"?
>>>      =20
>> I get the information out of the documentation on page 26:
>> "When power on, the PWMOUT1 will output full duty cycle (FFh) to
>> enable system FAN. After 10 seconds when detecting FANIN1
>> signal, assuming the fan has been fully turned on, the fan speed
>> count detected will be recorded in the register.".
>> Dunno if it should be removed?
>>    =20
>  =20
> Oh, I see, it is recording the maximum possible speed. It should be
> marked read-only then, I guess. I am also reluctant to naming this
> feature fan1_max, even if we don't use that name yet, because the _max
> suffix is only used for limits at the moment so it might be confusing
> to use _max for something else now. Maybe fan1_full? This should be
> discussed separately. In the meantime, I suggest that you omit this
> value in libsensors.
>
>  =20
It is alreadt readonly. I think renaming to full is a good idea, that's=20
what the
datasheet calls it as well.

> fan1_min =3D 0 isn't an error per se. If you see an error, then something
> else must be wrong. Can you read the value from fan1_min directly from
> sysfs?
>
>  =20
it was not getting updated in f75375_update_device, fixed. The actual=20
value should
be written to the chip anyway.
>
> temp1_max_hyst is supposed to represent the hysteresis temperature
> value for the temp1_max limit, and the value should be passed as the
> 3rd argument to print_temp_info(). If it reads 0, maybe that's a driver
> bug. Again, try reading the value directly from sysfs. And please
> report the problems you find to the driver author so that he can fix
> them.
>  =20
This weirder, it should actually update it properly.
>  =20
>>>       { "coretemp", print_coretemp },
>>>       { "dme1737", print_dme1737 },
>>>      { "applesmc", print_applesmc },
>>> +    { "F75373", print_f75373 },
>>>
>>> Should be "f75373", no capital. I'm even surprised it worked with the
>>> capital.
> I see. This suggests that the driver itself identifies the chip as
> F75373, and that's not correct. You need to put "f75373" in sensors,
> and the driver needs to be updated in the same way.
>
>  =20
This is being set as the client->name, I'll change that to lower case.
> Except for the leading capital, yes, it's OK. That being said, what's
> the difference between the F75373 and the F75375? If the F75375 has
> less inputs, then you'll need to adjust the code in "sensors" to not
> try to display the missing inputs.
>  =20
The main difference is that F75375 supports more fan speed control modes=20
than
F75373: automatic temperature triggered fan-speed setting and linear=20
voltage feeding
to fan. Only the latter is supported by the driver atm.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
