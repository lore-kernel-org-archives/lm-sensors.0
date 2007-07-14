From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 14 Jul 2007 20:15:37 +0000
Subject: Re: [lm-sensors] Weird Voltage Values on a nForce4 motherboard
Message-Id: <20070714221537.77e73766@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <67017e450707062111w7f81898y1a1274474341b979@mail.gmail.com>
In-Reply-To: <67017e450707062111w7f81898y1a1274474341b979@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jeremy,

On Sat, 7 Jul 2007 00:11:49 -0400, Jeremy Harmon wrote:
> I'm sure these voltage values can't be correct, all of the temps seem
> accurate though.
>=20
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:
>              +47=B0C
>=20
> w83627thf-isa-0290
> Adapter: ISA adapter
> VCore:     +1.57 V  (min =3D  +0.70 V, max =3D  +1.87 V)
> +12V:      +3.65 V  (min =3D  +0.79 V, max =3D  +0.79 V)       ALARM
> +3.3V:     +3.39 V  (min =3D  +0.80 V, max =3D  +0.13 V)       ALARM
> +5V:       +4.96 V  (min =3D  +6.45 V, max =3D  +5.33 V)       ALARM
> -12V:      +0.39 V  (min =3D -13.35 V, max =3D -14.91 V)       ALARM
> V5SB:      +4.95 V  (min =3D  +0.91 V, max =3D  +3.44 V)       ALARM
> VBat:      +3.06 V  (min =3D  +1.49 V, max =3D  +0.86 V)       ALARM
> fan1:        0 RPM  (min =3D 9375 RPM, div =3D 8)              ALARM
> CPU Fan:  3183 RPM  (min =3D 21093 RPM, div =3D 8)              ALARM
> fan3:     6553 RPM  (min =3D 25000 RPM, div =3D 2)              ALARM
> M/B Temp:    +38=B0C  (high =3D  +125=B0C, hyst =3D   -25=B0C)   sensor =
=3D diode
> CPU Temp:  +45.0=B0C  (high =3D   +80=B0C, hyst =3D   -25=B0C)   sensor =
=3D diode
> temp3:     +67.0=B0C  (high =3D  +125=B0C, hyst =3D   -25=B0C)   sensor =
=3D diode
> vid:      +0.000 V  (VRM Version 2.4)
> alarms:   Chassis intrusion detection                      ALARM
> beep_enable:
>           Sound alarm enabled
>=20

What motherboard is this? "nForce 4" motherboard really doesn't tell us
anything, as the sensors are NOT in the nForce4 chip.

Most of the voltages look OK to me anyway. Vcore, +3.3V, +5V, V5SB and
Vbat look OK, just the limits are not (set them in /etc/sensors.conf).
This only leaves +12V and -12V incorrect. Please write down what
voltages your BIOS shows (labels and values, in order.)

"vid" (the CPU voltage ID) is optional on the W83627THF, it seems not
to be implemented on your board, so you can simply ignore it (add an
"ignore vid" statement in /etc/sensors.conf.)

Fans and temperatures look OK, you only have to set proper labels and
limits in /etc/sensors.conf, and run "sensors -s".

>=20
> -----------------------------------
> sensors-detect
> (...)
> Next adapter: SMBus nForce2 adapter at 4c40
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x08
> Client found at address 0x2f
> Probing for `National Semiconductor LM78'...                No
> Probing for `National Semiconductor LM78-J'...              No
> Probing for `National Semiconductor LM79'...                No
> Probing for `National Semiconductor LM80'...                No
> Probing for `Analog Devices ADT7470'...                     No
> Probing for `Winbond W83781D'...                            No
> Probing for `Winbond W83782D'...                            No
> Probing for `Winbond W83792D'...                            No
> Probing for `Winbond W83793R/G'...                          No
> Probing for `Winbond W83791SD'...                           No
> Probing for `Winbond W83627HF'...                           No
> Probing for `Winbond W83627EHF'...                          No
> Probing for `Winbond W83627DHG'...                          No
> Probing for `Asus AS99127F (rev.1)'...                      No
> Probing for `Asus AS99127F (rev.2)'...                      No
> Probing for `Asus ASB100 Bach'...                           No
> Probing for `Analog Devices ADM9240'...                     No
> Probing for `Dallas Semiconductor DS1780'...                No
> Probing for `National Semiconductor LM81'...                No
> Probing for `Analog Devices ADM1029'...                     No
> Probing for `ITE IT8712F'...                                No
> Probing for `Fintek custom power control IC'...             No
> Probing for `Winbond W83791D'...                            No

Address 0x2f is typical of hardware monitoring chips, but this version
of sensors-detect did not recognize what that chip was. Please try
again with a more recent version of lm-sensors, either 2.10.3 or SVN.

If you actually have another hardware monitoring chip on your
motherboard, this can explain why some of the values reported by the
W83627THG Super-I/O chip aren't valid (although it doesn't look too bad
either.)

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
