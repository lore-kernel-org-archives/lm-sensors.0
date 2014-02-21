From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 21 Feb 2014 10:21:27 +0000
Subject: Re: [lm-sensors] Configuration for Gigabyte Z77-D3H
Message-Id: <20140221112127.7461cab8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <52D45149.20804@tuxedo.ath.cx>
In-Reply-To: <52D45149.20804@tuxedo.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Mathias,

On Mon, 13 Jan 2014 21:49:13 +0100, Mathias Gerber wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Hi Folks
>=20
> Finally I could demystify most of the sensor values for this mainboard.
> My configuration file is attached to this email.
>=20
> Not clear is the temp1 reading. Should be PCH temp AFAIK.
> But here I read most of the time 32=B0C or sometimes 33=B0C.

Did you compare with what the BIOS says? It shows only two temperature
AFAIK, CPU and M/B. I would bet that temp1 actually us the M/B
temperature and temp2 isn't wired (25=B0C is the "neutral" temperature of
thermistor setups typically.)

> chip "acpitz-virtual-0"
>     ignore temp1 # stays always at 27.8=B0C
>     ignore temp2 # dito
>=20
> chip "it8728-*"
>=20
>     label in0 "0: CPU Vtt"

I've dropped all the prefixes in voltage labels.

What makes you think this is Vtt and not Vcore? Almost all boards have
Vcore on in0.

>     set in0_min 1.02    # I'm liberal with these, 2-3% tops
>     set in0_max 1.08    # after that, cpu gets very unstable
>=20
>     label in1 "1: +3.3V"
>     set in1_min 3.3 * 0.95    # Some boards including GA-H67MA-UD2H
>     set in1_max 3.3 * 1.05    # don't have 3.3V voltage reading
>     compute in1 1.649*@,@/1.649 # multipliers provided by Martin Malik au=
thor of hwinfo

Couldn't you figure it out from the BIOS?

>     label in2 "2: +12V"
>     set in2_min 12 * 0.95
>     set in2_max 12 * 1.05
>     compute  in2  @ * (72/12), @ / (72/12) #mg,15.05.13
>=20
>     label in3 "3: +5V"
>     set in3_min 5 * 0.95
>     set in3_max 5 * 1.05
>     compute in3 2.5*@,@/2.5
>
>     label in4 "4: Vaxg"	# Voltage used by the video controller embedded i=
nside the CPU
>     set in4_min 0.4
>     set in4_max 1.4
>=20
>     label in5 "5: Vcore"
>     set in5_min 0.825 * 0.95
>     set in5_max 1.425 * 1.05
>=20
>     label in6 "6: Vdram"
>     set in6_min 1.5 * 0.95    # adjust these, 1.35 for LVDDR3
>     set in6_max 1.5 * 1.05    # 1.5V is recommended, 1.65 tops
>     =20
>     label in7 "7: 3VSB"
>     set in7_min 3.00 * 0.95
>     set in7_max 3.00 * 1.05

3VSB is normally 3.3V so these limits look wrong.

Does the it87 driver say anything about voltage mapping when you load
it? If in7 us 3VSB it should already be labeled properly.

>=20
>     label in8 "8: Vbat"
>     set in8_min  3.0 * 0.90
>     set in8_max  3.0 * 1.10
>=20
> ### fan
>=20
>     label fan1 "CPU fan"
>     set fan1_min 700
>=20
>     ignore fan2 # comment if connected
>     label fan2 "Sys1 fan"
>     set fan2_min 0
>=20
>     label fan3 "Sys2 fan"
>     set fan3_min 200=20
>=20
>     label fan4 "Sys3 fan"
>     set fan4_min 200=20
>=20
>     ignore fan5 # comment if connected
>     label fan5 "Sys4 fan"
>     set fan5_min 0=20
>=20
> ### temperatures
>=20
>     label temp1 "PCH temp??" # shows always 33=B0C
>     set temp1_min 10
>     set temp1_max 60
>=20
>     ignore temp2
>     label temp2 "MB temp??" # shows always 25=B0C
>     set temp2_min 0
>     set temp2_max 60
>=20
>     label temp3 "CPU temp"
>     set temp3_min 10
>     set temp3_max 85
>=20
>     ignore intrusion0 # activate if in use

Current version of the configuration file is here:
http://www.lm-sensors.org/wiki/Configurations/Gigabyte/Z77-D3H

Thanks for your contribution.

--=20
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
