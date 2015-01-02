From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 02 Jan 2015 08:53:56 +0000
Subject: Re: [lm-sensors] SuperMicro H8DG6-F-O IPMI BMC and lm_sensors
Message-Id: <20150102085356.GA29009@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADw2B2PqoMeXkr0yVPbn_R=z17yM6F1QgefYwBmvaqHHqtCDKA@mail.gmail.com>
In-Reply-To: <CADw2B2PqoMeXkr0yVPbn_R=z17yM6F1QgefYwBmvaqHHqtCDKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, Jan 01, 2015 at 03:07:25PM -0800, G. Richard Bellamy wrote:
> I need help configuring lm_sensors for a SuperMicro H8DG6-F-O motherboard.
>=20
> I have an interesting challenge... my motherboard is a SuperMicro
> H8DG6-F-O motherboard with an IPMI BMC Chipset [1], and I'm trying to
> collect fan speed (among other things) via lm-sensors. I've been in
> ongoing discussions with SuperMicro, and I need some help - I can get
> what I need via the IPMI interface:
> --------------------------------------------------------------------------
> 2014-12-28 10:35:58
> rbellamy@x i ~  % sudo ipmitool sdr
> CPU1 Temp        | 0x00              | ok
> CPU2 Temp        | 0x00              | ok
> System Temp      | 40 degrees C      | ok
> CPU1 Vcore       | 1.04 Volts        | ok
> CPU2 Vcore       | 0.92 Volts        | ok
> CPU1 DIMM        | 1.52 Volts        | ok
> CPU2 DIMM        | 1.52 Volts        | ok
> +1.1 V           | 1.10 Volts        | ok
> +1.8 V           | 1.83 Volts        | ok
> +5 V             | 4.99 Volts        | ok
> +12 V            | 12.14 Volts       | ok
> VTT              | 1.14 Volts        | ok
> +3.3 V           | 3.26 Volts        | ok
> +3.3VSB          | 3.34 Volts        | ok
> VBAT             | 3.14 Volts        | ok
> FAN 1            | no reading        | ns
> FAN 2            | no reading        | ns
> FAN 3            | no reading        | ns
> FAN 4            | 441 RPM           | cr
> FAN 5            | no reading        | ns
> FAN 6            | no reading        | ns
> FAN 7            | 961 RPM           | ok
> FAN 8            | 1024 RPM          | ok
> Intrusion        | 0x01              | ok
> PS Status        | 0x01              | ok
> --------------------------------------------------------------------------
>=20
> But nothing comes through for sensors:
> --------------------------------------------------------------------------
> 2014-12-28 10:36:00
> rbellamy@eanna i ~  % sudo sensors
> fam15h_power-pci-00c4
> Adapter: PCI adapter
> power1:       72.18 W  (crit =3D 115.21 W)
>=20
> fam15h_power-pci-00d4
> Adapter: PCI adapter
> power1:       55.81 W  (crit =3D 115.21 W)
>=20
> k10temp-pci-00c3
> Adapter: PCI adapter
> temp1:        +24.2=B0C  (high =3D +70.0=B0C)
>                        (crit =3D +70.0=B0C, hyst =3D +67.0=B0C)
>=20
> k10temp-pci-00cb
> Adapter: PCI adapter
> temp1:        +24.2=B0C  (high =3D +70.0=B0C)
>=20
> k10temp-pci-00d3
> Adapter: PCI adapter
> temp1:        +15.2=B0C  (high =3D +70.0=B0C)
>                        (crit =3D +70.0=B0C, hyst =3D +67.0=B0C)
>=20
> k10temp-pci-00db
> Adapter: PCI adapter
> temp1:        +15.2=B0C  (high =3D +70.0=B0C)
>=20
> radeon-pci-4200
> Adapter: PCI adapter
> temp1:        +74.5=B0C  (crit =3D +120.0=B0C, hyst =3D +90.0=B0C)
>=20
> jc42-i2c-0-1d
> Adapter: SMBus PIIX4 adapter at 0b00
> temp1:        +39.4=B0C  (low  =3D  +0.0=B0C)                  ALARM (HIG=
H, CRIT)
>                        (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)
>                        (crit =3D  +0.0=B0C, hyst =3D  +0.0=B0C)
>=20
> jc42-i2c-0-1f
> Adapter: SMBus PIIX4 adapter at 0b00
> temp1:        +37.5=B0C  (low  =3D  +0.0=B0C)                  ALARM (HIG=
H, CRIT)
>                        (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)
>                        (crit =3D  +0.0=B0C, hyst =3D  +0.0=B0C)
>=20
> w83627dhg-isa-0a10
> Adapter: ISA adapter
> Vcore:        +2.04 V  (min =3D  +2.04 V, max =3D  +2.04 V)  ALARM
> in1:          +2.04 V  (min =3D  +2.04 V, max =3D  +2.04 V)  ALARM
> AVCC:         +4.08 V  (min =3D  +4.08 V, max =3D  +4.08 V)  ALARM
> +3.3V:        +4.08 V  (min =3D  +4.08 V, max =3D  +4.08 V)  ALARM
> in4:          +2.04 V  (min =3D  +2.04 V, max =3D  +2.04 V)  ALARM
> in5:          +2.04 V  (min =3D  +2.04 V, max =3D  +2.04 V)  ALARM
> in6:          +2.04 V  (min =3D  +2.04 V, max =3D  +2.04 V)  ALARM
> 3VSB:         +4.08 V  (min =3D  +4.08 V, max =3D  +4.08 V)  ALARM
> Vbat:         +4.08 V  (min =3D  +4.08 V, max =3D  +4.08 V)  ALARM
> fan1:           0 RPM  (min =3D    0 RPM, div =3D 128)  ALARM
> fan2:           0 RPM  (min =3D    0 RPM, div =3D 128)  ALARM
> fan3:           0 RPM  (min =3D    0 RPM, div =3D 128)  ALARM
> fan4:           0 RPM  (min =3D    0 RPM, div =3D 128)  ALARM
> temp1:         -1.0=B0C  (high =3D  -1.0=B0C, hyst =3D  -1.0=B0C)  ALARM =
 sensor
