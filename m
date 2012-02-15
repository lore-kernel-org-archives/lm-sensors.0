From: =?ISO-8859-1?Q?Tom=E0s?= Deltell Bonell <tomasdeltell@gmx.es>
Date: Wed, 15 Feb 2012 13:08:21 +0000
Subject: Re: [lm-sensors] Unsuported ITE chipset 0x8771
Message-Id: <21107592.txOTubfo4S@tatil>
List-Id: <lm-sensors.vger.kernel.org>
References: <6CFD278BAABA444AAA6A1BAC172498CD@adminDator>
In-Reply-To: <6CFD278BAABA444AAA6A1BAC172498CD@adminDator>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mi=E9 15 Feb 2012 09:19:12 usted escribi=F3:
> Hi Tom=E0s,
>=20
> On Mon, 13 Feb 2012 11:54:47 +0100, Tom=E0s Deltell Bonell wrote:
> > > I have bought a Asus E35M1-I DELUXE motherboard and it uses the k10te=
mp
> > > module for checking the CPU temperature. And it works correctly.
> > > But the fan and voltage monitoring is not supported at this time by l=
m-
> > > sensors.
> >=20
> > I've also have this motherboard.
> >=20
> > > Do anyone have any idea on how to get this supported or if any current
> > > module will work with some editing?
> > > If I understand the all mighty google =3D) then it's a ITE chipset th=
at is
> > > used for reporting fan speed.
> > >=20
> > > The latest lm-sensors give me following information
> > > Trying family `ITE'...                                      Yes
> > > Found unknown chip with ID 0x8771
> > >=20
> > >     (logical device 4 has address 0x290, could be sensors)
> > >=20
> > > Probing for Super-I/O at 0x4e/0x4f
>=20
> Can you please provide register dumps from an IT8771E chip?
>=20
> # isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 4

#  isadump -k 0x87,0x01,0x55,0x55 0x2e 0x2f 4
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x2e and data register 0x2f.
Probing bank 4 using bank register 0x07.
Continue? [Y/n]=20
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00 00=20
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
20: 87 71 00 00 00 00 ff 00 22 00 00 40 03 00 00 00=20
30: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
60: 02 90 02 30 00 00 00 00 00 00 00 00 00 00 00 00=20
70: 00 02 00 00 04 04 00 00 00 00 00 00 00 00 00 00=20
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=20
f0: 00 80 00 00 00 00 f0 00 01 00 00 00 00 00 00 00

> # isadump 0x295 0x296
>=20

#  isadump 0x295 0x296
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x295 and data register 0x296.
Continue? [Y/n]=20
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 19 02 ed 02 37 ff 07 37 ff 07 49 0f 00 a4 ff 00=20
10: bf f6 ff 3b c7 80 00 00 05 ff 00 76 fa f5 f5 f5=20
20: 2f ba f2 8b ba f4 ba 8d 89 1f 12 f8 80 3c 33 33=20
30: e0 b3 d5 67 4f 5f 5f c6 fe 7e f4 fb 88 85 5b 76=20
40: 4e f3 df 97 7e bf 5f 40 ad 6a d4 00 ff ff ff ff=20
50: ff 38 7f 7f 7f 40 00 00 90 00 3d 12 60 00 00 00=20
60: 00 14 46 5a 14 41 0f ff 00 7f 7f ff 00 00 0f ff=20
70: 7f 7f 7f 80 00 00 0f ff ff ff ff ff ff ff ff ff=20
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 22 02 02=20
90: ff 00 00 00 ff 00 00 00 40 00 00 00 00 e2 02 08=20
a0: 20 e0 e0 e0 e0 e0 e0 ff ff ff ff ff ff ff ff ff=20
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=20
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=20
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=20
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=20
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

And there are result of sensors command after I execute "modprobe it87=20
force_id=3D0x8721":


# sensors
it8721-isa-0290
Adapter: ISA adapter
in0:          +1.36 V  (min =3D  +2.15 V, max =3D  +2.69 V)  ALARM
in1:          +2.23 V  (min =3D  +1.24 V, max =3D  +2.56 V)
in2:          +2.90 V  (min =3D  +1.14 V, max =3D  +0.95 V)  ALARM
+3.3V:        +3.34 V  (min =3D  +4.75 V, max =3D  +2.28 V)  ALARM
in4:          +2.23 V  (min =3D  +1.51 V, max =3D  +3.05 V)
in5:          +2.93 V  (min =3D  +3.01 V, max =3D  +2.93 V)  ALARM
in6:          +2.23 V  (min =3D  +1.60 V, max =3D  +1.63 V)  ALARM
3VSB:         +3.38 V  (min =3D  +2.83 V, max =3D  +2.18 V)  ALARM
Vbat:         +3.29 V =20
fan1:         453 RPM  (min =3D   22 RPM)
fan2:           0 RPM  (min =3D   10 RPM)  ALARM
temp1:        +31.0 C  (low  =3D -13.0 C, high =3D +78.0 C)  sensor =3D the=
rmistor
temp2:        +19.0 C  (low  =3D -105.0 C, high =3D -33.0 C)  ALARM  sensor=
 =3D=20
thermistor
temp3:         -8.0 C  (low  =3D -65.0 C, high =3D +126.0 C)  sensor =3D th=
ermistor
intrusion0:  OK

k10temp-pci-00c3
Adapter: PCI adapter
temp1:        +46.4 C  (high =3D +70.0 C)
                       (crit =3D +100.0 C, hyst =3D +97.0 C)

radeon-pci-0008
Adapter: PCI adapter
temp1:        +46.0 C

> > If you force modprobe of it87 module to behave as chipset 0x8721, you c=
an
> > see that you can see temperature of the sensors, the speed fans and
> > voltages (not correct values for voltages)
>=20
> Voltage values always need scaling, at least for +5V, +12V and 5VSB,
> and these days also even for +3.3V and 3VSB as the ADC ranges tend to
> decrease (from the original 4.08V to 3.06V or even 2.04V.)
>=20
> The only way to ensure if voltage values are somewhat correct is to try
> and configure for the specific board. Some values should directly match
> what the BIOS reports, in particular the DIMM, AGP, I/O and Vtt
> voltages as they are all below 2V. If these are correct then it means
> we got the ADC range correct, and it's only a matter of finding the
> right labels and scaling factors.
>=20
> I have started writing a guide for this:
> http://www.lm-sensors.org/wiki/VoltageLabelsAndScaling
>=20
> Please follow it and report your findings here. Then I will continue
> writing the guide, using your board as an example.
>=20

I will read your guide and report here, if I found this values in BIOS :P

> > > I'm building a quiet htpc and whould like to be able to controll and
> > > monitor the fan speed.
> > > Is there anything I can do to help to get this chipset supported? I'm
> > > not a
> > > C programmer but I can do some test on my machine.
> >=20
> > Here [1] you can see more users with this problem (generated by Asus). =
The
> > only thing we need to have a functional driver is the datasheet of this
> > 'confidential' chipset made by ITE for Asus motherboards. This is the
> > standard answer you get if you ask for datasheet:
> >=20
> > "Thank you for contacting ASUS Customer Service Department Iberica.
> >=20
> > We regret but issues of confidentiality, we can not
> > provide the information that tells us.
> >=20
> > Sincerely,
> >=20
> > Iberian ASUS Customer Care"
> >=20
> >=20
> > Is there anything that we as users can do?
>=20
> Unfortunately I think not. All you can do is publicly express your
> sadness and buy hardware from a different vendor next time. That being
> said, there is no guarantee that you will be better served by a
> different vendor. While we have good contacts at Fintek and Nuvoton for
> example, and manage to get datasheets for their newer chips easily, ITE
> is totally unfriendly to us these days (which is sad as our relations
> used to be very good a few years ago.) So any board with an ITE chip
> will make hardware monitoring difficult or impossible, regardless of the
> board vendor.

Is there an alternative way to get needed information to create the driver =

without the datasheet?

Thank you for your help.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
