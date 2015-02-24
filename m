From: cedric <cedric321@hotmail.fr>
Date: Tue, 24 Feb 2015 15:15:09 +0000
Subject: Re: [lm-sensors] Test with Chip IT8620E on a Gigabyte GA-H97M-HD3 version 2
Message-Id: <BLU436-SMTP224365FAC861A3E45E4A07F90160@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU436-SMTP1351904A8E5B1CC00D893290240@phx.gbl>
In-Reply-To: <BLU436-SMTP1351904A8E5B1CC00D893290240@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello Jean

Thank you for your reply.

Le 24/02/2015 14:21, Jean Delvare a =E9crit
>> chip "coretemp-isa-0000"
>>
>> # ark.intel.com
>> # maxi 72 degrees C
>>
>> label temp1 "CPU Temp"
>> compute temp1  @ + 10, @ / @ - 10
>> compute temp2  @ + 10, @ / @ - 10
>> compute temp3  @ + 10, @ / @ - 10
> Which CPU model is this? If the coretemp driver doesn't get TjMax
> right, it should be fixed.

It's a Intel Pentium G3258.

ark.intel.com :Tcase_     72=B0C

lm-sensors dislay without CPU work and with the original /etc/sensors3.conf

coretemp-isa-0000
Adapter: ISA adapter
Physical id 0:  +21.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
Core 0:         +21.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
Core 1:         +20.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)


>> # FAN
>>
>> label fan1 "CPU Fan"
>> set fan1_min 700
>> compute fan1 1.17 * @, @ / 1.17
> Most certainly wrong (scaling is never needed for fan speed) unless the
> IT8620E uses a different clock frequency than all other chips. Rather
> unlikely if you ask me. So I think your fan has some form of automatic
> speed control, either integrated or done by the chipset, and it spins
> faster in the BIOS simply because the CPU is busier in the BIOS. If I am
> correct then just put some load on the CPU under Linux and you'll get
> the same fan speed as in the BIOS without the compute statement above.
>

lm-sensors dislay without CPU work and with the original /etc/sensors3.conf

fan1:        1180 RPM  (min =3D  597 RPM)


Thank you for the precision about the CPU load in BIOS.
I will test it with some load on the CPU under Linux.

Goodbye

C=E9dric.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
