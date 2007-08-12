From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 12 Aug 2007 21:00:20 +0000
Subject: Re: [lm-sensors] Incorrect magnitude (=3,
Message-Id: <20070812230020.02e3cd35@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46B6797A.1080402@promptu.com>
In-Reply-To: <46B6797A.1080402@promptu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Tony,

On Mon, 06 Aug 2007 11:29:30 +1000, Tony Griffiths wrote:
> Note that this machine is running a modified version of the FC7 2.6.22=20
> kernel.  One of the modifications involved making the ipmisensors module =

> run under Linux 2.6.22 (properly)!
>=20
> [lm_sensors 2.10.3 before patch]
>=20
> [root@noakes redhat]# sensors
> bmc-isa-0000
> Adapter: ISA adapter
> CMOS Battery:
>            +3.08 V  (min =3D  +2.64 V, max =3D  +0.00 V)
> Fan 1:    3525 RPM  (min =3D  675 RPM)
> Fan 2A:   7650 RPM  (min =3D  675 RPM)
> Fan 2B:   5400 RPM  (min =3D  675 RPM)
> Fan 3A:   7650 RPM  (min =3D  675 RPM)
> Fan 3B:   5550 RPM  (min =3D  675 RPM)
> Fan 4A:   7425 RPM  (min =3D  675 RPM)
> Fan 4B:   5400 RPM  (min =3D  675 RPM)
> Fan 5A:   7575 RPM  (min =3D  675 RPM)
> Fan 5B:   5475 RPM  (min =3D  675 RPM)
> Temp:  +3.9=B0C  (high =3D    +9=B0C, hyst =3D   -13=B0C)  *** WRONG ***
> Temp: +45.0=B0C  (high =3D    +9=B0C, hyst =3D   -13=B0C)
> Planar Temp:
>            +33.0=B0C  (high =3D    +8=B0C, hyst =3D   -13=B0C)
> VRD 0 Temp:
>            +26.0=B0C  (high =3D    +7=B0C, hyst =3D   -13=B0C)
> VRD 1 Temp:
>            +28.0=B0C  (high =3D    +7=B0C, hyst =3D   -13=B0C)
>=20
>=20
> [After patch applied and RPM rebuilt]
>=20
> [root@noakes redhat]# sensors
> bmc-isa-0000
> Adapter: ISA adapter
> CMOS Battery:
>            +3.08 V  (min =3D  +2.64 V, max =3D  +0.00 V)
> Fan 1:    3525 RPM  (min =3D  675 RPM)
> Fan 2A:   7650 RPM  (min =3D  675 RPM)
> Fan 2B:   5400 RPM  (min =3D  675 RPM)
> Fan 3A:   7725 RPM  (min =3D  675 RPM)
> Fan 3B:   5550 RPM  (min =3D  675 RPM)
> Fan 4A:   7425 RPM  (min =3D  675 RPM)
> Fan 4B:   5475 RPM  (min =3D  675 RPM)
> Fan 5A:   7575 RPM  (min =3D  675 RPM)
> Fan 5B:   5475 RPM  (min =3D  675 RPM)
> Temp: +38.0=B0C  (high =3D    +9=B0C, hyst =3D   -13=B0C)
> Temp: +43.0=B0C  (high =3D    +9=B0C, hyst =3D   -13=B0C)
> Planar Temp:
>            +32.0=B0C  (high =3D    +8=B0C, hyst =3D   -13=B0C)
> VRD 0 Temp:
>            +26.0=B0C  (high =3D    +7=B0C, hyst =3D   -13=B0C)
> VRD 1 Temp:
>            +28.0=B0C  (high =3D    +7=B0C, hyst =3D   -13=B0C)
>=20
>=20
> and the output from ipmitool confirming that sensors is displaying the=20
> correct values-

Your fix is probably incomplete: I guess that the high limits should be
~80 and ~70 degrees C, and the hyst limits (which appear to really be
low limits, not hysteresis) presumably -128 degrees C. So the limits
magnitudes are wrong too.

>=20
> [root@noakes lm_sensors-2.10.3]# ipmitool -I open sdr elist
> Temp             | 01h | ok  |  3.2 | 38 degrees C
> Temp             | 02h | ok  |  3.3 | 42 degrees C
> Planar Temp      | 04h | ok  |  7.1 | 32 degrees C
> VRD 0 Temp       | 05h | ok  |  7.1 | 26 degrees C
> VRD 1 Temp       | 06h | ok  |  7.1 | 27 degrees C
> CMOS Battery     | 10h | ok  |  7.1 | 3.08 Volts
> VCORE            | 11h | ok  |  3.2 | State Deasserted
> VCORE            | 12h | ok  |  3.3 | State Deasserted
> PROC VTT         | 13h | ok  |  7.1 | State Deasserted
> 1.5V PG          | 14h | ok  |  7.1 | State Deasserted
> 1.8V PG          | 15h | ok  |  7.1 | State Deasserted
> Presence         | 20h | ok  |  3.2 | Present
> Presence         | 21h | ok  |  3.3 | Present
> Fan 1            | 30h | ok  |  7.1 | 3525 RPM
> Fan 2A           | 31h | ok  |  7.1 | 7650 RPM
> Fan 2B           | 32h | ok  |  7.1 | 5400 RPM
> Fan 3A           | 33h | ok  |  7.1 | 7725 RPM
> Fan 3B           | 34h | ok  |  7.1 | 5550 RPM
> Fan 4A           | 35h | ok  |  7.1 | 7425 RPM
> Fan 4B           | 36h | ok  |  7.1 | 5475 RPM
> Fan 5A           | 37h | ok  |  7.1 | 7500 RPM
> Fan 5B           | 38h | ok  |  7.1 | 5475 RPM
> Status           | 40h | ok  |  3.2 | Presence detected
> Status           | 41h | ok  |  3.3 | Presence detected
> VRM              | 44h | ok  |  3.2 | Presence detected
> VRM              | 45h | ok  |  3.3 | Presence detected
> OS Watchdog      | 50h | ok  |  7.1 |
> SEL              | 51h | ns  |  7.1 | Disabled
> Intrusion        | 52h | ok  |  7.1 |
> Fan Redundancy   | 54h | ok  |  7.1 | Fully Redundant
> ECC Corr Err     | 01h | ok  | 34.6 | Presence Detected, Configuration Er=
ror
> ECC Uncorr Err   | 02h | ok  | 34.6 | Presence Detected, Configuration Er=
ror
> I/O Channel Chk  | 03h | ns  | 34.6 | Disabled
> PCI Parity Err   | 04h | ok  | 34.6 | EISA failsafe timeout, Bus=20
> Correctable error
> PCI System Err   | 05h | ok  | 34.6 | EISA failsafe timeout, Bus=20
> Correctable error
> SBE Log Disabled | 06h | ok  | 34.6 |
> Logging Disabled | 07h | ns  | 34.6 | Disabled
> Unknown          | 08h | ns  | 34.6 | Disabled
> PROC Protocol    | 0Ah | ns  | 34.6 | Disabled
> PROC Bus PERR    | 0Bh | ns  | 34.6 | Disabled
> PROC Init Err    | 0Ch | ns  | 34.6 | Disabled
> PROC Machine Chk | 0Dh | ns  | 34.6 | Disabled
> Memory Spared    | 11h | ok  | 34.6 | Fully Redundant
> Memory Mirrored  | 12h | ok  | 34.6 | Fully Redundant
> Memory RAID      | 13h | ok  | 34.6 | Fully Redundant
> Memory Added     | 14h | ok  | 34.6 | Correctable ECC
> Memory Removed   | 15h | ok  | 34.6 | Correctable ECC
> PCIE Fatal Err   | 18h | ns  | 34.6 | Disabled
> Chipset Err      | 19h | ns  | 34.6 | Disabled
> Err Reg Pointer  | 1Ah | ns  | 34.6 | No Reading
>=20
> The attached patch files fix this problem for the FC7 version of=20
> lm_sensors 2.10.3 !

> --- ./lib/chips.c.orig	2007-08-06 10:25:49.000000000 +1000
> +++ ./lib/chips.c	2007-08-06 10:25:01.000000000 +1000
> @@ -5551,7 +5551,7 @@ static sensors_chip_feature bmc_features
>                                  SENSORS_BMC_FAN1+9, RW },=20
>                                  BMC_SYSCTL_FAN1+9, VALUE(1), 0 },
>      { { SENSORS_BMC_TEMP1, "temp1", NOMAP, NOMAP, R },=20
> -                           BMC_SYSCTL_TEMP1, VALUE(3), 2 , "temp1_input"=
, 3 },
> +                           BMC_SYSCTL_TEMP1, VALUE(3), 2 , "temp1_input"=
, 2 },
>      { { SENSORS_BMC_TEMP1_MIN, "temp1_min", SENSORS_BMC_TEMP1, SENSORS_B=
MC_TEMP1,=20
>                                 RW },=20
>                                 BMC_SYSCTL_TEMP1, VALUE(2), 2 },

Not correct, sorry. The temperature magnitude is standardized to 3 for
all drivers in Linux 2.6 (see Documentation/hwmon/sysfs-interface). If
you had to change it to 2 here, it means that the bmcsensors driver
itself does not respect the standard. The bmcsensors driver needs to be
fixed, not libsensors.

Or rather, libsensors needs to be fixed for all the other temperature
channels, to use the standard magnitude of 3 instead of 2.

Yani, looking at the patch which introduced this bug:
http://www.lm-sensors.org/changeset/2888
I have too comments:

* in2 and in3 both map to in2_input, and after that all the voltage
channels are shifted by one. I assume this is a bug? Or were you trying
to compensate for voltages channels starting at 0 instead of 1?

* Everything in this patch (except the bugs) only duplicates the
default mappings libsensors uses to convert Linux 2.4 symbols into
Linux 2.6 sysfs file names. So I believe that the patch was simply not
needed. As a matter of fact, the min and max limit symbols were left
untouched, and work fine. Can you please comment on this? I plan to
revert this changeset.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
