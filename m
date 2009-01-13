From: Tobias Preclik <public@tobias.preclik.de>
Date: Tue, 13 Jan 2009 11:20:46 +0000
Subject: Re: [lm-sensors] Error getting sensor data: w83627ehf/#34
Message-Id: <496C790E.30207@tobias.preclik.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4829368250241329975=="
List-Id: <lm-sensors.vger.kernel.org>
References: <4958C1F3.9020108@tobias.preclik.de>
In-Reply-To: <4958C1F3.9020108@tobias.preclik.de>
To: lm-sensors@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============4829368250241329975==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2AD824A1CC749DB4CD34BA55"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2AD824A1CC749DB4CD34BA55
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hello Jean,

thank you for your detailed explanation. The problem seemed to be fan4
indeed. I updated lm-sensors to 3.0.2 though it is still marked as
unstable (and hard-masked because barely any applications can deal with
it) in Gentoo. But now sensord starts without complaints and the fan4 is
automatically non-existent. But still the values reported by lm-sensors
seem bogus. Especially +5V and temperatures values:

w83627ehf-isa-0290
Adapter: ISA adapter
VCore:       +1.59 V  (min =3D  +0.00 V, max =3D  +1.85 V)
+12V:       +12.04 V  (min =3D +10.82 V, max =3D +13.20 V)
AVCC:        +3.38 V  (min =3D  +3.14 V, max =3D  +3.47 V)
3VCC:        +3.36 V  (min =3D  +3.14 V, max =3D  +3.47 V)
+5V:         +4.30 V  (min =3D  +4.76 V, max =3D  +5.25 V)   ALARM
VSB:         +3.38 V  (min =3D  +3.14 V, max =3D  +3.47 V)
VBAT:        +3.28 V  (min =3D  +3.14 V, max =3D  +3.47 V)
CPU Fan:    2481 RPM  (min =3D 1704 RPM, div =3D 8)
Sys Temp:    +27.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM  =
sensor =3D
thermistor
CPU Temp:     +9.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D diode
AUX Temp:    +77.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  ALARM  =
sensor =3D
thermistor

How should I go about tweaking the temperature and voltage computations?
Should I measure the 5V lines or just fiddle about the resistor values
and pretend the raw voltage value is 5V?

What about the temperature values? The CPU temperature seems to be too
low (though the room is admittedly cooled). Unfortunately the
/proc/acpi/thermal_zone directory remains empty on this machine and I
cannot easily doublecheck the temperature. Maybe I should check the
values reported in the system BIOS...

What about the sys and aux temperatures? I seriously doubt that anything
is 77.5=B0C hot in that machine while idling. I guess the sys temp is a
dead input because the rrdcgi charts show a perfectly constant value of
27.0=B0C. Is that reasonable? Which temperature sensors do "sys temp" and=

"aux temp" correspond to anyway?

Lot's of questions...
Thanks again,
Tobias



Jean Delvare wrote:
> Hallo Tobias,
>=20
> On Mon, 29 Dec 2008 13:26:27 +0100, Tobias Preclik wrote:
>> Hello,
>>
>> i encountered a problem running sensord. I am running version 2.10.7 a=
nd
>> have a w83627ehf sensor chip on my P4V800D-X Asus mainboard. The kerne=
l
>> is a Gentoo Linux kernel version 2.6.27. The syslog states the followi=
ng:
>>
>> sensord started
>> Chip: w83627ehf-isa-0290
>> Adapter: ISA adapter
>>   Case Fan: 0 RPM (min =3D 0 RPM, div =3D 128)
>>   CPU Fan: 2481 RPM (min =3D 0 RPM, div =3D 4)
>>   Aux Fan: 0 RPM (min =3D 0 RPM, div =3D 128)
>> Error getting sensor data: w83627ehf/#34: Can't access procfs/sysfs fi=
le
>> sensord failed (23)
>>
>> As I understand it I am supposed to add "#34" to the ignore list in th=
e
>> corresponding chip section in /etc/sensors.conf. However this does not=

>> fix the problem. The sensors tool does not complain btw:
>=20
> This #34 is the libsensors feature number for the feature which is
> causing trouble. You can't use it in sensors.conf, as sensors.conf
> wants feature names, not numbers. From lib/chips.h:
>=20
> #define SENSORS_W83627EHF_FAN4		34 /* R  */
>=20
> So the problem is with fan4. If you want to ignore something, that
> would be fan4. I am not certain whether this is enough to make sensord
> happy though. Try adding:
>=20
>    ignore fan4
>=20
> to the w83627ehf configuration section and see if it helps.
>=20
> The cause of the problem is that the w83627ehf driver in Linux 2.6
> hides some inputs when the chip is configured to use the pins in
> question for other functions. The idea is to make the configuration
> easier. sensord in lm-sensors 2 isn't smart enough to cope with
> possibly missing inputs though, thus the error.
>=20
>> w83627ehf-isa-0290
>> Adapter: ISA adapter
>> VCore:     +1.59 V  (min =3D  +0.00 V, max =3D  +1.85 V)
>> in1:      +12.04 V  (min =3D  +1.80 V, max =3D  +0.00 V) ALARM
>> AVCC:      +3.38 V  (min =3D  +0.00 V, max =3D  +0.00 V) ALARM
>> 3VCC:      +3.36 V  (min =3D  +0.00 V, max =3D  +0.00 V) ALARM
>> in4:       +1.32 V  (min =3D  +0.01 V, max =3D  +0.00 V) ALARM
>> in5:       +1.71 V  (min =3D  +0.26 V, max =3D  +0.06 V) ALARM
>> in6:       +4.28 V  (min =3D  +0.00 V, max =3D  +0.00 V) ALARM
>> VSB:       +3.38 V  (min =3D  +0.00 V, max =3D  +0.00 V) ALARM
>> VBAT:      +3.28 V  (min =3D  +0.00 V, max =3D  +0.00 V) ALARM
>> in9:       +1.26 V  (min =3D  +0.00 V, max =3D  +0.00 V) ALARM
>> Case Fan:    0 RPM  (min =3D    0 RPM, div =3D 128) ALARM
>> CPU Fan:  2463 RPM  (min =3D    0 RPM, div =3D 4) ALARM
>> Aux Fan:     0 RPM  (min =3D    0 RPM, div =3D 128) ALARM
>> fan5:        0 RPM  (min =3D    0 RPM, div =3D 128)
>> Sys Temp:    +27=B0C  (high =3D    +0=B0C, hyst =3D    +0=B0C)  [therm=
istor] ALARM
>> CPU Temp:   +9.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  [CPU d=
iode ]
>> AUX Temp:  +77.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  [therm=
istor]
>>
>>
>> How can I fix this?
>=20
> This is all solved in lm-sensors 3, if you can upgrade. The changes
> required are too intrusive to be ported back to lm-sensors 2.
>=20



--------------enig2AD824A1CC749DB4CD34BA55
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAklseRIACgkQc8GdoDrONNHZsQCeMd8DiXMqKN3j7dCHWAuUiocX
hasAoKZB/UMMFnICPnMwe7pLCCyJ9wC8
=PQjY
-----END PGP SIGNATURE-----

--------------enig2AD824A1CC749DB4CD34BA55--


--===============4829368250241329975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4829368250241329975==--