> =3D CPU diode
> temp2:         +0.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM =
 sensor
> =3D CPU diode
> temp3:         +0.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM =
 sensor
> =3D CPU diode
> cpu0_vid:    +0.000 V
> intrusion0:  ALARM
> --------------------------------------------------------------------------
>=20
> I've seen mention that I shouldn't be using the Windbond w83627dhg
> sensor, as the temps and fans aren't connected. Is this true, or am I
> just missing the correct SMBus offsets?
>=20
You can see from the values above that the sensors are not connected (noe of
them as far as I can see).

> SuperMicro recommends against installing lm_sensors:
> --------------------------------------------------------------------------
> SuperMicro: We are not recommend user install lmssenors or any 3th
> party sensor monitor utility to monitor sensor reading on motherboard
> with IPMI (BMC) chipset. It could cause system to crash due to 2
> sensors monitor probing sensor reading in the same time.
> Me: So you are saying NOT to install lm-sensors with a BMC-equipped mothe=
rboard?
> SuperMicro: Yes. Our LAB able the duplicate issue regarding system
> crash when installing lm-sensor on motherboard with BMC-equipped
> motherboard. System crash could happen in random time.
> --------------------------------------------------------------------------
>=20
> Does that make sense to the list?
>=20
Yes, that is correct.

