From: Paul Thomas <pthomas8589@gmail.com>
Date: Tue, 12 Oct 2010 00:32:53 +0000
Subject: Re: [lm-sensors] local macro
Message-Id: <AANLkTinVio5ctKdgkJsy8GAu-GotJYFn3rgCm99D9LkS@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTi=t1ObqqZiamKdZGHxrWc6FEP-QqSxrsbordDTi@mail.gmail.com>
In-Reply-To: <AANLkTi=t1ObqqZiamKdZGHxrWc6FEP-QqSxrsbordDTi@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I'm not sure what you mean with "units of volts*10,000", I seriously
> doubt that the ADC's LSB has a weight of 10,000 Volts. Did you mean a
> LSB of 0.0001 Volt? If this is the case then the driver is broken and
> has to be fixed, as the sysfs ABI requires that inX files expose values
> in units of 0.001 Volt.
>
>> If you set the gain to 20 the only difference is that if
>> you try and read a voltage over 0.125 then it will be out of range.
>>
>> I understand there are hwmon devices that are dependent on external
>> amplifiers & dividers, but that is not the case here.
>
> The point isn't whether the gain is internal or external. The point is
> whether the gain should change at run-time or not. When doing voltage
> monitoring, you expect a result in a specific, short range, so the gain
> should be set for the desired range and never changed afterward. There
> are a lot of hardware monitoring devices doing exactly that, internally.
>
> The bottom line is that if your needs are different then your driver
> doesn't belong to drivers/hwmon.
>
> --
> Jean Delvare
>

OK, I'll switch to iio. So, yes it looks like the current calculation
is off by a factor of 10. I did this because of the resolution on the
a/d. Also there is an error where if the voltage is below 0 it
calculates a large number (it's not really meant to read voltages
below 0 and there is a protection diode if you drop much below 0).
This is fixed by directly assigning the ads7871_read_reg16(spi,
REG_LS_BYTE) value to a int16_t before doing the other math.

If anyone wants the adjustable gain & differential version they can
contact me directly. I'm not sure when I'll get to the iio version.

thanks,
Paul

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
