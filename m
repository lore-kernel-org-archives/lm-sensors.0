From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 21 Feb 2014 08:01:34 +0000
Subject: Re: [lm-sensors] Sensors configuration for Gigabyte GA-945GCM-S2L
Message-Id: <20140221090134.34cdb450@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392920982.2747.YahooMailNeo@web160506.mail.bf1.yahoo.com>
In-Reply-To: <1392920982.2747.YahooMailNeo@web160506.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Ian,

On Thu, 20 Feb 2014 10:29:42 -0800 (PST), ianp wrote:
> ### Sensors configuration for Gigabyte GA-945GCM-S2L motherboard
> ### 2014-02-21, ianp <snailbox88-dev -at- yahoo -dot- com>
> ### Thanks to Jean Delvare
> ### Comments are welcome.
>=20
>=20
> chip "it8718-*"
>=20
> ### Voltages
>=20
> =A0=A0 label=A0 in0=A0 "Vcore"
> =A0=A0 label=A0 in1=A0 "Vram"=A0=A0=A0 # "DDR18V" in BIOS
> =A0=A0 label=A0 in2=A0 "+3.3V"
> =A0=A0 ignore in3=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # no +5V monitor, not =
used
> =A0=A0 label=A0 in4=A0 "+12V"
> =A0=A0 ignore in5=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # these inputs
> =A0=A0 ignore in6=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # are not used
> =A0=A0 ignore in7=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 # by the board
>=20
> =A0=A0 ### Scale +12V.
>=20
> =A0=A0 compute=A0 in4=A0 @*3.9633,=A0 @/3.9633
>=20
> =A0=A0 ### Set in0 according to CPU VID voltage range.
> =A0=A0 ### Set min and max values according to preference.
>=20
> =A0=A0 set in0_min=A0 0.850
> =A0=A0 set in0_max=A0 1.362
> =A0=A0 set in1_min=A0 1.8
> =A0=A0 set in1_max=A0 1.9

1.8 V is the nominal value for DDR2, so setting in1_min to 1.8 seems
risky. I would simply use:

=A0=A0 set in1_min=A0 1.8 * 0.95
=A0=A0 set in1_max=A0 1.8 * 1.05

as with every other voltage.

> =A0=A0 set in2_min=A0 3.3 * 0.95
> =A0=A0 set in2_max=A0 3.3 * 1.05
> =A0=A0 set in4_min=A0=A0 12 * 0.95
> =A0=A0 set in4_max=A0=A0 12 * 1.05
>=20
> ### Temperatures
>=20
> =A0=A0 ### Ignore temp1 and temp2 as those aren't used.
>=20
> =A0=A0 ignore temp1
> =A0=A0 ignore temp2
> =A0=A0 label=A0 temp3=A0 "CPU Temp"
>=20
> =A0=A0 ### Set according to CPU.
>=20
> =A0=A0 set temp3_min 20
> =A0=A0 set temp3_max 55

These are fairly strict limits. There's no reason why the CPU couldn't
operate below 20=B0C, at least down to 10=B0C. Values below 20=B0C are
possible right after boot, or when using water-cooling.

Likewise, these CPUs can run over 55=B0C without trouble. I would allow
at least 60=B0C to avoid triggering the alarm too frequently.

> ### Fans
>=20
> =A0=A0 ### Ignore fan3 as it isn't used.
>=20
> =A0=A0 label=A0 fan1=A0 "CPU Fan"
> =A0=A0 label=A0 fan2=A0 "CHA Fan"
> =A0=A0 ignore fan3
>=20
> =A0=A0 ### Set according to preference.
>=20
> =A0=A0 set fan1_min 900
> =A0=A0 set fan2_min 0

Added to the wiki as:
http://www.lm-sensors.org/wiki/Configurations/Gigabyte/GA-945GCM-S2L

Thanks for your contribution!

--=20
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
