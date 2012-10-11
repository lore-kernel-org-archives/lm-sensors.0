From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 11 Oct 2012 08:33:26 +0000
Subject: Re: [lm-sensors] Temperature sensors changed by BIOS update
Message-Id: <20121011083326.GA24127@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <k554s3$g79$1@ger.gmane.org>
In-Reply-To: <k554s3$g79$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, Oct 11, 2012 at 12:56:38AM -0500, Ian Pilcher wrote:
> On 10/10/2012 10:27 PM, Guenter Roeck wrote:
> > Do you use the new nct6775 driver ? Can you provide the complete output=
 of the
> > sensors command ?
>=20
> I'm using the w83627ehf driver in Fedora 17 (3.5.6-1.fc17.x86_64).
> There does not appear to be any nct6775 module, so I assume that it's
> either not in 3.5.6 or not built as part of Fedora's kernel.
>=20
> # modinfo w83627ehf
> filename:
> /lib/modules/3.5.6-1.fc17.x86_64/kernel/drivers/hwmon/w83627ehf.ko
> license:        GPL
> description:    W83627EHF driver
> author:         Jean Delvare <khali@linux-fr.org>
> depends:        hwmon-vid
> intree:         Y
> vermagic:       3.5.6-1.fc17.x86_64 SMP mod_unload
> parm:           force_id:Override the detected device ID (ushort)
> parm:           fan_debounce:Enable debouncing for fan RPM signal (ushort)
>=20
> # modinfo nct6775
> ERROR: Module nct6775 not found.
>=20
Ok. The new driver is not upstream yet, so you would know if you use it.

> sensors -c /dev/null says:
>=20
> coretemp-isa-0000
> Adapter: ISA adapter
> Physical id 0:  +42.0=B0C  (high =3D +80.0=B0C, crit =3D +99.0=B0C)
> Core 0:         +36.0=B0C  (high =3D +80.0=B0C, crit =3D +99.0=B0C)
> Core 1:         +42.0=B0C  (high =3D +80.0=B0C, crit =3D +99.0=B0C)
> Core 2:         +35.0=B0C  (high =3D +80.0=B0C, crit =3D +99.0=B0C)
> Core 3:         +30.0=B0C  (high =3D +80.0=B0C, crit =3D +99.0=B0C)
>=20
> nct6775-isa-0290
> Adapter: ISA adapter
> in0:            +1.22 V  (min =3D  +0.20 V, max =3D  +1.60 V)
> in1:            +0.76 V  (min =3D  +0.67 V, max =3D  +0.82 V)
> in2:            +3.36 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> in3:            +3.36 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> in4:            +1.28 V  (min =3D  +1.18 V, max =3D  +1.33 V)
> in5:            +1.48 V  (min =3D  +1.40 V, max =3D  +1.60 V)
> in6:            +1.05 V  (min =3D  +0.60 V, max =3D  +1.60 V)
> in7:            +3.28 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> in8:            +3.26 V  (min =3D  +2.70 V, max =3D  +3.63 V)
> fan1:          1506 RPM  (min =3D  251 RPM, div =3D 32)
> fan2:           629 RPM  (min =3D  251 RPM, div =3D 32)
> fan3:          1506 RPM  (min =3D  251 RPM, div =3D 32)
> fan4:             0 RPM  (div =3D 128)
> SYSTIN:         +29.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sens=
or =3D CPU
> diode
> CPUTIN:         +29.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sens=
or =3D CPU
> diode
> AUXTIN:        -128.0=B0C    sensor =3D CPU diode
> PECI Agent 0:   +42.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
> PCH_CHIP_TEMP:  +46.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
> PECI Agent 1:    +0.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
> cpu0_vid:      +0.000 V
> intrusion0:    OK
>=20
Ok, then I guess it is more likely that the change was triggered by the BIOS
update. Interesting.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
