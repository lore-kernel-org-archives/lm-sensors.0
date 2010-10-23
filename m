From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 23 Oct 2010 15:43:00 +0000
Subject: Re: [lm-sensors] Configuration MSI 975X Platinum (MS-7246)
Message-Id: <20101023174300.331824f7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101010030436.310360@gmx.com>
In-Reply-To: <20101010030436.310360@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Leonardo,

On Sat, 09 Oct 2010 22:52:01 -0400, Leonardo Mar=EDn wrote:
> # lm_sensors configuration file for the MSI 975X Platinum (MS-7246), Bios=
 (v1.40)
> # Sensor Chip, Winbond W83627EHF/EHG
>=20
> #######################
> ### sensors3.conf ###
>=20
> chip "w83627ehf-*" "w83627dhg-*"
>=20
>  label in0 "VCore" # CPU Core Voltage
>  label in1 "VPCIEx" # PCI Express Voltage
>  label in2 "AVCC"
>  label in3 "3VCC"
>  label in6 "+ 5V" # +5V, or so i think
>  label in7 "3VSB"
>  label in8 "VBAT"
>  label in9 "+12V" # +12V, or so i think
>=20
> ## +12V is in9 and +5V is in6 ##
>  compute in9 @*(1+(56/10)), @/(1+(56/10))
>  compute in6 @*(1+(22/10)), @/(1+(22/10))

How did you differentiate between the two?

>=20
>  set in9_min 12.0*0.9
>  set in9_max 12.0*1.1
>  set in6_min 5.0*0.9
>  set in6_max 5.0*1.1
>=20
>  set in0_min 0.9
>  set in0_max 1.7

Quite a large range...

>  set in1_min 1.4
>  set in1_max 2.0

Ditto.

>  set in2_min 3.3*0.9
>  set in2_max 3.3*1.1
>  set in3_min 3.3*0.9
>  set in3_max 3.3*1.1
>  set in7_min 3.3*0.9
>  set in7_max 3.3*1.1
>  set in8_min 3.3*0.9
>  set in8_max 3.3*1.1

Vbat is supposed to be 3.0V nominal, not 3.3V!

>=20
>  ignore in4
>  ignore in5
>=20
> ## Temperatures ##
>=20
>  label temp1 "Sys Temp"
>  label temp2 "CPU Temp"
>  label temp3 "AUX Temp"
>=20
>  set temp1_max 55
>  set temp1_max_hyst 48
>  set temp2_max 55
>  set temp2_max_hyst 47

This is a large difference between max and max_hyst, I see no good
reason for this.

>  set temp3_max 55
>  set temp3_max_hyst 50
>=20
> ## Fans ##
>=20
>  label fan1 "PWR Fan"

If you mean power supply, the usual name for it is "PSU Fan".

>  label fan2 "CPU Fan"
>  label fan3 "NB Fan"
>  label fan4 "Sys Fan"
>=20
>  set fan2_min 800
>=20
>  ignore fan1
>  ignore fan3
>  ignore fan4
>  ignore fan5

As some of these are actually available on the board and just not used
in your personal case, we don't want to ignore them: other users may be
using them.

>=20
> ### end of sensors3.conf ###
> ############################
>=20
> ############
> ### demo ###
> #
> # root@LM # sensors
> # w83627ehf-isa-0290
> # Adapter: ISA adapter
> # VCore: +1.24 V (min =3D +0.90 V, max =3D +1.70 V)=20
> # VPCIEx: +1.54 V (min =3D +1.40 V, max =3D +2.00 V)=20
> # AVCC: +3.30 V (min =3D +2.98 V, max =3D +3.63 V)=20
> # 3VCC: +3.30 V (min =3D +2.98 V, max =3D +3.63 V)=20
> # + 5V: +5.02 V (min =3D +4.51 V, max =3D +5.50 V)=20
> # 3VSB: +3.25 V (min =3D +2.98 V, max =3D +3.63 V)=20
> # VBAT: +2.99 V (min =3D +2.98 V, max =3D +3.63 V)=20
> # +12V: +12.14 V (min =3D +10.82 V, max =3D +13.20 V)=20
> # CPU Fan: 3515 RPM (min =3D 803 RPM, div =3D 16)
> # Sys Temp: +39.0=B0C (high =3D +55.0=B0C, hyst =3D +48.0=B0C) sensor =3D=
 thermistor
> # CPU Temp: +35.5=B0C (high =3D +55.0=B0C, hyst =3D +47.0=B0C) sensor =3D=
 diode
> # AUX Temp: +46.0=B0C (high =3D +55.0=B0C, hyst =3D +50.0=B0C) sensor =3D=
 thermistor
> # cpu0_vid: +1.288 V
> #
> #### end demo ###
> #################

The output of "sensors -c /dev/null" would be helpful to validate your
work.

Thanks for your contribution, I've added your configuration file to the
wiki. It can be amended at any time if you improve it.

http://www.lm-sensors.org/wiki/Configurations/MSI/975X-Platinum

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
