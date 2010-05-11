From: Arne Riecken <arne.riecken@googlemail.com>
Date: Tue, 11 May 2010 10:57:58 +0000
Subject: Re: [lm-sensors] after some days,
Message-Id: <n2x8cb75a4a1005110357v37a3bc26zab1d6dc1c533c3ac@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <g2p8cb75a4a1005110155u5b359f97z8e16ab5a2c475455@mail.gmail.com>
In-Reply-To: <g2p8cb75a4a1005110155u5b359f97z8e16ab5a2c475455@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Thanks,

mainboard is a Super Micro X8SIE-F

I do not know how to reproduce it. It happens every week or so.



2010/5/11 Jean Delvare <khali@linux-fr.org>:
> Hi Arne,
>
> On Tue, 11 May 2010 10:55:27 +0200, Arne Riecken wrote:
>> after some days some min or max values for sensors get zero and
>> therefore an alaram is triggered. sonsors -s cures that but only if
>> the values are defined in the sensors3.conf. If default values are
>> used, there is no way out, You have to manually set them.
>>
>> chip "w83627ehf-*" "w83627dhg-*"
>>
>> Linux 2.6.26-2-xen-amd64
>>
>> OS Debian 5.0 "Lenny"
>>
>> For example today VBAT max was suddenly 0, I had to reread it with
>> sensors -s as You see below the correct value again.
>
> Actually, sensors -s is _writing_ the limits to the chip, not reading
> them.
>
>> How to fix that?
>>
>> # sensors
>> w83627dhg-isa-0a10
>> Adapter: ISA adapter
>> VCore: =A0 =A0 =A0 +0.91 V =A0(min =3D =A0+0.60 V, max =3D =A0+1.49 V)
>> in1: =A0 =A0 =A0 =A0+12.20 V =A0(min =3D +10.82 V, max =3D +13.20 V)
>> AVCC: =A0 =A0 =A0 =A0+3.26 V =A0(min =3D =A0+3.14 V, max =3D =A0+3.47 V)
>> 3VCC: =A0 =A0 =A0 =A0+3.26 V =A0(min =3D =A0+3.14 V, max =3D =A0+3.47 V)
>> in4: =A0 =A0 =A0 =A0 +1.55 V =A0(min =3D =A0+1.35 V, max =3D =A0+1.65 V)
>> in6: =A0 =A0 =A0 =A0 +4.74 V =A0(min =3D =A0+4.25 V, max =3D =A0+5.25 V)
>> VSB: =A0 =A0 =A0 =A0 +3.26 V =A0(min =3D =A0+2.98 V, max =3D =A0+3.47 V)
>> VBAT: =A0 =A0 =A0 =A0+3.12 V =A0(min =3D =A0+2.80 V, max =3D =A0+3.47 V)
>> CPU Fan: =A0 =A02636 RPM =A0(min =3D 1205 RPM, div =3D 8)
>> Aux Fan: =A0 =A012735 RPM =A0(min =3D 8035 RPM, div =3D 1)
>> Sys Temp: =A0 =A0+31.0=B0C =A0(high =3D +60.0=B0C, hyst =3D +50.0=B0C) =
=A0sensor =3D thermistor
>> CPU Temp: =A0 =A0+38.5=B0C =A0(high =3D +95.0=B0C, hyst =3D +90.0=B0C) =
=A0sensor =3D diode
>> AUX Temp: =A0 =A0+38.5=B0C =A0(high =3D +80.0=B0C, hyst =3D +75.0=B0C) =
=A0sensor =3D diode
>> cpu0_vid: =A0 +1.300 V
>
> Which hardware is this? Odds are that the registers are being
> overwritten by the BIOS, or the hardware is faulty.
>
> If you can easily reproduce the problem, the first thing to try is to
> unload the w83627ehf driver and check whether the problem still
> happens. You'll have to use "isadump 0xa15 0xa16" to dump the register
> values, and check for the value of registers 0x2b to 0x3e. My guess is
> that you will see them go to 0 even without the driver. If I am right,
> this will prove the driver is innocent.
>
> It would also be a good idea to disassemble the ACPI DSDT table to check
> whether APCI is poking at the hardware monitoring registers. If you
> send your table to me in private, I'll take a look.
>
> --
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
