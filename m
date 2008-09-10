From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 10 Sep 2008 08:02:06 +0000
Subject: Re: [lm-sensors] Results of running your sensors-detect
Message-Id: <20080910100206.6087d0c1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48C719D9.90000@gmail.com>
In-Reply-To: <48C719D9.90000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Dean,

On Tue, 09 Sep 2008 17:50:33 -0700, Dean Loros wrote:
> Hi Jean--
>=20
> I'm baffled--I ran the copy of sensors-detect you wanted me
> to....Results are:
>=20
> dean@linux:~/Desktop$ sudo '/home/dean/Desktop/sensors-detect'
> (...)
> Next adapter: SMBus nForce2 adapter at 1c80 (i2c-1)
> Do you want to scan it? (YES/no/selectively): y
> Client found at address 0x2d
> (...)
> Probing for `National Semiconductor LM78'...                Success!
>     (confidence 6, driver `lm78')

The code preventing the misdetection was only for ISA access to the
device, not I2C access. I've just fixed that.

> (...)
> Probing for `Winbond W83627DHG'...                          No

This fails because the chip is not in bank 0 (and we can't reliably
detect it in that case.) No big deal anyway, the w83627ehf driver
doesn't make use of the I2C interface, so this detection doesn't need
to succeed for things to work.

> (...)
> Client found at address 0x49
> Probing for `National Semiconductor LM75'...                No
> Probing for `Dallas Semiconductor DS75'...                  No
> Probing for `National Semiconductor LM77'...                No
> Probing for `Dallas Semiconductor DS1621/DS1631'...         No
> Probing for `National Semiconductor LM92'...                No
> Probing for `National Semiconductor LM76'...                No
> Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No

Mysterious one. Please provide the output of:

modprobe i2c-dev
i2cdump 1 0x49

Maybe that's a new chip we don't know about.

The rest is as expected.

> Values afterwards:
>=20
>=20
> dean@linux:~/Desktop$ sensors
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:       +40.0=B0C  (crit =3D +60.0=B0C)
>=20
> w83627dhg-isa-0290
> Adapter: ISA adapter
> VCore:       +1.28 V  (min =3D  +1.05 V, max =3D  +1.58 V)
> in1:         +6.92 V  (min =3D  +5.91 V, max =3D +10.40 V)
> AVCC:        +3.33 V  (min =3D  +2.30 V, max =3D  +3.47 V)
> 3VCC:        +3.33 V  (min =3D  +3.50 V, max =3D  +4.08 V)   ALARM
> in4:         +1.28 V  (min =3D  +2.04 V, max =3D  +2.04 V)   ALARM
> in5:         +1.55 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> in6:         +5.86 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> VSB:         +3.33 V  (min =3D  +3.14 V, max =3D  +3.47 V)
> VBAT:        +3.04 V  (min =3D  +2.64 V, max =3D  +3.47 V)
> Case Fan:   3125 RPM  (min =3D  332 RPM, div =3D 16)
> CPU Fan:    2556 RPM  (min =3D  332 RPM, div =3D 16)
> Aux Fan:       0 RPM  (min =3D  340 RPM, div =3D 128)  ALARM
> fan4:       1654 RPM  (min =3D  803 RPM, div =3D 16)
> fan5:          0 RPM  (min =3D    0 RPM, div =3D 128)
> CPU Temp:    +34.0=B0C  (high =3D +127.0=B0C, hyst =3D  +0.0=B0C)  sensor=
 =3D transistor
> M/B Temp:    +36.5=B0C  (high =3D  +1.0=B0C, hyst =3D  +0.0=B0C)  ALARM  =
sensor > thermistor
>=20
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +38.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
>=20
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +45.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
>=20
> coretemp-isa-0002
> Adapter: ISA adapter
> Core 2:      +45.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
>=20
> coretemp-isa-0003
> Adapter: ISA adapter
> Core 3:      +47.0=B0C  (high =3D +80.0=B0C, crit =3D +100.0=B0C)
>=20
> lm78-i2c-1-2d
> Adapter: SMBus nForce2 adapter at 1c80
> VCore 1:     +2.56 V  (min =3D  +2.10 V, max =3D  +3.15 V)
> VCore 2:     +2.10 V  (min =3D  +1.79 V, max =3D  +3.15 V)
> +3.3V:       +3.33 V  (min =3D  +2.30 V, max =3D  +3.47 V)
> +5V:         +3.33 V  (min =3D  +3.50 V, max =3D  +4.08 V)   ALARM
> +12V:        +2.56 V  (min =3D  +4.08 V, max =3D  +4.08 V)   ALARM
> -12V:        +3.10 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> -5V:         +3.66 V  (min =3D  +0.00 V, max =3D  +0.00 V)   ALARM
> fan1:       50000 RPM  (min =3D 5314 RPM, div =3D 1)  ALARM
> fan2:       40909 RPM  (min =3D 5314 RPM, div =3D 1)  ALARM
> fan3:          0 RPM  (min =3D 21774 RPM, div =3D 2)  ALARM
> temp1:       +88.0=B0C  (high =3D +100.0=B0C, hyst =3D +120.0=B0C)  ALARM
> cpu0_vid:   +3.000 V
>=20
>=20
> I would say that SMBus nForce2 has my two "missing" fan speeds, but
> looks like the multiplier is a bit off......

No, no. Again, the LM78 is a misdetection. Do not load the lm78 driver.
I don't know what chip handles your extra fans, but that's definitely
not the chip at I2C address 1-2d.

> What do you think?

Please download the latest version of sensors-detect again:
http://www.lm-sensors.org/browser/lm-sensors/branches/lm-sensors-3.0.0/prog=
/detect/sensors-detect?format=3Dtxt
I've fixed the misdetection, it will no longer suggest the lm78 driver.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
