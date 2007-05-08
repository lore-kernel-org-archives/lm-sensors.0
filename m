From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 08 May 2007 09:55:58 +0000
Subject: Re: [lm-sensors] Negative values after fan replacement
Message-Id: <20070508115558.063f0756@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1178141638.9629.47.camel@camposuperbo>
In-Reply-To: <1178141638.9629.47.camel@camposuperbo>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Rouven,

On Wed, 02 May 2007 23:33:58 +0200, Rouven Sacha wrote:
> I'm new to the list, this is my first post, so please tell me if there's
> any information missing.
>=20
> After a reaching 75=B0C high, our hosted server got a forced shutdown due
> to an acpi event today.
>=20
> May  2 18:41:37 blinkenmail kernel: ACPI: Critical trip point
> May  2 18:41:37 blinkenmail kernel: Critical temperature reached (76 C),
> shutting down.
> May  2 18:41:37 blinkenmail shutdown[2522]: shutting down for system
> halt
> May  2 18:41:37 blinkenmail kernel: ACPI: Unable to turn cooling device
> [c1b17dec] 'on'
> May  2 18:41:38 blinkenmail init: Switching to runlevel: 0
> May  2 18:41:43 blinkenmail kernel: ACPI: Critical trip point
> May  2 18:41:43 blinkenmail kernel: Critical temperature reached (75 C),
> shutting down.
> May  2 18:41:43 blinkenmail kernel: ACPI: Unable to turn cooling device
> [c1b17dec] 'on'

You may want to report this to the ACPI folks and/or your hardware
vendor, as this looks like a bug either in the Linux acpi code, or in
your system's BIOS.

