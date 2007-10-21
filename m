From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 21 Oct 2007 19:37:26 +0000
Subject: Re: [lm-sensors] dme1737 0-002e: Write to register 0x30 failed!
Message-Id: <20071021213726.65595be4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1642847378@web.de>
In-Reply-To: <1642847378@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Juergen,

On Sat, 20 Oct 2007 21:39:32 +0200, Juergen Bausa wrote:
> > Von: Jean Delvare <khali@linux-fr.org>
> > Juergen, if you load the "thermal" driver and look
> > in /proc/acpi/thermal_zone, do you see a temperature reported, with the
> > same value as one of the DME1737 temperature channels?
>=20
> Yes, I see a temperature, but its not the same.
>=20
> lisa:/home/jba# cat /proc/acpi/thermal_zone/THRM/temperature
> temperature:             40 C
> lisa:/home/jba# sensors
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:
>              +44=B0C
> Core0 Temp:
>              +46=B0C
> Core1 Temp:
>              +52=B0C
> Core1 Temp:
>              +49=B0C
>=20
> dme1737-i2c-0-2e
> Adapter: SMBus nForce2 adapter at 4c00
> V5stby:    +0.00 V  (min =3D  +0.00 V, max =3D  +6.64 V)  ALARM
> Vccp:      +1.09 V  (min =3D  +0.00 V, max =3D  +2.99 V)
> V3.3:      +3.27 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> V5:        +4.93 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> V12:      +11.78 V  (min =3D  +0.00 V, max =3D +15.94 V)
> V3.3stby:  +3.28 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> Vbat:      +2.98 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> Int Temp:    +32=B0C  (low  =3D  -127=B0C, high =3D  +127=B0C)
> CPU Temp:    +30=B0C  (low  =3D  -127=B0C, high =3D  +127=B0C)
> CPU_Fan:     0 RPM  (min =3D    0 RPM)
> ERROR: Can't get fan3 data!
> ERROR: Can't get fan5 data!
> ERROR: Can't get fan6 data!
> CPU_PWM:     0      (enable =3D 1, freq =3D  25000 Hz)
> ERROR: Can't get pwm5 data!
> ERROR: Can't get pwm6 data!
> cpu0_vid: +1.550 V  (VRM Version 2.4)
>=20
> lisa:/home/jba#                       =20

OK. It doesn't mean that ACPI doesn't get the temperatures from the
DME1737 chip though, it could be adding some arbitrary offset. Can you
please send me your DSDT table in private? I'll take a look.

I also have an experimental (but safe) patch detecting possible
conflicts between ACPI and hwmon drivers. Do you want to test it?

> > If you unload the "thermal" driver, do the dme1737 write errors go away?
>=20
> I will try this. I am not sure, but dont think thermal was loaded.

Many distributions load it by default, which makes sense for laptops,
but way less for desktops IMHO.

> (...)
> lisa:/home/jba# uname -r
> 2.6.18-5-k7
>=20
> Its a stock debian etch kernel.

Except for the dme1737 driver, of course ;)

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
