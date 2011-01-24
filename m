From: Audio Phile <da_audiophile@yahoo.com>
Date: Mon, 24 Jan 2011 21:53:53 +0000
Subject: Re: [lm-sensors] insane readings on Asus A7M266 motherboard
Message-Id: <158896.11875.qm@web36605.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <761574.42437.qm@web36601.mail.mud.yahoo.com>
In-Reply-To: <761574.42437.qm@web36601.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

...AND I should add, after finding the following: http://www.lm-sensors.org=
/ticket/2126

And using a slightly modified version of it (attached) as my /etc/sensors3.=
conf my output looks accurate.

# sensors
as99127f-i2c-0-2d
Adapter: SMBus Via Pro adapter at e800
VCore 1:     +1.81 V  (min =3D  +1.65 V, max =3D  +2.05 V)  =20
VCore 2:     +2.46 V  (min =3D  +1.65 V, max =3D  +2.05 V)  =20
+3.3V:       +3.18 V  (min =3D  +2.96 V, max =3D  +3.63 V)  =20
+5V:         +5.03 V  (min =3D  +4.49 V, max =3D  +5.51 V)  =20
+12V:       +11.98 V  (min =3D  +9.55 V, max =3D +14.41 V)  =20
-12V:       -12.95 V  (min =3D -14.66 V, max =3D -11.69 V)  =20
-5V:         -4.95 V  (min =3D  -6.00 V, max =3D  -4.04 V)  =20
CPU0 Fan:   2700 RPM  (min =3D 5273 RPM, div =3D 2)
CPU1 Fan:      0 RPM  (min =3D 337500 RPM, div =3D 2)
Chas Fan:      0 RPM  (min =3D   -1 RPM, div =3D 2)
Mobo Temp:   +34.0=B0C  (high =3D  +0.0=B0C, hyst =3D -128.0=B0C) =20
CPU0 Temp:   +47.5=B0C  (high =3D +100.0=B0C, hyst =3D +75.0=B0C) =20
CPU1 Temp:    -0.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C) =20
cpu0_vid:   +1.750 V
beep_enable:enabled


/etc/sensors3.conf

chip "as99127f-*"

# Asus A7M266-D rev 1.04 (dual CPU) AS99127F rev.2
    label in0 "VCore 1"
    label in1 "VCore 2"
    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "+12V"
    label in5 "-12V"
    label in6 "-5V"
    label temp1 "Mobo Temp"
    label temp2 "CPU0 Temp"
    label temp3 "CPU1 Temp"
    label fan1 "CPU0 Fan"
    label fan2 "CPU1 Fan"
    label fan3 "Chas Fan"

    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
    compute in5 (3.14 * @) - 14.91  ,  (@ + 14.91) / 3.14
    compute in6 (3.14 * @) -  7.71  ,  (@ +  7.71) / 5.14

    set in0_min vid*0.95
    set in0_max vid*1.05
    set in1_min vid*0.95
    set in1_max vid*1.05
    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in4_min 12 * 0.90
    set in4_max 12 * 1.10
    set in5_max -12 * 0.90
    set in5_min -12 * 1.10
    set in6_max -5 * 0.95
    set in6_min -5 * 1.05

    set temp1_over 44
    set temp1_hyst 40
    set temp2_over 64
    set temp2_hyst 61
    set temp3_over 64
    set temp3_hyst 61

    set fan1_min 3000
    set fan2_min 3000
    set fan3_div 4
    set fan3_min 1800




--- On Mon, 1/24/11, Jean Delvare <khali@linux-fr.org> wrote:

> From: Jean Delvare <khali@linux-fr.org>
> Subject: Re: [lm-sensors] insane readings on Asus A7M266 motherboard
> To: "Audio Phile" <da_audiophile@yahoo.com>
> Cc: lm-sensors@lm-sensors.org
> Date: Monday, January 24, 2011, 4:27 PM
> On Mon, 24 Jan 2011 13:10:29 -0800
> (PST), Audio Phile wrote:
> > --- On Mon, 1/24/11, Jean Delvare <khali@linux-fr.org>
> wrote:
> >=20
> > > This alone is usually a good hint that the
> VIA686A/B
> > > integrated sensors
> > > aren't used on the board.
> >=20
> > I thought so too but it worked for years until I had
> to reinstall.
>=20
> No, it did not. The VIA686A/B sensors are _not_ used on
> this board, I
> am totally positive on this.
>=20
> > > The A7M266, as most Asus board at the time, is
> using an
> > > Asus-specific
> > > ASIC for hardware monitoring, rather than the
> sensors
> > > integrated in the
> > > south bridge. In your case, that would be an
> AS99127F, so
> > > you should
> > > load the w83781d driver rather than the via686a
> driver.
> > > sensors-detect
> > > should have told you exactly this,
> >=20
> > I tried this:
> >=20
> > # rmmod via686a
> > # modprobe w83781d
> > # sensors
> > No sensors found!
> > Make sure you loaded all the kernel drivers you need.
> > Try sensors-detect to find out which these are.
>=20
> So for some reason the AS99127F isn't usable by the w83781d
> driver.
>=20
> > > BTW. If it did not,
> > > please send the
> > > full output of sensors-detect for analysis.
> >=20
> > Attached.=20
> > (...)
> > Lastly, we can probe the I2C/SMBus adapters for
> connected hardware
> > monitoring devices. This is the most risky part, and
> while it works
> > reasonably well on most systems, it has been reported
> to cause trouble
> > on some systems.
> > Do you want to probe the I2C/SMBus adapters now?
> (YES/no): YES
> > Using driver `i2c-viapro' for device 0000:00:04.4: VIA
> Technologies VT82C686 Apollo ACPI
> > Module i2c-dev loaded successfully.
> >=20
> > Next adapter: NVIDIA i2c adapter=A0 (i2c-0)
> > Do you want to scan it? (YES/no/selectively): YES
> >=20
> > Next adapter: NVIDIA i2c adapter=A0 (i2c-1)
> > Do you want to scan it? (YES/no/selectively): YES
> >=20
> > Next adapter: NVIDIA i2c adapter=A0 (i2c-2)
> > Do you want to scan it? (YES/no/selectively): YES
>=20
> The VIA Pro SMBus isn't probed, meaning that the driver
> failed to bind
> to the device. You should see some error message in the
> kernel logs
> when i2c-viapro is loaded.
>=20
> One possible cause is an ACPI resource conflict [1]. I am a
> little
> surprised as I didn't expect this kind of problem on such
> an old board.
> If this is the case, booting with
> acpi_enforce_resources=3Dlax should
> solve your problem.
>=20
> [1] http://www.lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworki=
nginkernel2.6.31
>=20
> --=20
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
>=20


     =20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