> It's a debian etch xen-dom0 running linux 2.6.18-4. I tried to
> investigate, so I installed lm-sensors ( 2.10.1-3).
>=20
> sensors-detect:
>=20
> Driver `eeprom' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus Via Pro adapter at 5000'
>     Busdriver `i2c-viapro', I2C address 0x50
>     Chip `eeprom' (confidence: 6)
>   * Bus `SMBus Via Pro adapter at 5000'
>     Busdriver `i2c-viapro', I2C address 0x51
>     Chip `eeprom' (confidence: 6)
>=20
> Driver `w83627hf' (should be inserted):
>   Detects correctly:
>   * ISA bus address 0x0290 (Busdriver `i2c-isa')
>     Chip `Winbond W83697HF Super IO Sensors' (confidence: 9)
>=20
> modprobed: i2c-viapro eeprom w83627hf
>=20
> 23:29:57 blinkenmail:~ # lsmod
> Module                  Size  Used by
> i2c_dev                 9316  0=20
> tun                    11104  1=20
> ipv6                  229088  34=20
> dm_snapshot            16320  0=20
> dm_mirror              20048  0=20
> dm_mod                 51000  2 dm_snapshot,dm_mirror
> w83627hf               23344  0=20
> hwmon_vid               3552  1 w83627hf
> eeprom                  7792  0=20
> i2c_isa                 5920  1 w83627hf
> i2c_viapro              9012  0=20
> i2c_core               20480  5 i2c_dev,w83627hf,eeprom,i2c_isa,i2c_viapro
> tulip                  48768  0=20
> shpchp                 33632  0=20
> pci_hotplug            29472  1 shpchp
> psmouse                35880  0=20
> pcspkr                  3840  0=20
> serio_raw               7428  0=20
> via_agp                10432  1=20
> agpgart                32264  1 via_agp
> evdev                   9856  0=20
> rtc                    13300  0=20
> ext3                  120072  1=20
> jbd                    53224  1 ext3
> mbcache                 9124  1 ext3
> ide_disk               15712  3=20
> via82cxxx               9156  0 [permanent]
> generic                 6244  0 [permanent]
> ide_core              112392  3 ide_disk,via82cxxx,generic
> via_rhine              24456  0=20
> mii                     6112  1 via_rhine
> ehci_hcd               29288  0=20
> uhci_hcd               22188  0=20
> sata_via               10980  0=20
> usbcore               114372  3 ehci_hcd,uhci_hcd
> libata                 90868  1 sata_via
> scsi_mod              125160  1 libata
> thermal                14376  0=20
> processor              29608  1 thermal
> fan                     5572  0=20
>=20
>=20
> and sensors gave me:
>=20
> 21:01:27 blinkenmail:plugins # sensors
>         w83697hf-isa-0290
>         Adapter: ISA adapter
>         VCore:     +1.68 V  (min =3D  +0.26 V, max =3D  +0.54 V)      ALA=
RM
>         +3.3V:     +3.26 V  (min =3D  +0.66 V, max =3D  +3.87 V)
>         +5V:       +5.03 V  (min =3D  +0.03 V, max =3D  +0.86 V)      ALA=
RM
>         +12V:     +11.49 V  (min =3D  +5.72 V, max =3D  +4.99 V)      ALA=
RM
>         -12V:     -11.62 V  (min =3D -13.59 V, max =3D  -3.07 V)
>         -5V:       -4.90 V  (min =3D  +0.53 V, max =3D  -2.89 V)      ALA=
RM
>         V5SB:      +5.43 V  (min =3D  +5.46 V, max =3D  +1.29 V)      ALA=
RM
>         VBat:      +3.28 V  (min =3D  +0.14 V, max =3D  +1.04 V)      ALA=
RM
>         fan1:     2220 RPM  (min =3D 4963 RPM, div =3D 8)             ALA=
RM
>         fan2:     4017 RPM  (min =3D 2481 RPM, div =3D 8)      =20
>         temp1:       +28=B0C  (high =3D   +64=B0C, hyst =3D  -102=B0C)  s=
ensor =3D thermistor          =20
>         temp2:     +68.5=B0C  (high =3D   +75=B0C, hyst =3D   +70=B0C)  s=
ensor =3D diode          =20
>         alarms:   Chassis intrusion detection                     ALARM
>         beep_enable:
>                   Sound alarm enabled
>        =20
> The system had a load of under 0.10 and the values for temp1 changed
> between 65 and 69=B0C. I told the support guy of our hoster that there
> might be something wrong with the cpu fan and he replaced it with a new
> one, he said.

It seems he really did, as the fan1 reading is higher now (2556 RPM
instead of 2220 RPM).

> Now sensors gives me a constant value of -93,5=B0C for temp2:
>=20
> 23:24:13 blinkenmail:~ # sensors
> w83697hf-isa-0290
> Adapter: ISA adapter
> VCore:     +1.68 V  (min =3D  +0.26 V, max =3D  +0.54 V)       ALARM =20
> +3.3V:     +3.25 V  (min =3D  +0.66 V, max =3D  +3.89 V)             =20
> +5V:       +5.03 V  (min =3D  +0.03 V, max =3D  +0.86 V)       ALARM =20
> +12V:     +11.55 V  (min =3D  +5.59 V, max =3D  +4.99 V)       ALARM =20
> -12V:     -11.54 V  (min =3D -14.91 V, max =3D  -3.07 V)             =20
> -5V:       -4.90 V  (min =3D  +0.53 V, max =3D  -6.10 V)       ALARM =20
> V5SB:      +5.46 V  (min =3D  +5.46 V, max =3D  +1.29 V)       ALARM =20
> VBat:      +3.28 V  (min =3D  +0.14 V, max =3D  +1.04 V)       ALARM =20
> fan1:     2556 RPM  (min =3D 4963 RPM, div =3D 8)              ALARM =20
> fan2:     4017 RPM  (min =3D 2481 RPM, div =3D 8)                    =20
> temp1:       +33=B0C  (high =3D   +64=B0C, hyst =3D  -102=B0C)   sensor =
=3D thermistor          =20
> temp2:     -93.5=B0C  (high =3D   +75=B0C, hyst =3D   +70=B0C)   sensor =
=3D diode          =20
> alarms:   Chassis intrusion detection                      ALARM
> beep_enable:
>           Sound alarm enabled
>=20
>=20
> What does that mean?
>=20
> Any hints are appreciated,

I don't know. Did the temp2 value change at all after that? If this is
the first time you installed lm_sensors on this machine, we can't
exclude that the fan change and the temperature value breakage are
uncorrelated. Maybe it would have happened anyway. Although I admit
this is a suspicious coincidence.

I guess that you didn't power-off the system, and that it isn't really
an option?

Does the ACPI temperature look reasonable ("acpi -t" or look directly
in /proc/acpi/thermal_zone/*/temperature)? It could be a conflict
between ACPI and the w83627hf driver. Can you please send me (in
private) a copy of /proc/acpi/dsdt?

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
