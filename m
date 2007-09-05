From: Juergen Bausa <Juergen.Bausa@web.de>
Date: Wed, 05 Sep 2007 18:23:22 +0000
Subject: Re: [lm-sensors] dme1737 module
Message-Id: <1580742676@web.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
In-Reply-To: <191fb4ca0708220911q4affac9flb4bca592c3ba3850@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


> Von: "Juerg Haefliger" <juergh@gmail.com>
>=20
> Hi Juergen,
>=20
>=20
> > > Von: "Juerg Haefliger" <juergh@gmail.com>
> > >
> > > > So, which version is needed to run the dme1737 on the asus board (W=
hich I think doesnt have the
> > > > SCH3114 Super I/O chip)?
> > > >

> >
> > However, I get strange temperatures for the cpu. With the fan at 3000 r=
pm and idle cpu I get a temperature
> > of 17 =B0C, while room temperature is 20=B0C. I think this is not possi=
ble.
>=20
> That is strange indeed. Can you reproduce this and then unload the
> dme1737 module and run 'i2cdump 0 0x2e' and post the output?
>=20

Here it is. First sensors output (I installed a patch to make k8temp work o=
n my brandnew AMD BE-2350 and=20
results seem to be reasonable. However there is a discussion about this pat=
ch and I am not sure it is ok):
dme1737-i2c-0-2e
Adapter: SMBus nForce2 adapter at 4c00
V5stby:    +0.00 V  (min =3D  +0.00 V, max =3D  +6.64 V)  ALARM
Vccp:      +1.09 V  (min =3D  +0.00 V, max =3D  +2.99 V)
V3.3:      +3.27 V  (min =3D  +0.00 V, max =3D  +4.38 V)
V5:        +4.94 V  (min =3D  +0.00 V, max =3D  +6.64 V)
V12:      +11.77 V  (min =3D  +0.00 V, max =3D +15.94 V)
V3.3stby:  +3.29 V  (min =3D  +0.00 V, max =3D  +4.38 V)
Vbat:      +2.98 V  (min =3D  +0.00 V, max =3D  +4.38 V)
Int Temp:    +31=B0C  (low  =3D  -127=B0C, high =3D  +127=B0C)
CPU Temp:    +16=B0C  (low  =3D  -127=B0C, high =3D  +127=B0C)
CPU_Fan:  3010 RPM  (min =3D    0 RPM)
ERROR: Can't get fan3 data!
ERROR: Can't get fan5 data!
ERROR: Can't get fan6 data!
CPU_PWM:   255      (enable =3D 0, freq =3D  25000 Hz)
ERROR: Can't get pwm5 data!
ERROR: Can't get pwm6 data!
cpu0_vid: +1.550 V  (VRM Version 2.4)

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:
             +29=B0C
Core0 Temp:
             +32=B0C
Core1 Temp:
             +36=B0C
Core1 Temp:
             +34=B0C

And here the output from i2cdump. I had to modprobe i2c-dev to make it work=
. Is this normal?

lisa:/home/jba# i2cdump 0 0x2e
No size specified (using byte-data access)
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x2e, mode byte
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
20: 00 5d be bd bc 80 1e 0f fe 06 ff ff ff ff ff ff    .]????????......
30: ff ff ff 00 00 00 00 00 00 00 00 00 00 00 5c 8a    ..............\?
40: 05 91 40 00 00 ff 00 ff 00 ff 00 ff 00 ff 81 7f    ??@...........??
50: 81 7f 81 7f ff ff ff ff ff ff ff ff 62 62 62 cb    ????........bbb?
60: cb bb e0 00 55 80 80 5a 5a 33 64 64 45 40 40 00    ???.U??ZZ3ddE@@.
70: ff ff ff 09 09 09 09 09 09 00 30 00 40 00 ec 18    ...??????.0.@.??
80: 7e a4 0e 00 42 90 3d 90 35 00 4d 4d 0b 0b 0c 00    ~??.B?=3D?5.MM???.
90: 04 04 04 04 0c 0c 0c 5a f1 bf ad 00 ff 00 ff 00    ???????Z???.....
a0: 00 00 0c 00 02 00 00 0b 0b fe ff fe ff ff ff ff    ..?.?..???.?....
b0: ff 00 00 00 00 00 28 28 0e 0e 2b 2b 00 00 00 00    ......((??++....
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 0f 00 00 00 00 00 00 00 00 00 00 00 00 00 00    .?..............
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................



>=20
> > I now use fancontrol which turns fan speed to 0 rpm. Here is the output=
 of sensors:
> >
> > dme1737-i2c-0-2e
> > Adapter: SMBus nForce2 adapter at 4c00
> > V5stby:    +0.00 V  (min =3D  +0.00 V, max =3D  +6.64 V)  ALARM
> > Vccp:      +1.10 V  (min =3D  +0.00 V, max =3D  +2.99 V)
> > V3.3:      +3.28 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> > V5:        +4.94 V  (min =3D  +0.00 V, max =3D  +6.64 V)
> > V12:      +11.80 V  (min =3D  +0.00 V, max =3D +15.94 V)
> > V3.3stby:  +3.29 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> > Vbat:      +2.98 V  (min =3D  +0.00 V, max =3D  +4.38 V)
> > Int Temp:    +34=B0C  (low  =3D  -127=B0C, high =3D  +127=B0C)
> > CPU Temp:    +29=B0C  (low  =3D  -127=B0C, high =3D  +127=B0C)
> > CPU_Fan:     0 RPM  (min =3D    0 RPM)
> > ERROR: Can't get fan3 data!
> > ERROR: Can't get fan5 data!
> > ERROR: Can't get fan6 data!
> > CPU_PWM:     0      (enable =3D 1, freq =3D  25000 Hz)
> > ERROR: Can't get pwm5 data!
> > ERROR: Can't get pwm6 data!
> > cpu0_vid: +1.550 V  (VRM Version 2.4)
> >
> > I think 29 =B0C is also very low for idle and no fan, even for my AMD B=
E-2350
> > (45 w maximum power consumption). Also, Int-Temperature (is this board =
temperature?)
> > is higher than cpu- temperature. This changes only for high load, where
> > cpu-temperature increases more than int-temperature.
>=20
> That's possible. The Int-temp is the dme1737 internal temperature, not
> the 'board' temperature. Depending on how hot the chip itself is this
> temperature can be rather high.
>=20
>=20
> > At first I thought that temperature calculation is wrong in lm-sensors.=
 However,
> > BIOS shows nearly the same temperatures.
>=20
> There's not much that can be done wrong here. All the driver does is
> convert from unsigned to signed. Sensors itself doesn't do any
> conversion.
>=20

So maybe the reason for the low temperature is just the measurement error? =
Maybe the real
temperature is 23 =B0 and the error is 7 K?

Juergen
___________________________________________________________________________=
___
Jetzt neu! Im riesigen WEB.DE Club SmartDrive Dateien freigeben und mit=20
Freunden teilen! http://www.freemail.web.de/club/smartdrive_ttc.htm/?mc=021=
134


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
