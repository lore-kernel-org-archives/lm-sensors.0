From: npfdd@gmx.ch (Daniel Schregenberger)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: lmsensors-CVS on 2.6.0-test10
Message-Id: <1070140823.4318.10.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031126190459.724240ad.npfdd@gmx.net>
In-Reply-To: <20031126190459.724240ad.npfdd@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

[Replying to my own mail]

I got it working!
All I had to do was to include ISA support in the kernel. (in the
meantime I switched to test11)

Now I load the following modules:
w83781d, i2c_sensor, i2c_dev, i2c_isa, i2c_i801, i2c_core
and get these results from sensors:

w83627thf-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
in0:       +3.14 V  (min =3D  +0.00 V, max =3D  +0.00 V)             =20
in1:       +3.20 V  (min =3D  +0.00 V, max =3D  +0.00 V)             =20
in2:       +3.36 V  (min =3D  +2.98 V, max =3D  +3.63 V)             =20
in3:       +3.04 V  (min =3D  +2.69 V, max =3D  +3.26 V)             =20
in4:       +3.07 V  (min =3D  +2.85 V, max =3D  +3.46 V)             =20
in7:       +3.04 V  (min =3D  +2.69 V, max =3D  +3.26 V)             =20
in8:       +3.30 V  (min =3D  +2.70 V, max =3D  +3.30 V)       ALARM =20
fan1:        0 RPM  (min =3D  187 RPM, div =3D 32)                    =20
fan2:        0 RPM  (min =3D 3000 RPM, div =3D 2)                    =20
fan3:     2500 RPM  (min =3D 1500 RPM, div =3D 4)                    =20
temp1:       +31?C  (high =3D  +127?C, hyst =3D   +60?C)   sensor thermisto=
r          =20
temp2:     +33.0?C  (high =3D   +60?C, hyst =3D   +50?C)   sensor PII/Celer=
on diode          =20
temp3:    +208.0?C  (high =3D   +50?C, hyst =3D   +50?C)   sensor thermisto=
r          =20
vid:      +0.000 V
alarms:  =20
beep_enable:
          Sound alarm disabled

Now I'll have to find the proper settings in the conf file for my board.
Some strange things in the above listing are: fan3 is the power supply
and corresponds exactly with the real values but the processor fan is
not listed. Maybe because my BIOS always complains it "failed"? It
rotates very slow since I exchanged the Intel boxed for a more silent
one. But it definately rotates. :)
And I don't know what temperature belongs to CPU or mainboard and what's
the third?

Anyway: seems I'm on the right way.

-- Daniel


On Wed, 2003-11-26 at 19:04, Daniel Schregenberger wrote:
> Hello!
>=20
> I'm using an ASUS P4C800E-Deluxe which has a Winbond w83627thf
> SuperIO-Chip. I have to use the beta Kernel because the Onboard LAN and
> the SerialATA-Controller cause each other problems under 2.4.x (the LAN
> won't work there).
>=20
> I've tried to load the new user-space tools as suggested on the homepage
> but it didn't work out. I'm not sure where the problem is. Maybe I
> missed something I should compile into the kernel (do I need those
> I2C-Algorithm-Modules (BitBanging-Device etc.) ?; and what about
> ISA-Support? I don't have any ISA-Slots so I turned it off but
> apparently the ISA-Bus is still present...)
>=20
> Here are the results of my tries:
>=20
> # modprobe i2c-i801
>=20
> # ./lm_sensors2/prog/detect/i2cdetect=20
> Error: No i2c-bus specified!
> Syntax: i2cdetect I2CBUS
>   I2CBUS is an integer
>   Installed I2C busses:
>     i2c-0       unknown         SMBus I801 adapter at 0400            =20
> Algorithm unavailable
>=20
> # modprobe w83781d
>=20
> # sensors=20
> No sensors found!
>=20
> # lsmod
> Module                  Size  Used by
> w83781d                33856  0=20
> i2c_sensor              2304  1 w83781d
> i2c_i801                7052  0=20
> i2c_core               21124  3 w83781d,i2c_sensor,i2c_i801
>=20
> I also tried 2.7.1 before I figured out I need 2.6 to enable my LAN and
> this is what sensorsdetect (under 2.4.x) told me to load:
> MODULE_0=3Di2c-i801
> MODULE_1=3Di2c-isa
> MODULE_2=3Dlm75
> MODULE_3=EEprom
> MODULE_4=3Dsmbus-arp
> MODULE_5=3Dit87
>=20
> So now I tried to load these modules (as far as they existed) on 2.6:
>=20
> # modprobe lm75
> # modprobe eeprom
> # modprobe it87 =20
>=20
> # sensors=20
> eeprom-i2c-0-52
> Adapter: SMBus I801 adapter at 0400
> Algorithm: Unavailable from sysfs
> ERROR: data 1
>=20
> eeprom-i2c-0-50
> Adapter: SMBus I801 adapter at 0400
> Algorithm: Unavailable from sysfs
> ERROR: data 1
>=20
> lm75-i2c-0-49
> Adapter: SMBus I801 adapter at 0400
> Algorithm: Unavailable from sysfs
> ERROR: Can't get temperature data!
>=20
> lm75-i2c-0-48
> Adapter: SMBus I801 adapter at 0400
> Algorithm: Unavailable from sysfs
> ERROR: Can't get temperature data!
>=20
> Since this didn't work out and sensorsdetect not always gave me the same
> results when I started it back in 2.4.x I don't really know what to do
> know. sensorsdetect isn't yet functional on 2.6 kernels so I'm a bit
> lost.
>=20
> Any help appreciated. I can provide more information if necessary, just
> tell me what you need.
>=20
> Oh and I also tried it on test9 before I installed test10 with the same
> results.
>=20
> -- Daniel