> Their advice is confusing, since at the same time as they were telling
> me to NOT install lm_sensors, they gave me the offsets necessary to
> make the WinBond work with lm_sensors:
>=20
> SuperMicro:
> --------------------------------------------------------------------------
> Please check the offset address for lm-sensor to match information below.
>=20
> Windbond W83795AG, Slave Address=3D0x2f (0x5E in 8-Bit format)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Fan1 Fan Speed, Offset 0x2e         RPM =3D 84375/Data
> Fan2 Fan Speed, Offset 0x2f         RPM =3D 84375/Data
> Fan3 Fan Speed, Offset 0x30         RPM =3D 84375/Data
> Fan4 Fan Speed, Offset 0x31         RPM =3D 84375/Data
> Fan5 Fan Speed, Offset 0x32         RPM =3D 84375/Data
> Fan6 Fan Speed, Offset 0x33         RPM =3D 84375/Data
> Fan7 Fan Speed, Offset 0x34         RPM =3D 84375/Data
> Fan8 Fan Speed, Offset 0x35         RPM =3D 84375/Data
> CPU1 Voltage, Offset 0x10           Voltage =3D Data* 0.008
> CPU2 Voltage, Offset 0x11           Voltage =3D Data* 0.008
> CPU1 DIMM Voltage, Offset 0x12            Voltage =3D Data* 0.008
> CPU2 DIMM Voltage, Offset 0x13            Voltage =3D Data* 0.008
> CPU1 DIMM VTT Voltage, Offset 0x14  Voltage =3D Data* 0.008
> CPU2 DIMM VTT Voltage, Offset 0x15  Voltage =3D Data* 0.008
> +1.1V Voltage, Offset 0x16          Voltage =3D Data* 0.008
> +1.8V Voltage, Offset 0x17          Voltage =3D Data* 0.008
> +5V Voltage, Offset 0x18            Voltage =3D Data* 0.008 * (40/10)
> +12V Voltage, Offset 0x19           Voltage =3D Data* 0.008/ (10./66.2)
> -12V Voltage, Offset 0x1a           Voltage =3D
> ((Data*0.008-2.048)/(10./242.))+2.048
> HT Voltage, Offset 0x1b             Voltage =3D Data* 0.008
> +3.3V Voltage, Offset 0x1c          Voltage =3D Data* 0.024
> +3.3VSB Voltage, Offset 0x1d        Voltage =3D Data* 0.024
> VBAT Voltage, Offset 0x1e           Voltage =3D Data* 0.024
> CPU1 Temperature, Offset 0x26       Temperature =3D Data
> CPU2 Temperature, Offset 0x27       Temperature =3D Data
> System Temperature, Offset 0x1f           Temperature =3D Data
> Air Temperature, Offset 0x20        Temperature =3D Data
> VRD1 Temperature, Offset 0x21       Temperature =3D Data
> VRD2 Temperature, Offset 0x22       Temperature =3D Data
> NB Temperature, Offset 0x23         Temperature =3D Data
> Chassis Intrusion, Bank 0, Offset 0x46, BitMask 0x40  1 =3D Bad, 0 =3D Go=
od
>                   (Clear Bit: Bank 0, Offset 0x4d, BitMask 0x80)
>=20
That information is not very helpful by itself. What you would need is to l=
oad
the i2c-i801 driver to connect to the SMBus (i2 bus), and the w83795 driver
to access the W83795AG chip.

>=20
> Power Supply Failure, GP31(From W83527HG) 1 =3D Good, 0 =3D Bad
> --------------------------------------------------------------------------
>=20
> I found mention of this on the List Archive [2].
>=20
> I also found the configuration settings for a SuperMicro H8DC8 with a
> WinBond W83627HF. [3]
>=20
> I am unclear about using the WinBond vs IPMI - are they the same (I
> think not)? If they're not, should I be using WinBond with this
> motherboard, or stick with IPMI? If I should stick with IPMI, there is
> no lm_sensor support for the BMC chipset, so what are my options? I
> would rather not have to abandon lm_sensors, for any number of reasons
> - not least of which is I would then have to roll my own sysstat,
> removing all lm_sensor deps.
>=20
You should stick with IPMI. The reason that you can not see the w83795 in t=
he
output of the 'sensors' command is that the memory space for accessing the =
i2c
controller (i2c-i801 driver) is reserved by ACPI. You can override that,
and connect to the controller anyway, but then you risk the above mentioned
crashes. You would have to disable the BMC (if that is possible) if you want
to access the chip through lm-sensors.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
