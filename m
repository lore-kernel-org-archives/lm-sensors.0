From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 19 Feb 2014 17:01:06 +0000
Subject: Re: [lm-sensors] Sensors configuration for ASRock G41C-GS
Message-Id: <20140219180106.2ccb522a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392823661.17478.YahooMailNeo@web160502.mail.bf1.yahoo.com>
In-Reply-To: <1392823661.17478.YahooMailNeo@web160502.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, 19 Feb 2014 07:27:41 -0800 (PST), ianp wrote:
> ### Sensors configuration for ASRock G41C-GS motherboard
> ### 2014-02-19, ianp <snailbox88-dev -at- yahoo -dot- com>
> ### Thanks to Jean Delvare and Guenter Roeck
> ### Comments are welcome.
>=20
>=20
> chip "w83627dhg-*"
>=20
>=20
> ### Voltages
>=20
> =A0=A0 ignore in1=A0=A0=A0=A0=A0=A0=A0=A0=A0 # Ignored until
> =A0=A0 ignore in4=A0=A0=A0=A0=A0=A0=A0=A0=A0 # properly identified

I have no idea about in1 and in4 either.

> =A0=A0 label=A0 in5=A0 "+5V"
> =A0=A0 label=A0 in6=A0 "+12V"
> =A0=A0 ignore cpu0_vid=A0=A0=A0=A0 # Always at 0 in my case, so ignore it
>=20
> =A0=A0 ### Scale +5V and +12V.
>=20
> =A0=A0 compute=A0 in5=A0 @*3, @/3
> =A0=A0 compute=A0 in6=A0 @*(1+56/10), @/(1+56/10)
>=20
> =A0=A0 ### Set in0 according to CPU nominal voltage.
> =A0=A0 ### Set min and max values according to preference.
>=20
> =A0=A0 set in0_min 1.2 * 0.95
> =A0=A0 set in0_max 1.2 * 1.05

What (family of) CPU is it? Typically modern CPUs have a range of
supported voltages and the voltage changes dynamically depending on
load. So you should use the lowest value to set in0_min and the highest
value to set in0_max.

> =A0=A0 set in5_min=A0=A0 5 * 0.95
> =A0=A0 set in5_max=A0=A0 5 * 1.05
> =A0=A0 set in6_min=A0 12 * 0.95
> =A0=A0 set in6_max=A0 12 * 1.05
>=20
> ### Temperatures
>=20
> =A0=A0 ### Ignore temp3 until properly identified.
>=20
> =A0=A0 label=A0 temp1=A0 "N/B Temp"
> =A0=A0 label=A0 temp2=A0 "CPU Temp"
> =A0=A0 ignore temp3

I do not recommend ignoring unidentified temperatures, they are still
useful as long as they are real (which seems to be the case here.)

>=20
> =A0=A0 ### Set according to CPU and preference.
>=20
> =A0=A0 set temp1_max=A0=A0=A0=A0=A0 60
> =A0=A0 set temp1_max_hyst 55
> =A0=A0 set temp2_max=A0=A0=A0=A0=A0 60
> =A0=A0 set temp2_max_hyst 55
>=20
> ### Fans
>=20
> =A0=A0 ### Ignore fan4 and fan5. There are
> =A0=A0 ### only 3 fan connectors on this board.
>=20
> =A0=A0 label=A0 fan1=A0 "CHA Fan"
> =A0=A0 label=A0 fan2=A0 "CPU Fan"
> =A0=A0 label=A0 fan3=A0 "PSU Fan"
> =A0=A0 ignore fan4
> =A0=A0 ignore fan5
>=20
> =A0=A0 ### Set according to preference.
>=20
> =A0=A0 set fan1_min 0
> =A0=A0 set fan2_min 900
> =A0=A0 set fan3_min 0

Initial version of the file is in the wiki now:
http://www.lm-sensors.org/wiki/Configurations/ASRock/G41C-GS

Thanks for your contribution.

--=20
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
