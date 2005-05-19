From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: Tyan 2462 (ticket #813)
Message-Id: <3C7C579E.ABCE77D3@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020215152003.A26195@stikine.ucs.sfu.ca>
In-Reply-To: <20020215152003.A26195@stikine.ucs.sfu.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

thanks for the feedback.
See doc/fan-divisors for an explanation of your fan_div 'peculiarity'
mds


Martin Siegert wrote:
>=20
> Hi,
>=20
> FYI:
>=20
> I just tried what you described at
> http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket=813
> i.e., I got the CVS version of w83781d
> and compiled it. On the Tyan 2462 (Thunder K7) there is no BIOS option
> to initialize the hardware sensors - they seem to be on always.
>=20
> Anyway:
>=20
> # modprobe i2c-amd756
> # modprobe i2c-proc
> # modprobe i2c-dev
> # modprobe w83781d init=3D0 force_subclients=3D0,0x2c,0x4a,0x4b
>=20
> works successfully:
>=20
> # sensors -s
> # sensors
> w83627hf-i2c-0-2c
> Adapter: SMBus AMD7X6 adapter at 80e0
> Algorithm: Non-I2C SMBus adapter
> VCore 1:   +1.74 V  (min =3D  +1.74 V, max =3D  +1.93 V)       ALARM
> VCore 2:   +1.74 V  (min =3D  +1.74 V, max =3D  +1.93 V)       ALARM
> +3.3V:     +3.37 V  (min =3D  +3.13 V, max =3D  +3.45 V)
> +5V:       +4.99 V  (min =3D  +4.72 V, max =3D  +5.24 V)
> +12V:     +11.17 V  (min =3D +10.79 V, max =3D +13.19 V)
> -12V:     -11.88 V  (min =3D -10.90 V, max =3D -13.21 V)
> -5V:       -5.61 V  (min =3D  -4.76 V, max =3D  -5.26 V)
> V5SB:      +5.44 V  (min =3D  +4.72 V, max =3D  +5.24 V)
> VBat:      +2.88 V  (min =3D  +2.40 V, max =3D  +3.60 V)
> fan1:        0 RPM  (min =3D 3000 RPM, div =3D 2)
> fan2:        0 RPM  (min =3D 3000 RPM, div =3D 2)
> fan3:        0 RPM  (min =3D  750 RPM, div =3D 8)
> temp1:     +44.0?C  (limit =3D  +60?C, hysteresis =3D  +50?C) sensor =3D =
3904 transistor
> temp2:       +36?C  (limit =3D  +72?C, hysteresis =3D  +32?C) sensor =3D =
3904 transistor
> temp3:       +34?C  (limit =3D  +72?C, hysteresis =3D  +32?C) sensor =3D =
3904 transistor
> vid:      +1.85 V
> alarms:   Chassis intrusion detection                      ALARM
> beep_enable:
>           Sound alarm disabled
>=20
> w83782d-i2c-0-2d
> Adapter: SMBus AMD7X6 adapter at 80e0
> Algorithm: Non-I2C SMBus adapter
> VCore 1:   +1.76 V  (min =3D  +1.74 V, max =3D  +1.93 V)
> VCore 2:   +2.84 V  (min =3D  +1.74 V, max =3D  +1.93 V)
> +3.3V:     +3.40 V  (min =3D  +3.13 V, max =3D  +3.45 V)
> +5V:       +4.89 V  (min =3D  +4.72 V, max =3D  +5.24 V)
> +12V:      +4.71 V  (min =3D +10.79 V, max =3D +13.19 V)
> -12V:      -2.11 V  (min =3D -10.90 V, max =3D -13.21 V)
> -5V:       +2.78 V  (min =3D  -4.76 V, max =3D  -5.26 V)
> V5SB:      +4.23 V  (min =3D  +4.72 V, max =3D  +5.24 V)
> VBat:      +2.91 V  (min =3D  +2.40 V, max =3D  +3.60 V)
> fan1:     5273 RPM  (min =3D 3000 RPM, div =3D 2)
> fan2:     5192 RPM  (min =3D 3000 RPM, div =3D 2)
> fan3:        0 RPM  (min =3D 1500 RPM, div =3D 4)
> temp1:     +40.0?C  (limit =3D +100?C, hysteresis =3D +127?C) sensor =3D =
3904 transistor
> temp2:       +39?C  (limit =3D  +72?C, hysteresis =3D  +32?C) sensor =3D =
3904 transistor
> temp3:       +39?C  (limit =3D  +72?C, hysteresis =3D  +32?C) sensor =3D =
3904 transistor
> vid:      +1.85 V
> alarms:   Chassis intrusion detection                      ALARM
> beep_enable:
>           Sound alarm enabled
>=20
> Thus, it looks as if I can use the first part (w83627hf-i2c-0-2c) for vol=
tages
> and temperatures and the second part (w83782d-i2c-0-2d) for fan speeds.
>=20
> Thanks a lot!
>=20
> One minor peculiarity: when I set
>=20
>     set fan1_div 1
>     set fan2_div 1
>=20
> in /etc/sensors.conf (the 5200 rpm shown above are the actual rpms, thus
> fan_div should be 1) then fan1 shows soemthing around 5200 RPM about
> half the time, the other half it shows 0, whereas fan2 is 0 all the time
> (this applies to the w83782d-i2c-0-2d section). Thus, I must set
>=20
>     set fan1_div 2
>     set fan2_div 2
>=20
> to get sensible output (ignoring the div setting).
>=20
> Cheers,
> Martin
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Martin Siegert
> Academic Computing Services                        phone: (604) 291-4691
> Simon Fraser University                            fax:   (604) 291-4242
> Burnaby, British Columbia                          email: siegert@sfu.ca
> Canada  V5A 1S6
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
