From: Andrew Lyon <andrew.lyon@gmail.com>
Date: Fri, 17 Sep 2010 08:01:27 +0000
Subject: Re: [lm-sensors] Supermicro X7DWA-N All fans controlled by pwm3?
Message-Id: <AANLkTim4gMcuxAb2xLfO2oEqLhUGS6HbXPc75kWRuO8e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTik0r3VKaeG-=kattdUq=imC=UuaK6qBH-N8mCb7@mail.gmail.com>
In-Reply-To: <AANLkTik0r3VKaeG-=kattdUq=imC=UuaK6qBH-N8mCb7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, Sep 15, 2010 at 5:13 PM, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Andrew,
>
> On Tue, 14 Sep 2010 09:52:12 +0100, Andrew Lyon wrote:
>> I have a system with Supermicro X7DWA-N motherboard, according to the
>> manual it has "Winbond W83627HF w/Hardware Monitor support: W83793" so
>> I've loaded both the w83627hf and w83793 modules and several sensors
>> and fans are detected, however when I try to control fan speed I find
>> that the only pwm output which has any effect is pwm3 and it seems to
>> control all of the fans at once, also pwm1 is locked at 112:
>
> What's the value of pwm1_enable? Could be that this PWM output is not
> currently in manual control mode.

The only devices with pwm and enable in the name are:

/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002f/temp1_pwm_enable
/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002f/temp2_pwm_enable
/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002f/temp3_pwm_enable
/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002f/temp4_pwm_enable
/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002f/temp5_pwm_enable


All currently set to 2.

>
> Which kernel are you running?

2.6.34.7

>
> The w83793 driver is still marked experimental, there could be a bug in
> it.
>
>>
>> ubermicro 0-002f # pwd
>> /sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002f
>> ubermicro 0-002f # lspci | grep =A01f.3
>> 00:1f.3 SMBus: Intel Corporation 631xESB/632xESB/3100 Chipset SMBus
>> Controller (rev 09)
>> ubermicro 0-002f # ls pwm?
>> pwm1 =A0pwm2 =A0pwm3 =A0pwm4 =A0pwm5 =A0pwm6 =A0pwm7 =A0pwm8
>> ubermicro 0-002f # cat pwm?
>> 112
>> 0
>> 160
>> 0
>> 0
>> 0
>> 0
>> 0
>>
>>
>> ubermicro 0-002f # echo 0 >pwm3
>> ubermicro 0-002f # sensors | grep fan
>> fan1: =A0 =A0 =A0 1564 RPM =A0(min =3D =A0712 RPM)
>> fan2: =A0 =A0 =A0 1652 RPM =A0(min =3D =A0712 RPM)
>> fan3: =A0 =A0 =A0 1636 RPM =A0(min =3D =A0712 RPM)
>> fan4: =A0 =A0 =A0 1638 RPM =A0(min =3D =A0712 RPM)
>> fan6: =A0 =A0 =A0 2351 RPM =A0(min =3D =A0712 RPM)
>> fan7: =A0 =A0 =A0 1622 RPM =A0(min =3D =A0712 RPM)
>> fan8: =A0 =A0 =A0 1605 RPM =A0(min =3D =A0712 RPM)
>>
>> ubermicro 0-002f # echo 140 >pwm3
>> ubermicro 0-002f # sensors | grep fan
>> fan1: =A0 =A0 =A0 1973 RPM =A0(min =3D =A0712 RPM)
>> fan2: =A0 =A0 =A0 2089 RPM =A0(min =3D =A0712 RPM)
>> fan3: =A0 =A0 =A0 2064 RPM =A0(min =3D =A0712 RPM)
>> fan4: =A0 =A0 =A0 2051 RPM =A0(min =3D =A0712 RPM)
>> fan6: =A0 =A0 =A0 2755 RPM =A0(min =3D =A0712 RPM)
>> fan7: =A0 =A0 =A0 2048 RPM =A0(min =3D =A0712 RPM)
>> fan8: =A0 =A0 =A0 2002 RPM =A0(min =3D =A0712 RPM)
>>
>>
>> Is it possible to gain control of the fans individually?
>
> Very unlikely. PWM signal routing to fans is a hardware thing, it's
> been decided by your motherboard vendor and you have to live with it.
>
> Here I have an Asus server board with 8 fan inputs, 2 PWM output
> controls, one controls the 2 CPU fans, and the other one controls the 6
> case fans. So it's similar to your board, only slightly better because
> CPU fans have their own control.
>
> It is possible (but again unlikely) that the hardware vendor
> implemented a user-controllable PWM routing. In that case it would
> certainly be advertised by said vendor, and exposed in the BIOS or by
> some custom tool. But I don't think I've ever seen this in practice.
> And I don't think it would make too much sense (it would be cheaper to
> route PWM outputs individually and group them at the software level if
> needed.)
>
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
