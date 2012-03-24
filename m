From: =?iso-8859-1?Q?Bj=F6rn_Gerhart?= <oss@extracloud.de>
Date: Sat, 24 Mar 2012 08:11:53 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (it87) Add support for IT8781F, IT8782F, IT8783E/F
Message-Id: <982E6473-EAC9-4FB7-9A0D-3CF70AB5D5AA@extracloud.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1331180739-19470-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1331180739-19470-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Salut Jean,

Am 24.03.2012 um 08:05 schrieb Jean Delvare:
> Hallo Bj=F6rn,
>=20
> On Sat, 24 Mar 2012 00:24:58 +0100, Bj=F6rn Gerhart wrote:
>> Am 23.03.2012 um 22:02 schrieb Jean Delvare:
>>=20
>>> On Tue, 13 Mar 2012 19:43:15 +0100, Bjoern Gerhart wrote:
>>>> 2012/3/8 Guenter Roeck <linux@roeck-us.net>:
>>>>> Assume all three are compatible and have the same functionality.
>>>>>=20
>>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>> Tested-by: Bjoern Gerhart <oss@extracloud.de>
>>>=20
>>> Care to share the output of "sensors" with us?
>>>=20
>> Sure. To be more precise, I tested with an IT8783 chip configured and wi=
red by the hardware team at the company I'm working for on a proprietary ma=
inboard. With the sensors.conf created therefore, the sensors output looks =
like this:
>>=20
>> [root@localhost ~]# LANG=3DC sensors
>> it8783-isa-0a10
>> Adapter: ISA adapter
>> CPU Core:    +1.15 V  (min =3D  +0.70 V, max =3D  +1.70 V)
>> +1.50V:      +1.50 V  (min =3D  +1.10 V, max =3D  +1.90 V)
>> +3.30V:      +3.38 V  (min =3D  +2.70 V, max =3D  +4.00 V)
>> +12.0V:     +12.16 V  (min =3D +10.69 V, max =3D +13.70 V)
>> -12.0V:     -11.95 V  (min =3D -13.68 V, max =3D -10.30 V)
>> +1.10V:      +1.12 V  (min =3D  +0.90 V, max =3D  +1.22 V)
>> VBat:        +3.09 V
>> Fan1:       1662 RPM  (min =3D  300 RPM)
>> PSU:        1245 RPM  (min =3D  500 RPM)
>> Board T.:    +30.0 C  (low  =3D  +0.0 C, high =3D +55.0 C)  sensor =3D t=
hermal diode
>> CPU T.:      +47.0 C  (low  =3D  +0.0 C, high =3D +63.0 C)  sensor =3D t=
hermal diode
>>=20
>> coretemp-isa-0000
>> Adapter: ISA adapter
>> Core 0:      +40.0 C  (high =3D +86.0 C, crit =3D +100.0 C)
>> Core 1:      +43.0 C  (high =3D +86.0 C, crit =3D +100.0 C)
>>=20
>>=20
>> These are about the same values as the "Hardware Monitor" section at the=
 BIOS setup shows also. So all values look reasonable.
>=20
> Thanks. Can we see the configuration file associated with this? What I
> am particularly interested in are in3, in7 and in8 (Vbat) as they are
> treated specially by the chip and the driver.
>=20
Ok. in3 gets ignored, maybe not wired on that design. in7 and in8 don't get=
 computed.

chip "it8783-isa-0a10"

    #=3D=3D=3D voltages
    label in0 "CPU Core"
    compute in0  @, @
    set in0_min  0.7
    set in0_max  1.7
   =20
    label in1 "+1.50V"
    compute in1 @,@
    set in1_min  1.1
    set in1_max  1.9

    label in2 "+3.30V"
    compute in2  @, @
    set in2_min  2.7
    set in2_max  4.0

    label in4 "+12.0V"
    compute in4 ((30/10) +1)*@  , @/((30/10) +1)
    set in4_min  10.7
    set in4_max  13.7

    label in6 "-12.0V"
    compute in6 (1+232/56)*@ - 4.096*232/56, (@ + 4.096*232/56)/(1+232/56)
    set in6_min  -13.7
    set in6_max  -10.3
   =20
    label in7 "+1.10V"
    set in7_min  0.89
    set in7_max  1.21
   =20
    label in8 "VBat"

    ignore  in3
    ignore  in5
    ignore  vid

    #=3D=3D=3D temps
    label temp2 "Board T."
    set temp2_min   0
    set temp2_max   55
   =20
    label temp3 "CPU T."
    compute temp3 100+@,-1*(100-@)
    set temp3_min   0
    set temp3_max   63

    ignore temp1
    ignore temp4

    #=3D=3D=3D fans
    label fan1 "Fan1"
    set fan1_min  300

    label fan3 "PSU"
    set fan3_min  500

    ignore fan2
    ignore fan4

>> In general, for future Tested-bys: does it make sense to append a kind o=
f test report (like the above one) directly after the Tested-by statement, =
or should it be located in a separate mail?
>=20
> Yes, test results are always welcome, and including them in the same
> e-mail is fine.
>=20
ok, perfect  ;-)

Bj=F6rn


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
