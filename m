From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 20 Oct 2010 20:56:45 +0000
Subject: Re: [lm-sensors] Tyan S2466 and lm_sensors 3
Message-Id: <20101020225645.008d8838@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1P8fJt-000075-89@mendel.bio.caltech.edu>
In-Reply-To: <E1P8fJt-000075-89@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi David,

On Wed, 20 Oct 2010 13:31:33 -0700, David Mathog wrote:
> Updated a Tyan S2466 machine from Mandriva 2008.1 to 2010.0 and that
> took it to lm_sensors version 3 on kernel 2.6.31.13.  Found a
> sensors.conf file on this site for version 3 and modified it slightly to
> match labels from the previous version (see below). Also deleted this
> line in /etc/modprobe.conf, apparently not needed with the new version:
>=20
> options w83781d force_w83782d=3D0,0x2d force_subclients=3D0,0x2d,0x4c,0x4d
> ignore=3D0,0x2c init=3D0
>=20
> left this line, perhaps that is a problem:
>=20
> alias char-major-89 i2c-dev

This one is essentially useless (but harmless) if your system uses udev.

> Rebooted.  Sensors mostly works but there are two problems.
>=20
> 1. the cpu fan speed is low by a factor of 2 (or very close to two)
> 2. w83627hf-isa-0c00 temperatures do not work at all. =20
>=20
> I would like to resolve both of these issues.
>=20
> Tried putting in
>=20
> set fan1_div 2
> set fan2_div 2
>=20
> (the original div was 8 or 4, I don't recall which right now).  After
> restarting lm_sensors twice the div in sensors output changed to 2, but
> the CPU fan RPMs are still half that seen in the BIOS monitor.=20

Please read this FAQ entry:

http://www.lm-sensors.org/wiki/FAQ/Chapter3#Myfansreportexactlyhalfdoubleth=
eirvaluescomparedtotheBIOS

> Here is typical output on the 2010.0 system:
>=20
> w83627hf-isa-0c00
> Adapter: ISA adapter
> VCore1:      +1.62 V  (min =3D  +1.57 V, max =3D  +1.73 V)  =20
> VCore2:      +1.62 V  (min =3D  +1.57 V, max =3D  +1.73 V)  =20
> +3.3V:       +3.38 V  (min =3D  +3.14 V, max =3D  +3.47 V)  =20
> +12V:       +11.44 V  (min =3D +13.21 V, max =3D +10.83 V)   ALARM
> -12V:       -12.20 V  (min =3D -13.18 V, max =3D -10.80 V)  =20
> CPU1 Fan:      0 RPM  (min =3D 2657 RPM, div =3D 2)  ALARM
> CPU0 Fan:   3292 RPM  (min =3D 10546 RPM, div =3D 2)  ALARM
> VRM1 Temp:   +75.0=B0C  (high =3D  +2.0=B0C, hyst =3D +20.0=B0C)  ALARM  =
sensor > thermistor
> AGP Temp:    +75.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
> DDR Temp:    +75.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
> cpu0_vid:   +1.650 V
> beep_enable:disabled
>=20
> w83782d-i2c-0-2d
> Adapter: SMBus AMD768 adapter at 80e0
> V AGP:       +3.42 V  (min =3D  +3.14 V, max =3D  +3.47 V)  =20
> +5V:         +4.92 V  (min =3D  +4.76 V, max =3D  +5.24 V)  =20
> V DDR:       +1.23 V  (min =3D  +1.18 V, max =3D  +1.44 V)  =20
> +3.3 VSB:    +3.33 V  (min =3D  +2.85 V, max =3D  +3.15 V)   ALARM
> Bat V:       +3.15 V  (min =3D  +2.64 V, max =3D  +3.95 V)  =20
> Ch Fan 1:      0 RPM  (min =3D  664 RPM, div =3D 8)  ALARM
> Ch Fan 2:   4560 RPM  (min =3D  664 RPM, div =3D 8)
> Ch Fan 3:   4500 RPM  (min =3D 1328 RPM, div =3D 4)
> VRM 2 Temp:  +29.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM  =
sensor > transistor
> CPU1 Temp:   +30.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D transistor
> CPU0 Temp:   +31.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D transistor
> cpu0_vid:   +0.000 V
> beep_enable:enabled
>=20
>=20
> and this is what is seen on an (identical hardware, except a slightly
> slower CPU fan) 2008.1 system:
>=20
> w83782d-i2c-0-2d
> Adapter: SMBus AMD768 adapter at 80e0
> VCore 1:   +1.65 V  (min =3D  +0.00 V, max =3D  +0.00 V)       ALARM =20
> VCore 2:   +1.65 V  (min =3D  +0.00 V, max =3D  +0.00 V)       ALARM =20
> V AGP:     +3.41 V  (min =3D  +3.14 V, max =3D  +3.47 V)             =20
> +5V:       +4.89 V  (min =3D  +4.76 V, max =3D  +5.24 V)             =20
> V DDR:     +4.68 V  (min =3D  +4.50 V, max =3D  +5.47 V)             =20
> +3.3VSB:   +3.31 V  (min =3D  +3.14 V, max =3D  +3.47 V)             =20
> Ch Fan 1:    0 RPM  (min =3D 1585 RPM, div =3D 2)              ALARM =20
> Ch Fan 2: 4283 RPM  (min =3D 1585 RPM, div =3D 2)                    =20
> Ch Fan 3: 3050 RPM  (min =3D 1585 RPM, div =3D 2)                    =20
> VRM 2:       +27=B0C  (high =3D    +0=B0C, hyst =3D   +32=B0C)   sensor >=
 transistor          =20
> CPU1 Temp: +26.0=B0C  (high =3D   +80=B0C, hyst =3D   +75=B0C)   sensor >=
 transistor          =20
> CPU0 Temp: +27.5=B0C  (high =3D   +80=B0C, hyst =3D   +75=B0C)   sensor >=
 transistor          =20
> vid1:     +0.000 V  (VRM Version 9.0)
> alarms:  =20
> beep_enable:
>           Sound alarm enabled
>=20
> w83627hf-isa-0c00
> Adapter: ISA adapter
> VCore 1:   +1.63 V  (min =3D  +1.57 V, max =3D  +1.73 V)             =20
> VCore 2:   +1.63 V  (min =3D  +1.57 V, max =3D  +1.73 V)             =20
> +3.3V:     +3.39 V  (min =3D  +3.14 V, max =3D  +3.47 V)             =20
> +12V:     +11.52 V  (min =3D +10.83 V, max =3D +13.21 V)             =20
> -12V:     -12.20 V  (min =3D -13.18 V, max =3D -10.80 V)             =20
> CPU1 Fan:    0 RPM  (min =3D 7031 RPM, div =3D 2)              ALARM =20
> CPU0 Fan: 4655 RPM  (min =3D 3729 RPM, div =3D 2)                    =20
> Ch Fan 4:    0 RPM  (min =3D 3214 RPM, div =3D 2)              ALARM =20
> VRM 1:       +31=B0C  (high =3D   +76=B0C, hyst =3D  -125=B0C)   sensor >=
 transistor          =20
> AGP:       +31.0=B0C  (high =3D   +80=B0C, hyst =3D   +75=B0C)   sensor >=
 transistor          =20
> DDR:       +28.0=B0C  (high =3D   +80=B0C, hyst =3D   +75=B0C)   sensor >=
 transistor          =20

Note how you have sensor type set to transistor here, as opposed to
thermistor on the other (non-working) system. You should uncomment the
set temp#_type statements in the chip "w83627hf-*" section of your
configuration file, and then run "sensors -s" to apply the change. Your
temperature readings should be back then.

> vid2:     +1.650 V  (VRM Version 9.0)
> alarms:   Chassis intrusion detection                      ALARM
> beep_enable:
>           Sound alarm enabled
>=20
>=20
> This is the sensors3.conf file on the 2010.0 system:
>=20
>     #    Sensors configuration file used by 'libsensors' for Tyan S2466-4M
> #
> # Edited by: kevin schlichter <kevins at tyan dot com> 05.16.03
> # Update 07.30.03:kevin schlichter: add vid support
> # Update 2009-Apr-01 Adam Thompson <athompso at athompso dot net>:
> radically=20
> #   updated for lm_sensors 3.0.2 & Linux kernel 2.6.27 (aka Ubuntu 8.10)
> #
> # Note that in the 2.6 series of kernels, with lm_sensors 3.0.2, it is
> # no longer necessary to jump through force_subclient=3D and ignore_* hoo=
ps
> # when loading the w83782d module; its default behaviour is sufficient
> # to support itself correctly (and it finds the 3 subclients without any
> # additional prompting).  This does NOT allow access to the other chip,
> # a W83627HF, over I2C, but this second chip is mapped into the ISA I/O=20
> # space anyway, and loading the "w83627hf" module without any options=20
> # locates it and accesses it perfectly fine.  See also notes below about
> # the inadvisability of overusing the I2C bus on this motherboard anyway.
> # This has only been tested on MY board, which is the -4M variant, with
> # BIOS 4.06.  Depending on your BIOS version, you may or may not want to =

> # use the "init=3D0" module options INSTEAD OF setting various mins & max=
es=20
> # below, particularly temperature-wise.  YMMV.
> # -Adam Thompson, 2009-Apr-01
> #####
> #
> # Modified by Mathog to match older sensors.conf names 10/20/10.
> #
>=20
> # set min/max limits to  5% for the critical voltages
> # set min/max limits to 10% for the non-critical voltages
> # set min/max limits to 20% for the battery voltage
>=20
>=20
> chip "w83782d-*"
>     ignore  in0=20
>     ignore  in1
>     label   in2 "V AGP"
>     set     in2_min 3.3*0.95
>     set     in2_max 3.3*1.05
>     label   in3 "+5V"
>     compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
>     set     in3_min 5.0*0.95
>     set     in3_max 5.0*1.05
>     label   in4 "V DDR"
>     ignore  in5
>     ignore  in7
>     label   in6 "+3.3 VSB"
>     set     in6_max 3.0*1.05
>     set     in6_min 3.0*0.95
>     label   in8 "Bat V"
>     set     in8_min 3.3*0.80
>     set     in8_max 3.3*1.20
>     ignore  vid
>     label   fan1 "Ch Fan 1"
>     label   fan2 "Ch Fan 2"
>     label   fan3 "Ch Fan 3"
>     set fan1_min 3000
>     set fan2_min 3000
>     set fan3_min 3000
>=20
>     label   temp1 "VRM 2 Temp"
>     label   temp2 "CPU1 Temp"
>     label   temp3 "CPU0 Temp"
> #    set     temp1_type 2
> #    set     temp1_max 40=09
> #    set     temp1_max_hyst 60=09
> #    set     temp2_type 2
> #    set     temp2_max 70=09
> #    set     temp2_max_hyst 80=09
> #    set     temp3_type 2
> #    set     temp3_max 70=09
> #    set     temp3_max_hyst 80=09
>=20
> # lm_sensors ticket#1795 (http://www.lm-sensors.org/ticket/1795) also=20
> # strongly suggests using the ISA bus where possible to avoid overloading
> # the SMBus on Tyan motherboards.
> # Accessing this via ISA inb/outb also avoids the need altogether to use
> # force_subclient=3D options when loading the w83782d module.
>=20
> chip "w83627hf-*"
>     label   in0 "VCore1"
>     set     in0_min cpu0_vid*0.95
>     set     in0_max cpu0_vid*1.05
>     label   in1 "VCore2"
>     set     in1_min cpu0_vid*0.95
>     set     in1_max cpu0_vid*1.05
>     label   in2 "+3.3V"
>     set     in2_min 3.3*0.95
>     set     in2_max 3.3*1.05
>     ignore  in3
>     label   in4 "+12V"
>     compute in4 ((3.8/1)+1)*@ , @/((3.8/1)+1)
>     set     in4_max 12*0.90
>     set     in4_min 12*1.10
>     label   in5 "-12V"
>     compute in5 (5.14*@)-14.91 , (@+14.91)/5.14
>     set     in5_max -12*0.90
>     set     in5_min -12*1.10
>     ignore  in6
>     ignore  in7
>     ignore  in8
>     ignore  vid
>     label   temp1 "VRM1 Temp"
>     label   temp2 "AGP Temp"
>     label   temp3 "DDR Temp"
>     label   fan1 "CPU1 Fan"
>     label   fan2 "CPU0 Fan"
>     ignore  fan3=20
> #    set     temp1_type 2
> #    set     temp1_max 40
> #    set     temp1_max_hyst 37
> #    set     temp2_type 2
> #    set     temp2_max 52
> #    set     temp2_max_hyst 47
> #    set     temp3_type 2
> #    set     temp3_max 52
> #    set     temp3_max_hyst 47
>     set     beep_enable 0
>=20
>=20
> Thanks,
>=20
>=20
> David Mathog
> mathog@caltech.edu
> Manager, Sequence Analysis Facility, Biology Division, Caltech
>=20
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
